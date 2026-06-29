
import Speech
import AVFoundation
import Translation
import Combine

/// All mutable state and AVAudioEngine access is confined to the main thread.
/// AVAudioSession activation/deactivation (which may block) is offloaded to
/// `audioQueue`, but the engine is always set up and torn down on main.
@MainActor
final class TranscriptionEngine: ObservableObject {

    @Published private(set) var entries: [TranscriptEntry] = []
    @Published private(set) var isListening: Bool = false
    @Published private(set) var errorMessage: String? = nil
    @Published private(set) var translationUnavailableNote: String? = nil

    private let targetLanguageCode: String
    private var audioEngine: AVAudioEngine?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var partialEntryID: UUID?

    /// Used only for AVAudioSession activate/deactivate, which must not block main.
    private let audioQueue = DispatchQueue(label: "com.app.transcription.audio", qos: .userInitiated)

    nonisolated init(targetLanguageCode: String) {
        self.targetLanguageCode = targetLanguageCode
    }

    // MARK: - Public API

    func start() {
        guard !isListening else { return }
        SFSpeechRecognizer.requestAuthorization { [weak self] status in
            // This callback arrives on an arbitrary background queue.
            DispatchQueue.main.async {
                guard let self else { return }
                guard status == .authorized else {
                    self.publishError("transcribe_permission_denied"); return
                }
                self.requestMicPermission()
            }
        }
    }

    func stop() {
        tearDown()
    }

    func clearEntries() {
        entries.removeAll()
        partialEntryID = nil
    }

    // MARK: - Permission Handling (main thread)

    private func requestMicPermission() {
        #if os(iOS)
        let handler: (Bool) -> Void = { [weak self] granted in
            // Permission callbacks arrive on an arbitrary queue — bounce to main.
            DispatchQueue.main.async {
                guard granted else { self?.publishError("transcribe_permission_denied"); return }
                self?.activateAudioSessionThenStart()
            }
        }
        if #available(iOS 17.0, *) {
            AVAudioApplication.requestRecordPermission(completionHandler: handler)
        } else {
            AVAudioSession.sharedInstance().requestRecordPermission(handler)
        }
        #elseif os(macOS)
        AVCaptureDevice.requestAccess(for: .audio) { [weak self] granted in
            // Permission callbacks arrive on an arbitrary queue — bounce to main.
            DispatchQueue.main.async {
                guard granted else { self?.publishError("transcribe_permission_denied"); return }
                self?.startRecognition()
            }
        }
        #else
        startRecognition()
        #endif
    }

    // MARK: - Audio Session Activation (iOS only)

    #if os(iOS)
    /// Activates AVAudioSession on a background queue to avoid blocking the main
    /// thread, then hops back to the MainActor to safely set up AVAudioEngine.
    private func activateAudioSessionThenStart() {
        // Capture as nonisolated value before leaving the actor.
        let langCode = targetLanguageCode
        audioQueue.async { [weak self] in
            do {
                let session = AVAudioSession.sharedInstance()
                try session.setCategory(.record, mode: .measurement, options: .duckOthers)
                try session.setActive(true, options: .notifyOthersOnDeactivation)
            } catch {
                            Task { @MainActor [weak self] in self?.publishError("transcribe_error") }
                            return
                        }
                        Task { @MainActor [weak self] in self?.startRecognition() }
        }
    }
    #endif

    // MARK: - Recognition Setup (main thread only)

    /// AVAudioEngine.inputNode MUST be accessed on the main thread.
    private func startRecognition() {
        guard
            let recognizer = SFSpeechRecognizer(locale: Locale(identifier: targetLanguageCode))
                          ?? SFSpeechRecognizer(),
            recognizer.isAvailable
        else { publishError("transcribe_error"); return }

        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        request.requiresOnDeviceRecognition = false

        let engine = AVAudioEngine()
        let node   = engine.inputNode       // ✅ safe — we are on the main thread
        let fmt    = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 4096, format: fmt) { [weak request] buf, _ in
            request?.append(buf)
        }

        do {
            engine.prepare()
            try engine.start()
        } catch {
            node.removeTap(onBus: 0)
            publishError("transcribe_error")
            return
        }

        audioEngine        = engine
        recognitionRequest = request
        let langCode       = targetLanguageCode

        recognitionTask = recognizer.recognitionTask(with: request) { [weak self] result, error in
                    let text    = result?.bestTranscription.formattedString
                    let isFinal = result?.isFinal ?? false
                    let errCode = (error as NSError?)?.code
                    Task { @MainActor [weak self] in
                        guard let self else { return }
                        if let text { self.handleResult(text: text, isFinal: isFinal) }
                        if let code = errCode, ![216, 301, 1110].contains(code), self.isListening {
                            self.errorMessage = Localizer.string("transcribe_error", langCode: langCode)
                        }
                    }
                }

        isListening  = true
        errorMessage = nil
    }

    // MARK: - Teardown (main thread only)

    /// AVAudioEngine.inputNode MUST be accessed on the main thread.
    private func tearDown() {
        recognitionTask?.cancel()
        recognitionTask = nil
        recognitionRequest?.endAudio()
        recognitionRequest = nil

        if let engine = audioEngine {
            engine.inputNode.removeTap(onBus: 0)    // ✅ safe — we are on the main thread
            if engine.isRunning { engine.stop() }
        }
        audioEngine = nil

        // Deactivate AVAudioSession off main to avoid blocking UI.
        #if os(iOS)
        audioQueue.async {
            try? AVAudioSession.sharedInstance().setActive(
                false, options: .notifyOthersOnDeactivation
            )
        }
        #endif

        if let pid = partialEntryID,
           let idx = entries.firstIndex(where: { $0.id == pid }) {
            entries[idx].isPartial = false
        }
        partialEntryID = nil
        isListening    = false
    }

    // MARK: - Result Handling (main thread only)

    private func handleResult(text: String, isFinal: Bool) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        if let pid = partialEntryID, let idx = entries.firstIndex(where: { $0.id == pid }) {
            entries[idx].text      = trimmed
            entries[idx].isPartial = !isFinal
            if isFinal {
                let eid = entries[idx].id
                partialEntryID = nil
                translateInPlace(id: eid, text: trimmed)
            }
        } else {
            let entry = TranscriptEntry(text: trimmed, isPartial: !isFinal)
            entries.append(entry)
            if !isFinal {
                partialEntryID = entry.id
            } else {
                translateInPlace(id: entry.id, text: trimmed)
            }
        }
    }

    private func translateInPlace(id: UUID, text: String) {
        guard #available(iOS 17.4, macOS 14.4, *) else {
            if translationUnavailableNote == nil {
                translationUnavailableNote = "Translation requires iOS 17.4 or later."
            }
            return
        }
        guard let session = TranslationBridge.session else { return }
        Task { [weak self] in
            guard let self,
                  let translated = try? await session.translate(text).targetText,
                  let idx = self.entries.firstIndex(where: { $0.id == id })
            else { return }
            self.entries[idx].text = translated
        }
    }

    // MARK: - Error Publishing

    private func publishError(_ key: String) {
        errorMessage = Localizer.string(key, langCode: targetLanguageCode)
        isListening  = false
    }
}

@available(iOS 17.4, macOS 14.4, *)
enum TranslationBridge {
    static var session: TranslationSession? = nil
}

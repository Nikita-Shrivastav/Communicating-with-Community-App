import Foundation
import Speech
import AVFoundation
import Translation

// MARK: - Transcript Entry & Speaker Role are in TranscriptEntry.swift

// MARK: - Transcription Engine
//
// Kept entirely off @MainActor — SFSpeechRecognizer and AVAudioEngine are not
// safe to use on the main actor. All UI-visible state is published back to the
// main thread explicitly via DispatchQueue.main.async.
//
// The SwiftUI view observes this class via @State, which handles the
// main-thread observation automatically.

@Observable
final class TranscriptionEngine {

    // MARK: - Published state (mutated only on main queue)

    private(set) var entries: [TranscriptEntry] = []
    private(set) var isListening: Bool = false
    private(set) var errorMessage: String? = nil
    var activeSpeakerRole: SpeakerRole = .other
    private(set) var translationUnavailableNote: String? = nil

    // MARK: - Private

    private let targetLanguageCode: String
    private var audioEngine: AVAudioEngine?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var partialEntryID: UUID?

    // Dedicated serial queue for all audio + recognition work
    private let audioQueue = DispatchQueue(label: "com.app.transcription.audio", qos: .userInitiated)

    // MARK: - Init

    init(targetLanguageCode: String) {
        self.targetLanguageCode = targetLanguageCode
    }

    // MARK: - Public API

    func start() {
        guard !isListening else { return }

        // Request speech permission on main, then proceed on audioQueue
        SFSpeechRecognizer.requestAuthorization { [weak self] status in
            guard let self else { return }
            guard status == .authorized else {
                self.publishError("transcribe_permission_denied")
                return
            }
            self.requestMicThenStart()
        }
    }

    func stop() {
        audioQueue.async { [weak self] in
            self?.tearDown()
        }
    }

    func clearEntries() {
        DispatchQueue.main.async { [weak self] in
            self?.entries.removeAll()
            self?.partialEntryID = nil
        }
    }

    // MARK: - Private: Permission → Start chain

    private func requestMicThenStart() {
        #if os(iOS)
        if #available(iOS 17.0, *) {
            AVAudioApplication.requestRecordPermission { [weak self] granted in
                guard granted else { self?.publishError("transcribe_permission_denied"); return }
                self?.beginOnAudioQueue()
            }
        } else {
            AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
                guard granted else { self?.publishError("transcribe_permission_denied"); return }
                self?.beginOnAudioQueue()
            }
        }
        #elseif os(macOS)
        AVCaptureDevice.requestAccess(for: .audio) { [weak self] granted in
            guard granted else { self?.publishError("transcribe_permission_denied"); return }
            self?.beginOnAudioQueue()
        }
        #else
        beginOnAudioQueue()
        #endif
    }

    private func beginOnAudioQueue() {
        audioQueue.async { [weak self] in
            self?.startRecognition()
        }
    }

    // MARK: - Private: Recognition (runs on audioQueue)

    private func startRecognition() {
        // Audio session setup
        #if os(iOS)
        do {
            let s = AVAudioSession.sharedInstance()
            try s.setCategory(.record, mode: .measurement, options: .duckOthers)
            try s.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            publishError("transcribe_error")
            return
        }
        #endif

        // Recogniser — fall back to device locale if target language not available
        guard
            let recognizer = SFSpeechRecognizer(locale: Locale(identifier: targetLanguageCode))
                          ?? SFSpeechRecognizer(),
            recognizer.isAvailable
        else {
            publishError("transcribe_error")
            return
        }

        // Request
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        request.requiresOnDeviceRecognition = false

        // Audio engine + tap
        let engine = AVAudioEngine()
        let node   = engine.inputNode
        let fmt    = node.outputFormat(forBus: 0)

        node.installTap(onBus: 0, bufferSize: 4096, format: fmt) { [weak request] buf, _ in
            request?.append(buf)   // append is thread-safe per Apple docs
        }

        do {
            engine.prepare()
            try engine.start()
        } catch {
            node.removeTap(onBus: 0)
            publishError("transcribe_error")
            return
        }

        // Store references — still on audioQueue here, no main-actor access
        self.audioEngine       = engine
        self.recognitionRequest = request

        // Recognition task — callback fires on an internal Speech queue
        let langCode = targetLanguageCode
        self.recognitionTask = recognizer.recognitionTask(with: request) { [weak self] result, error in
            guard let self else { return }

            // Copy values from result immediately on whatever thread we're on
            let text:    String? = result?.bestTranscription.formattedString
            let isFinal: Bool    = result?.isFinal ?? false
            let errCode: Int?    = (error as NSError?)?.code

            // All UI state mutations happen on the main queue
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }

                if let text {
                    self.handleResult(text: text, isFinal: isFinal)
                }

                if let code = errCode, ![216, 301, 1110].contains(code) {
                    if self.isListening {
                        self.errorMessage = Localizer.string("transcribe_error", langCode: langCode)
                    }
                }
            }
        }

        // Signal "we are live" on main queue
        DispatchQueue.main.async { [weak self] in
            self?.isListening = true
            self?.errorMessage = nil
        }
    }

    // MARK: - Private: Teardown (runs on audioQueue)

    private func tearDown() {
        recognitionTask?.cancel()
        recognitionTask = nil

        recognitionRequest?.endAudio()
        recognitionRequest = nil

        if let engine = audioEngine {
            engine.inputNode.removeTap(onBus: 0)
            if engine.isRunning { engine.stop() }
        }
        audioEngine = nil

        #if os(iOS)
        try? AVAudioSession.sharedInstance().setActive(
            false, options: .notifyOthersOnDeactivation
        )
        #endif

        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if let pid = self.partialEntryID,
               let idx = self.entries.firstIndex(where: { $0.id == pid }) {
                self.entries[idx].isPartial = false
            }
            self.partialEntryID = nil
            self.isListening    = false
        }
    }

    // MARK: - Private: Result Handling (runs on main queue)

    private func handleResult(text: String, isFinal: Bool) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let role = activeSpeakerRole

        if let pid = partialEntryID,
           let idx = entries.firstIndex(where: { $0.id == pid }) {
            entries[idx].text      = trimmed
            entries[idx].isPartial = !isFinal
            if isFinal {
                let entryID = entries[idx].id
                partialEntryID = nil
                if role == .other { translateInPlace(id: entryID, text: trimmed) }
            }
        } else {
            let entry = TranscriptEntry(text: trimmed, role: role, isPartial: !isFinal)
            entries.append(entry)
            if !isFinal {
                partialEntryID = entry.id
            } else if role == .other {
                translateInPlace(id: entry.id, text: trimmed)
            }
        }
    }

    // MARK: - Private: Translation (called from main queue, async)

    private func translateInPlace(id: UUID, text: String) {
        guard #available(iOS 17.4, macOS 14.4, *) else {
            if translationUnavailableNote == nil {
                translationUnavailableNote = "Translation requires iOS 17.4 or later."
            }
            return
        }
        guard let session = TranslationBridge.session else { return }

        Task { @MainActor [weak self] in
            guard let self else { return }
            guard let translated = try? await session.translate(text).targetText else { return }
            if let idx = self.entries.firstIndex(where: { $0.id == id }) {
                self.entries[idx].text = translated
            }
        }
    }

    // MARK: - Private: Error Helper

    private func publishError(_ key: String) {
        let msg = Localizer.string(key, langCode: targetLanguageCode)
        DispatchQueue.main.async { [weak self] in
            self?.errorMessage = msg
            self?.isListening  = false
        }
    }
}

// MARK: - Translation Bridge

@available(iOS 17.4, macOS 14.4, *)
enum TranslationBridge {
    /// Set by TranscribeView via the `.translationTask` modifier.
    static var session: TranslationSession? = nil
}

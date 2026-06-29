import Foundation
import Speech
import AVFoundation
import Translation

// MARK: - Transcription Engine

@Observable
@MainActor
final class TranscriptionEngine {

    // MARK: - Public State

    private(set) var entries: [TranscriptEntry] = []
    private(set) var isListening: Bool = false
    private(set) var errorMessage: String? = nil
    var activeSpeakerRole: SpeakerRole = .other
    private(set) var translationUnavailableNote: String? = nil

    // MARK: - Private Properties

    private let targetLanguageCode: String

    // Audio engine is recreated each session to avoid stale-tap crashes
    private var audioEngine: AVAudioEngine? = nil
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var speechRecognizer: SFSpeechRecognizer?
    private var partialEntryID: UUID? = nil

    // MARK: - Init

    init(targetLanguageCode: String) {
        self.targetLanguageCode = targetLanguageCode
    }

    // MARK: - Public API

    func start() async {
        guard !isListening else { return }
        errorMessage = nil

        // 1. Request permissions
        let speechGranted = await requestSpeechPermission()
        guard speechGranted else {
            setError(Localizer.string("transcribe_permission_denied", langCode: targetLanguageCode))
            return
        }

        let micGranted = await requestMicrophonePermission()
        guard micGranted else {
            setError(Localizer.string("transcribe_permission_denied", langCode: targetLanguageCode))
            return
        }

        // 2. Begin recognition
        do {
            try beginRecognition()
        } catch {
            setError(Localizer.string("transcribe_error", langCode: targetLanguageCode))
        }
    }

    func stop() {
        // Tear down in the right order to avoid EXC_BAD_ACCESS
        recognitionTask?.cancel()
        recognitionTask = nil

        recognitionRequest?.endAudio()
        recognitionRequest = nil

        if let engine = audioEngine {
            if engine.isRunning {
                engine.inputNode.removeTap(onBus: 0)
                engine.stop()
            }
        }
        audioEngine = nil

        // Mark any in-progress partial entry as final
        if let pid = partialEntryID,
           let idx = entries.firstIndex(where: { $0.id == pid }) {
            entries[idx].isPartial = false
        }
        partialEntryID = nil
        isListening = false

        #if os(iOS)
        try? AVAudioSession.sharedInstance().setActive(
            false,
            options: .notifyOthersOnDeactivation
        )
        #endif
    }

    func clearEntries() {
        entries.removeAll()
        partialEntryID = nil
    }

    // MARK: - Private: Permissions

    private func requestSpeechPermission() async -> Bool {
        await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }

    private func requestMicrophonePermission() async -> Bool {
        #if os(iOS)
        if #available(iOS 17.0, *) {
            return await AVAudioApplication.requestRecordPermission()
        } else {
            return await withCheckedContinuation { continuation in
                AVAudioSession.sharedInstance().requestRecordPermission { granted in
                    continuation.resume(returning: granted)
                }
            }
        }
        #elseif os(macOS)
        return await withCheckedContinuation { continuation in
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                continuation.resume(returning: granted)
            }
        }
        #else
        return true
        #endif
    }

    // MARK: - Private: Recognition
    //
    // Note: NOT async — AVAudioEngine.installTap must be called synchronously
    // before audioEngine.start(), otherwise the tap callback races.

    private func beginRecognition() throws {
        // Create a fresh engine each session
        let engine = AVAudioEngine()
        self.audioEngine = engine

        // Set up recogniser — use target language so partials are in the right script
        let recognizer = SFSpeechRecognizer(locale: Locale(identifier: targetLanguageCode))
            ?? SFSpeechRecognizer()  // fallback to device locale

        guard let recognizer, recognizer.isAvailable else {
            throw RecognitionError.recognizerUnavailable
        }
        self.speechRecognizer = recognizer

        // Configure audio session on iOS
        #if os(iOS)
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        #endif

        // Build recognition request
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        request.requiresOnDeviceRecognition = false
        // Ask the recogniser to detect language automatically when possible
        if #available(iOS 16.0, macOS 13.0, *) {
            request.requiresOnDeviceRecognition = false
        }
        self.recognitionRequest = request

        // Install microphone tap BEFORE starting the engine
        let inputNode = engine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 4096, format: recordingFormat) { [weak self] buffer, _ in
            self?.recognitionRequest?.append(buffer)
        }

        // Start engine
        engine.prepare()
        try engine.start()
        isListening = true

        // Start recognition task
        let capturedRole = activeSpeakerRole
        recognitionTask = recognizer.recognitionTask(with: request) { [weak self] result, error in
            guard let self else { return }

            if let result {
                let text    = result.bestTranscription.formattedString
                let isFinal = result.isFinal
                Task { @MainActor [weak self] in
                    await self?.handleResult(text: text, isFinal: isFinal, role: capturedRole)
                }
            }

            if let error {
                let ns = error as NSError
                // Code 301 = no speech detected (not a real error)
                // Code 216 = cancelled by us via stop()
                let ignoredCodes = [216, 301, 1110]
                if !ignoredCodes.contains(ns.code) {
                    Task { @MainActor [weak self] in
                        self?.setError(
                            Localizer.string("transcribe_error", langCode: self?.targetLanguageCode ?? "en")
                        )
                    }
                }
            }
        }
    }

    // MARK: - Private: Result Handling

    private func handleResult(text: String, isFinal: Bool, role: SpeakerRole) async {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        // Translate if this is the other speaker
        let displayText: String
        let detectedCode: String?

        if role == .other {
            let (t, code) = await translate(text: trimmed)
            displayText  = t
            detectedCode = code
        } else {
            displayText  = trimmed
            detectedCode = nil
        }

        // Update existing partial entry or create a new one
        if let pid = partialEntryID,
           let idx = entries.firstIndex(where: { $0.id == pid }) {
            entries[idx].text                 = displayText
            entries[idx].isPartial            = !isFinal
            entries[idx].detectedLanguageCode = detectedCode
            if isFinal { partialEntryID = nil }
        } else {
            let entry = TranscriptEntry(
                text: displayText,
                role: role,
                isPartial: !isFinal,
                detectedLanguageCode: detectedCode
            )
            entries.append(entry)
            if !isFinal { partialEntryID = entry.id }
        }
    }

    // MARK: - Private: Translation

    private func translate(text: String) async -> (String, String?) {
        guard #available(iOS 17.4, macOS 14.4, *) else {
            if translationUnavailableNote == nil {
                translationUnavailableNote = "Translation requires iOS 17.4 or later."
            }
            return (text, nil)
        }
        return await performTranslation(text: text)
    }

    @available(iOS 17.4, macOS 14.4, *)
    private func performTranslation(text: String) async -> (String, String?) {
        guard let session = TranslationBridge.session else {
            // No session yet — return original text silently
            return (text, nil)
        }
        do {
            let response = try await session.translate(text)
            return (response.targetText, nil)
        } catch {
            return (text, nil)
        }
    }

    // MARK: - Private: Helpers

    private func setError(_ message: String) {
        errorMessage = message
        isListening  = false
    }

    private enum RecognitionError: Error {
        case recognizerUnavailable
    }
}

// MARK: - Translation Bridge

@available(iOS 17.4, macOS 14.4, *)
enum TranslationBridge {
    /// Set by TranscribeView via the `.translationTask` modifier.
    static var session: TranslationSession? = nil

    enum TranslationError: Error {
        case sessionNotAvailable
    }
}

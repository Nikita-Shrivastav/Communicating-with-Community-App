import Foundation

// MARK: - Transcript Entry

/// A single unit of transcribed (and optionally translated) speech shown in the transcript view.
struct TranscriptEntry: Identifiable {
    let id: UUID
    var text: String
    let timestamp: Date
    var isPartial: Bool
    var detectedLanguageCode: String?

    init(
        id: UUID = UUID(),
        text: String,
        timestamp: Date = Date(),
        isPartial: Bool = false,
        detectedLanguageCode: String? = nil
    ) {
        self.id = id
        self.text = text
        self.timestamp = timestamp
        self.isPartial = isPartial
        self.detectedLanguageCode = detectedLanguageCode
    }
}

import Foundation

// MARK: - Speaker Role

enum SpeakerRole {
    case user
    case other
}

// MARK: - Transcript Entry

struct TranscriptEntry: Identifiable {
    let id: UUID
    var text: String
    let role: SpeakerRole
    let timestamp: Date
    var isPartial: Bool
    var detectedLanguageCode: String?

    init(
        id: UUID = UUID(),
        text: String,
        role: SpeakerRole,
        timestamp: Date = Date(),
        isPartial: Bool = false,
        detectedLanguageCode: String? = nil
    ) {
        self.id = id
        self.text = text
        self.role = role
        self.timestamp = timestamp
        self.isPartial = isPartial
        self.detectedLanguageCode = detectedLanguageCode
    }
}



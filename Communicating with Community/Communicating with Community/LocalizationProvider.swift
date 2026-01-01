import Foundation

protocol LocalizationProvider {
    var languageCode: String { get }
    var displayName: String { get }
    var preferredVoiceCodes: [String] { get }
    var wordBank: [String] { get }
    var items: [NeedItem] { get }
    func categoryTitle(for category: NeedItem.Category) -> String
}

struct EnglishLocalizationProvider: LocalizationProvider {
    let languageCode: String = "en"
    let displayName: String = "English"
    let preferredVoiceCodes: [String] = ["en-US", "en-GB", "en-IN"]
    var wordBank: [String] { englishWordBank }
    var items: [NeedItem] { englishItems }
    
    func categoryTitle(for category: NeedItem.Category) -> String {
        switch category {
        case .need: return "Needs"
        case .want: return "Wants"
        case .feeling: return "Feelings"
        }
    }
}

struct HindiLocalizationProvider: LocalizationProvider {
    let languageCode: String = "hi"
    let displayName: String = "हिन्दी"
    let preferredVoiceCodes: [String] = ["hi-IN"]
    var wordBank: [String] { hindiWordBank }
    var items: [NeedItem] { hindiItems }
    
    func categoryTitle(for category: NeedItem.Category) -> String {
        switch category {
        case .need: return "ज़रूरतें"
        case .want: return "इच्छाएँ"
        case .feeling: return "भावनाएँ"
        }
    }
}

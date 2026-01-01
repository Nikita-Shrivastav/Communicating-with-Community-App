import Foundation

protocol LocalizationProvider {
    var languageCode: String { get }
    var displayName: String { get }
    var preferredVoiceCodes: [String] { get }
    var wordBank: [String] { get }
    var items: [NeedItem] { get }
}

struct EnglishLocalizationProvider: LocalizationProvider {
    let languageCode: String = "en"
    let displayName: String = "English"
    let preferredVoiceCodes: [String] = ["en-US", "en-GB", "en-IN"]
    var wordBank: [String] { englishWordBank }
    var items: [NeedItem] { englishItems }
}

struct HindiLocalizationProvider: LocalizationProvider {
    let languageCode: String = "hi"
    let displayName: String = "हिन्दी"
    let preferredVoiceCodes: [String] = ["hi-IN"]
    var wordBank: [String] { hindiWordBank }
    var items: [NeedItem] { hindiItems }
}

// MARK: - Localization helper
// Simple wrapper that looks up strings in Localizable.strings, with optional language override.
func L(_ key: String, _ langCode: String?) -> String {
    // If a specific language code is provided, try to load a bundle for it.
    if let langCode, let path = Bundle.main.path(forResource: langCode, ofType: "lproj"), let bundle = Bundle(path: path) {
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: key, comment: "")
    }
    // Fallback to main bundle (Base / system language)
    return NSLocalizedString(key, comment: "")
}

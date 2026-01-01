import Foundation

/// Runtime localizer that loads strings from a chosen language's .lproj bundle.
/// Usage: L("key", langCode)
struct Localizer {
    static func localized(_ key: String, languageCode: String?) -> String {
        // If a specific language code is provided, try to load its bundle.
        if let code = languageCode, let bundle = bundle(for: code) {
            let value = NSLocalizedString(key, tableName: nil, bundle: bundle, value: key, comment: "")
            return value
        }
        // Fallback to main bundle/system localization
        return NSLocalizedString(key, comment: "")
    }

    private static func bundle(for languageCode: String) -> Bundle? {
        // Normalize codes like "en-US" -> "en" and "hi-IN" -> "hi"
        let short = languageCode.split(separator: "-").first.map(String.init) ?? languageCode
        // Prefer full code first, then short code
        let preferredCodes = [languageCode, short]
        for code in preferredCodes {
            if let path = Bundle.main.path(forResource: code, ofType: "lproj"), let bundle = Bundle(path: path) {
                return bundle
            }
        }
        return nil
    }
}

/// Convenience free function for brevity
@inline(__always)
func L(_ key: String, _ languageCode: String?) -> String {
    Localizer.localized(key, languageCode: languageCode)
}

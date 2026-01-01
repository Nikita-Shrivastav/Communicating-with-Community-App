import Foundation

/// Runtime localizer that loads strings from a chosen language's .lproj bundle.
/// Usage: L("key", langCode)
struct Localizer {
    private static func strippedKeyForFallback(_ key: String) -> String? {
        let prefixes = ["prompt_", "label_", "title_", "button_", "menu_"]
        for p in prefixes {
            if key.hasPrefix(p) {
                return String(key.dropFirst(p.count))
            }
        }
        return nil
    }

    private static let hiInlineFallback: [String: String] = [
        // Main categories and navigation
        "choose_category": "श्रेणी चुनें",
        "sentence_builder": "वाक्य बनाएं",
        "back": "वापस",
        "info": "जानकारी",
        "change_language": "भाषा बदलें",
        
        // Language selection
        "choose_language_title": "भाषा चुनें",
        "hear_prompt": "संकेत सुनें",
        "prompt_select_language": "कृपया एक भाषा चुनें",
        "confirm_language_selected_en": "अंग्रेज़ी चुनी गई है",
        "confirm_language_selected_hi": "हिन्दी चुनी गई है",
        
        // Intro screen
        "start_using_board": "बोर्ड का उपयोग शुरू करें",
        "hear_quick_summary": "त्वरित सारांश सुनें",
        "quick_summary_text": "यह ऐप लोगों को चित्रों पर टैप करके, शब्द चुनकर या टाइप करके उनकी आवश्यकताओं, इच्छाओं, भावनाओं और कस्टम वाक्यों को संप्रेषित करने में मदद करता है।",
        
        // Prompts
        "prompt_choose_category": "कृपया एक श्रेणी चुनें",
        "prompt_sentence_builder": "वाक्य बनाने के लिए शब्दों पर टैप करें या अपना वाक्य टाइप करें",
        "prompt_back_to_menu": "मुख्य मेनू पर वापस जा रहे हैं",
        "prompt_info": "जानकारी पृष्ठ खोल रहे हैं",
        "prompt_choose_words": "कृपया शब्द चुनें",
        "prompt_type_sentence": "कृपया एक वाक्य टाइप करें",
        
        // Sentence builder
        "title_word_bank_sentence": "वाक्य बनाने के लिए शब्दों पर टैप करें",
        "speak_word_bank": "शब्द बैंक बोलें",
        "clear_words": "शब्द साफ़ करें",
        "type_your_sentence": "अपना वाक्य टाइप करें",
        "type_here": "यहाँ टाइप करें",
        "speak_typed_sentence": "टाइप किया वाक्य बोलें",
        "clear": "साफ़ करें",
        "word_bank": "शब्द बैंक"
    ]
    
    private static let enInlineFallback: [String: String] = [
        // Main categories and navigation
        "choose_category": "Choose Category",
        "sentence_builder": "Sentence Builder",
        "back": "Back",
        "info": "Info",
        "change_language": "Change Language",
        
        // Language selection
        "choose_language_title": "Choose Language",
        "hear_prompt": "Hear Prompt",
        "prompt_select_language": "Please select a language",
        "confirm_language_selected_en": "English selected",
        "confirm_language_selected_hi": "Hindi selected",
        
        // Intro screen
        "start_using_board": "Start Using the Board",
        "hear_quick_summary": "Hear a Quick Summary",
        "quick_summary_text": "This app helps people communicate their needs, wants, feelings, and custom sentences by tapping pictures, choosing words, or typing.",
        
        // Prompts
        "prompt_choose_category": "Please choose a category",
        "prompt_sentence_builder": "Tap words to build a sentence or type your own sentence",
        "prompt_back_to_menu": "Returning to main menu",
        "prompt_info": "Opening information page",
        "prompt_choose_words": "Please choose words",
        "prompt_type_sentence": "Please type a sentence",
        
        // Sentence builder
        "title_word_bank_sentence": "Tap words to build a sentence",
        "speak_word_bank": "Speak Word Bank",
        "clear_words": "Clear Words",
        "type_your_sentence": "Type Your Sentence",
        "type_here": "Type here",
        "speak_typed_sentence": "Speak Typed Sentence",
        "clear": "Clear",
        "word_bank": "Word Bank"
    ]

    private static func inlineFallback(for key: String, code: String?) -> String? {
        guard let code = code?.lowercased() else { return nil }
        if code == "hi" || code.hasPrefix("hi-") {
            if let v = hiInlineFallback[key] { return v }
            if let stripped = strippedKeyForFallback(key), let v2 = hiInlineFallback[stripped] { return v2 }
        } else if code == "en" || code.hasPrefix("en-") {
            if let v = enInlineFallback[key] { return v }
            if let stripped = strippedKeyForFallback(key), let v2 = enInlineFallback[stripped] { return v2 }
        }
        return nil
    }

    private static func resolveKey(_ key: String, code: String?, table: String) -> String? {
        // 1) Try explicitly requested language (full code), then its short form
        if let c = code {
            if let b = bundle(for: c), let v = lookup(key, in: b, table: table) { return v }
            if let short = c.split(separator: "-").first.map(String.init), short != c,
               let b2 = bundle(for: short), let v2 = lookup(key, in: b2, table: table) { return v2 }
        }
        // 2) Base
        if let base = baseBundle(), let vBase = lookup(key, in: base, table: table) { return vBase }
        // 3) English
        if let en = englishBundle(), let vEn = lookup(key, in: en, table: table) { return vEn }
        // 4) Main/system
        let systemValue = NSLocalizedString(key, tableName: table, bundle: .main, value: missingSentinel, comment: "")
        if systemValue != missingSentinel { return systemValue }
        return nil
    }

    static func localized(_ key: String, languageCode: String?) -> String {
        // Normalize empty or whitespace-only codes to nil
        let normalizedCode: String? = {
            guard let c = languageCode?.trimmingCharacters(in: .whitespacesAndNewlines), !c.isEmpty else { return nil }
            return c
        }()

        let table = "Localizable"

        // Helper to try a key in a specific language code (full then short)
        func tryInLanguage(_ key: String, code: String) -> String? {
            if let b = bundle(for: code), let v = lookup(key, in: b, table: table) { return v }
            if let short = code.split(separator: "-").first.map(String.init), short != code,
               let b2 = bundle(for: short), let v2 = lookup(key, in: b2, table: table) { return v2 }
            return nil
        }

        // 1) Try requested language (exact key)
        if let code = normalizedCode, let v = tryInLanguage(key, code: code) {
            return v
        }

        // 2) If key has a known prefix, try stripped key in requested language
        if let code = normalizedCode, let stripped = strippedKeyForFallback(key), let v = tryInLanguage(stripped, code: code) {
            return v
        }

        // 3) Inline fallback for the requested language (before falling back to English)
        if let inline = inlineFallback(for: key, code: normalizedCode) { return inline }

        // 4) Base localization
        if let base = baseBundle(), let vBase = lookup(key, in: base, table: table) { return vBase }
        if let stripped = strippedKeyForFallback(key), let base = baseBundle(), let vBase2 = lookup(stripped, in: base, table: table) { return vBase2 }

        // 5) English localization
        if let en = englishBundle(), let vEn = lookup(key, in: en, table: table) { return vEn }
        if let stripped = strippedKeyForFallback(key), let en = englishBundle(), let vEn2 = lookup(stripped, in: en, table: table) { return vEn2 }

        // 6) System/main bundle
        let systemValue = NSLocalizedString(key, tableName: table, bundle: .main, value: missingSentinel, comment: "")
        if systemValue != missingSentinel { return systemValue }
        if let stripped = strippedKeyForFallback(key) {
            let systemValue2 = NSLocalizedString(stripped, tableName: table, bundle: .main, value: missingSentinel, comment: "")
            if systemValue2 != missingSentinel { return systemValue2 }
        }

        // 7) Last resort: humanize stripped key if available
        let toHumanize = strippedKeyForFallback(key) ?? key
        return humanizedKey(from: toHumanize)
    }

    private static let missingSentinel = "⟪MISSING_LOCALIZED_VALUE⟫"

    private static func lookup(_ key: String, in bundle: Bundle, table: String) -> String? {
        let value = NSLocalizedString(key, tableName: table, bundle: bundle, value: missingSentinel, comment: "")
        return value == missingSentinel ? nil : value
    }

    private static func humanizedKey(from key: String) -> String {
        let baseKey = strippedKeyForFallback(key) ?? key
        let spaced = baseKey.replacingOccurrences(of: "_", with: " ")
        guard let first = spaced.first else { return baseKey }
        return String(first).uppercased() + spaced.dropFirst()
    }

    private static func baseBundle() -> Bundle? {
        if let path = Bundle.main.path(forResource: "Base", ofType: "lproj"), let bundle = Bundle(path: path) {
            return bundle
        }
        return nil
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

    private static func englishBundle() -> Bundle? {
        if let path = Bundle.main.path(forResource: "en", ofType: "lproj"), let bundle = Bundle(path: path) {
            return bundle
        }
        return nil
    }
}

extension Localizer {
    static func string(_ key: String, langCode: String?) -> String {
        localized(key, languageCode: langCode)
    }
}

/// Convenience free function for brevity
@inline(__always)
func L(_ key: String, _ languageCode: String?) -> String {
    Localizer.localized(key, languageCode: languageCode)
}

//
//  Communicating_with_CommunityTests.swift
//  Communicating with CommunityTests
//
//  Created by nikita on 9/17/25.
//

import Testing
@testable import Communicating_with_Community
import AVFoundation

// MARK: - Shared Fixtures

/// All six localization providers, used across multiple test suites.
private let allProviders: [any LocalizationProvider] = [
    EnglishLocalizationProvider(),
    HindiLocalizationProvider(),
    SpanishLocalizationProvider(),
    ChineseLocalizationProvider(),
    FrenchLocalizationProvider(),
    PortugueseLocalizationProvider(),
]

private let allLanguageCodes = ["en", "hi", "es", "zh", "fr", "pt"]

/// The 30 canonical image identifiers shared by every language provider.
private let canonicalImages: Set<String> = [
    "water", "food", "bed", "toilet", "help", "medicine", "break", "quiet", "hug", "space",
    "walk", "play", "mom", "dad", "brother", "sister", "friend", "outside", "watch", "music",
    "mad", "sad", "happy", "anxious", "scared", "jealous", "tired", "excited", "confused", "sick",
]

// MARK: - AppLanguage

@Suite("AppLanguage enum")
struct AppLanguageTests {

    @Test("All six expected languages are present")
    func allLanguagesPresent() {
        let codes = SpeechBoardView.AppLanguage.allCases.map(\.rawValue)
        #expect(codes.count == 6)
        for code in allLanguageCodes {
            #expect(codes.contains(code), "Missing language code: \(code)")
        }
    }

    @Test("Display names match expected native script")
    func displayNameValues() {
        #expect(SpeechBoardView.AppLanguage.english.displayName    == "English")
        #expect(SpeechBoardView.AppLanguage.hindi.displayName      == "हिन्दी")
        #expect(SpeechBoardView.AppLanguage.spanish.displayName    == "Español")
        #expect(SpeechBoardView.AppLanguage.chinese.displayName    == "中文")
        #expect(SpeechBoardView.AppLanguage.french.displayName     == "Français")
        #expect(SpeechBoardView.AppLanguage.portuguese.displayName == "Português")
    }

    @Test("Every language has at least one preferred voice code")
    func preferredVoiceCodesNonEmpty() {
        for language in SpeechBoardView.AppLanguage.allCases {
            #expect(!language.preferredVoiceCodes.isEmpty,
                    "No voice codes for \(language.rawValue)")
        }
    }

    @Test("Voice codes are BCP-47 formatted and start with the correct language prefix")
    func voiceCodeFormat() {
        let expectedPrefixes: [SpeechBoardView.AppLanguage: String] = [
            .english: "en", .hindi: "hi", .spanish: "es",
            .chinese: "zh", .french: "fr", .portuguese: "pt",
        ]
        for (language, prefix) in expectedPrefixes {
            for code in language.preferredVoiceCodes {
                #expect(code.hasPrefix(prefix),
                        "\(language.rawValue) voice code '\(code)' should start with '\(prefix)'")
                let isValidFormat = code.contains("-") || code.count == 2
                #expect(isValidFormat, "Unexpected BCP-47 format: '\(code)'")
            }
        }
    }

    @Test("AppLanguage can be initialised from a valid raw value")
    func rawValueInit() {
        for code in allLanguageCodes {
            #expect(SpeechBoardView.AppLanguage(rawValue: code) != nil,
                    "Could not create AppLanguage from '\(code)'")
        }
    }

    @Test("Invalid raw value returns nil")
    func invalidRawValue() {
        #expect(SpeechBoardView.AppLanguage(rawValue: "xx") == nil)
        #expect(SpeechBoardView.AppLanguage(rawValue: "")   == nil)
    }

    @Test("id equals rawValue")
    func idEqualsRawValue() {
        for language in SpeechBoardView.AppLanguage.allCases {
            #expect(language.id == language.rawValue)
        }
    }
}

// MARK: - LocalizationProviders

@Suite("LocalizationProviders")
struct LocalizationProviderTests {

    @Test("Every provider exposes the correct language code")
    func languageCodes() {
        #expect(EnglishLocalizationProvider().languageCode    == "en")
        #expect(HindiLocalizationProvider().languageCode      == "hi")
        #expect(SpanishLocalizationProvider().languageCode    == "es")
        #expect(ChineseLocalizationProvider().languageCode    == "zh")
        #expect(FrenchLocalizationProvider().languageCode     == "fr")
        #expect(PortugueseLocalizationProvider().languageCode == "pt")
    }

    @Test("Every provider has exactly 30 items (10 per category)")
    func itemCount() {
        for provider in allProviders {
            #expect(provider.items.count == 30,
                    "\(provider.languageCode) has \(provider.items.count) items, expected 30")
        }
    }

    @Test("Each provider has balanced categories — 10 needs, 10 wants, 10 feelings")
    func balancedCategories() {
        for provider in allProviders {
            let needs    = provider.items.filter { $0.category == .need }
            let wants    = provider.items.filter { $0.category == .want }
            let feelings = provider.items.filter { $0.category == .feeling }
            #expect(needs.count    == 10, "\(provider.languageCode) needs: \(needs.count)")
            #expect(wants.count    == 10, "\(provider.languageCode) wants: \(wants.count)")
            #expect(feelings.count == 10, "\(provider.languageCode) feelings: \(feelings.count)")
        }
    }

    @Test("No item has an empty text or image name")
    func itemsHaveNonEmptyFields() {
        for provider in allProviders {
            for item in provider.items {
                #expect(!item.text.isEmpty,
                        "\(provider.languageCode): empty text for image '\(item.image)'")
                #expect(!item.image.isEmpty,
                        "\(provider.languageCode): empty image name")
            }
        }
    }

    @Test("All items reference one of the 30 canonical image names")
    func itemsUseCanonicalImages() {
        for provider in allProviders {
            for item in provider.items {
                #expect(canonicalImages.contains(item.image),
                        "\(provider.languageCode): unknown image '\(item.image)'")
            }
        }
    }

    @Test("Each provider's word bank has more than 50 words with no empty entries")
    func wordBankNotEmpty() {
        for provider in allProviders {
            #expect(provider.wordBank.count > 50,
                    "\(provider.languageCode) word bank has only \(provider.wordBank.count) words")
            for word in provider.wordBank {
                #expect(!word.isEmpty, "\(provider.languageCode) contains empty word-bank entry")
            }
        }
    }

    @Test("Category titles are non-empty for all providers")
    func categoryTitlesNonEmpty() {
        for provider in allProviders {
            #expect(!provider.categoryTitle(for: .need).isEmpty)
            #expect(!provider.categoryTitle(for: .want).isEmpty)
            #expect(!provider.categoryTitle(for: .feeling).isEmpty)
        }
    }

    // MARK: Per-language spot-checks

    @Test("English provider: display name, category titles, and word bank essentials")
    func english() {
        let p = EnglishLocalizationProvider()
        #expect(p.displayName == "English")
        #expect(p.categoryTitle(for: .need)    == "Needs")
        #expect(p.categoryTitle(for: .want)    == "Wants")
        #expect(p.categoryTitle(for: .feeling) == "Feelings")
        for word in ["I", "water", "help", "please"] {
            #expect(p.wordBank.contains(word), "English word bank missing '\(word)'")
        }
    }

    @Test("Hindi provider: display name, category titles, and word bank essentials")
    func hindi() {
        let p = HindiLocalizationProvider()
        #expect(p.displayName == "हिन्दी")
        #expect(p.categoryTitle(for: .need)    == "ज़रूरतें")
        #expect(p.categoryTitle(for: .want)    == "इच्छाएँ")
        #expect(p.categoryTitle(for: .feeling) == "भावनाएँ")
        for word in ["मैं", "पानी", "मदद", "कृपया"] {
            #expect(p.wordBank.contains(word), "Hindi word bank missing '\(word)'")
        }
    }

    @Test("Spanish provider: display name, category titles, and word bank essentials")
    func spanish() {
        let p = SpanishLocalizationProvider()
        #expect(p.displayName == "Español")
        #expect(p.categoryTitle(for: .need)    == "Necesidades")
        #expect(p.categoryTitle(for: .want)    == "Deseos")
        #expect(p.categoryTitle(for: .feeling) == "Sentimientos")
        for word in ["yo", "agua", "ayuda", "por favor"] {
            #expect(p.wordBank.contains(word), "Spanish word bank missing '\(word)'")
        }
    }

    @Test("Chinese provider: display name, category titles, and word bank essentials")
    func chinese() {
        let p = ChineseLocalizationProvider()
        #expect(p.displayName == "中文")
        #expect(p.categoryTitle(for: .need)    == "需求")
        #expect(p.categoryTitle(for: .want)    == "想要")
        #expect(p.categoryTitle(for: .feeling) == "感受")
        for word in ["我", "水", "帮助", "请"] {
            #expect(p.wordBank.contains(word), "Chinese word bank missing '\(word)'")
        }
    }

    @Test("French provider: display name, category titles, and word bank essentials")
    func french() {
        let p = FrenchLocalizationProvider()
        #expect(p.displayName == "Français")
        #expect(p.categoryTitle(for: .need)    == "Besoins")
        #expect(p.categoryTitle(for: .want)    == "Envies")
        #expect(p.categoryTitle(for: .feeling) == "Émotions")
        for word in ["je", "eau", "aide", "s'il vous plaît"] {
            #expect(p.wordBank.contains(word), "French word bank missing '\(word)'")
        }
    }

    @Test("Portuguese provider: display name, category titles, and word bank essentials")
    func portuguese() {
        let p = PortugueseLocalizationProvider()
        #expect(p.displayName == "Português")
        #expect(p.categoryTitle(for: .need)    == "Necessidades")
        #expect(p.categoryTitle(for: .want)    == "Desejos")
        #expect(p.categoryTitle(for: .feeling) == "Sentimentos")
        for word in ["eu", "água", "ajuda", "por favor"] {
            #expect(p.wordBank.contains(word), "Portuguese word bank missing '\(word)'")
        }
        for code in p.preferredVoiceCodes {
            #expect(code.hasPrefix("pt"),
                    "Portuguese voice code '\(code)' should start with 'pt'")
        }
    }
}

// MARK: - NeedItem Model

@Suite("NeedItem model")
struct NeedItemTests {

    @Test("Properties are stored correctly")
    func propertyStorage() {
        let item = NeedItem(image: "water", text: "I need water", category: .need)
        #expect(item.image    == "water")
        #expect(item.text     == "I need water")
        #expect(item.category == .need)
    }

    @Test("Two separately created items have different ids")
    func uniqueIds() {
        let a = NeedItem(image: "play", text: "Play", category: .want)
        let b = NeedItem(image: "play", text: "Play", category: .want)
        #expect(a.id != b.id)
    }

    @Test("All three ItemCategory values are distinct")
    func categoriesDistinct() {
        #expect(ItemCategory.need    != ItemCategory.want)
        #expect(ItemCategory.want    != ItemCategory.feeling)
        #expect(ItemCategory.feeling != ItemCategory.need)
    }
}

// MARK: - EmojiMapper

@Suite("EmojiMapper")
struct EmojiMapperTests {

    @Test("Language-specific overrides take precedence over the base dictionary")
    func languageOverrides() {
        // Portuguese overrides
        #expect(EmojiMapper.emoji(for: "água",      languageCode: "pt") == "💧")
        #expect(EmojiMapper.emoji(for: "comida",    languageCode: "pt") == "🍽️")
        #expect(EmojiMapper.emoji(for: "banheiro",  languageCode: "pt") == "🚻")
        #expect(EmojiMapper.emoji(for: "ajuda",     languageCode: "pt") == "🆘")
        #expect(EmojiMapper.emoji(for: "por favor", languageCode: "pt") == "🙏")
        // English overrides
        #expect(EmojiMapper.emoji(for: "bathroom",  languageCode: "en") == "🚻")
        #expect(EmojiMapper.emoji(for: "play",      languageCode: "en") == "🧩")
        // Spanish overrides
        #expect(EmojiMapper.emoji(for: "baño",      languageCode: "es") == "🚻")
        #expect(EmojiMapper.emoji(for: "hospital",  languageCode: "es") == "🏥")
    }

    @Test("Base dictionary is used when no language override exists")
    func baseFallback() {
        #expect(EmojiMapper.emoji(for: "water",  languageCode: "en") == "💧")
        #expect(EmojiMapper.emoji(for: "happy",  languageCode: "en") == "😊")
        #expect(EmojiMapper.emoji(for: "school", languageCode: "en") == "🏫")
        #expect(EmojiMapper.emoji(for: "home",   languageCode: "en") == "🏠")
        #expect(EmojiMapper.emoji(for: "水",      languageCode: "zh") == "💧")
        #expect(EmojiMapper.emoji(for: "开心",    languageCode: "zh") == "😊")
        #expect(EmojiMapper.emoji(for: "पानी",    languageCode: "hi") == "💧")
    }

    @Test("Lookup is case-insensitive and trims surrounding whitespace")
    func normalization() {
        #expect(EmojiMapper.emoji(for: "WATER",    languageCode: "en") == "💧")
        #expect(EmojiMapper.emoji(for: "  happy ", languageCode: "en") == "😊")
    }

    @Test("Unknown words return nil, including the empty string")
    func unknownWordReturnsNil() {
        #expect(EmojiMapper.emoji(for: "xyzzy_unknown", languageCode: "en") == nil)
        #expect(EmojiMapper.emoji(for: "",              languageCode: "en") == nil)
    }

    @Test("Full BCP-47 suffix is ignored (e.g. 'en-US' treated as 'en')")
    func languageCodeSuffixIgnored() {
        #expect(EmojiMapper.emoji(for: "water", languageCode: "en-US") == "💧")
        #expect(EmojiMapper.emoji(for: "água",  languageCode: "pt-BR") == "💧")
    }
}

// MARK: - Localizer

@Suite("Localizer")
struct LocalizerTests {

    @Test("Core UI keys are non-empty in every language")
    func coreUIKeys() {
        let keys = [
            "choose_category", "sentence_builder", "back", "info",
            "change_language", "word_bank", "clear", "transcribe",
        ]
        for langCode in allLanguageCodes {
            for key in keys {
                #expect(!Localizer.string(key, langCode: langCode).isEmpty,
                        "[\(langCode)] missing key '\(key)'")
            }
        }
    }

    @Test("Language selection confirmation strings exist for every source/target pair")
    func confirmationStrings() {
        for source in allLanguageCodes {
            for target in allLanguageCodes {
                let key   = "confirm_language_selected_\(target)"
                let value = Localizer.string(key, langCode: source)
                #expect(!value.isEmpty,
                        "[\(source)] missing confirmation for '\(target)'")
            }
        }
    }

    @Test("Tutorial strings exist for every language")
    func tutorialStrings() {
        let keys = [
            "tutorial_welcome_title", "tutorial_welcome_description",
            "tutorial_button", "tutorial_categories_title",
            "tutorial_needs_demo_title", "tutorial_sentence_builder_title",
            "tutorial_word_bank_title", "tutorial_typing_title",
            "tutorial_completion_title",
        ]
        for langCode in allLanguageCodes {
            for key in keys {
                #expect(!Localizer.string(key, langCode: langCode).isEmpty,
                        "[\(langCode)] missing tutorial key '\(key)'")
            }
        }
    }

    @Test("Transcribe view strings exist for every language")
    func transcribeStrings() {
        let keys = [
            "transcribe", "transcribe_start", "transcribe_stop",
            "transcribe_listening", "transcribe_stopped", "transcribe_placeholder",
            "transcribe_clear", "transcribe_clear_confirm",
            "transcribe_info_title", "transcribe_info_body",
            "transcribe_translated_from",
        ]
        for langCode in allLanguageCodes {
            for key in keys {
                #expect(!Localizer.string(key, langCode: langCode).isEmpty,
                        "[\(langCode)] missing transcribe key '\(key)'")
            }
        }
    }

    @Test("Portuguese strings are not falling back to English")
    func portugueseNotFallingBack() {
        #expect(Localizer.string("choose_category",              langCode: "pt") == "Escolher Categoria")
        #expect(Localizer.string("tutorial_button",              langCode: "pt") == "Tutorial Guiado")
        #expect(Localizer.string("confirm_language_selected_pt", langCode: "pt") == "Português selecionado")
    }
}

// MARK: - Emergency Communication

@Suite("Emergency communication readiness")
struct EmergencyCommunicationTests {

    private let criticalImages = ["water", "food", "toilet", "help", "medicine"]

    @Test("Critical need items are available in every language")
    func criticalNeedsInAllLanguages() {
        for provider in allProviders {
            let needImages = provider.items.filter { $0.category == .need }.map(\.image)
            for image in criticalImages {
                #expect(needImages.contains(image),
                        "\(provider.languageCode) is missing critical need: '\(image)'")
            }
        }
    }

    @Test("Every help item has non-empty text across all languages")
    func helpItemTextNonEmpty() {
        for provider in allProviders {
            if let helpItem = provider.items.first(where: { $0.image == "help" }) {
                #expect(!helpItem.text.isEmpty,
                        "\(provider.languageCode) help item has empty text")
            }
        }
    }

    @Test("English word bank includes key emergency words")
    func emergencyWordsInEnglishWordBank() {
        let wordBank = EnglishLocalizationProvider().wordBank
        for word in ["help", "need", "hurt", "sick"] {
            #expect(wordBank.contains(word), "English word bank missing '\(word)'")
        }
    }
}

// MARK: - Text-to-Speech

@Suite("SpeechBoardView.bestAvailableVoice")
struct BestAvailableVoiceTests {

    private func makeView() -> SpeechBoardView { SpeechBoardView() }

    @Test("Returns a non-empty BCP-47 code for every supported language")
    func returnsValidResult() {
        let view = makeView()
        for langCode in allLanguageCodes {
            let result = view.bestAvailableVoice(for: langCode)
            #expect(!result.isEmpty, "Empty result for '\(langCode)'")
            let isValidFormat = result.contains("-") || result.count == 2
            #expect(isValidFormat, "Unexpected format '\(result)' for '\(langCode)'")
        }
    }

    @Test("Falls back gracefully for an unrecognised language code")
    func gracefulFallback() {
        let result = makeView().bestAvailableVoice(for: "xx-INVALID")
        #expect(!result.isEmpty)
    }
}

// MARK: - TranscribeView

@Suite("TranscribeView")
struct TranscribeViewTests {

    @Test("Can be instantiated for every supported language")
    func instantiation() {
        for langCode in allLanguageCodes {
            let view = TranscribeView(targetLanguageCode: langCode)
            #expect(view.targetLanguageCode == langCode)
        }
    }
}

// MARK: - Sentence Builder State

@Suite("Sentence builder state logic")
struct SentenceBuilderTests {

    @Test("Words appended to an array appear in order")
    func wordOrderPreserved() {
        var sentence: [String] = []
        sentence.append("I")
        sentence.append("need")
        sentence.append("water")
        #expect(sentence == ["I", "need", "water"])
    }

    @Test("Joined sentence uses spaces between words")
    func joinedWithSpaces() {
        let sentence = ["I", "need", "water"]
        #expect(sentence.joined(separator: " ") == "I need water")
    }

    @Test("Clearing removes all words")
    func clearWords() {
        var sentence = ["I", "need", "water"]
        sentence.removeAll()
        #expect(sentence.isEmpty)
    }

    @Test("Empty sentence joined produces an empty string")
    func emptyJoin() {
        #expect([String]().joined(separator: " ") == "")
    }

    @Test("Trimming whitespace from typed sentence works correctly")
    func typedSentenceTrimming() {
        let typed = "  hello world  "
        #expect(typed.trimmingCharacters(in: .whitespacesAndNewlines) == "hello world")
    }

    @Test("Word bank is available in every supported language")
    func wordBankAvailableInAllLanguages() {
        for provider in allProviders {
            #expect(!provider.wordBank.isEmpty,
                    "\(provider.languageCode) has no word bank")
        }
    }
}

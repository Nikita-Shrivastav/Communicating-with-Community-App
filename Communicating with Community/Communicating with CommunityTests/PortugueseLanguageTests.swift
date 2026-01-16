import Foundation
import Foundation
import SwiftUI
import AVFoundation
import Testing
@testable import Communicating_with_Community

@Suite("Portuguese Language Support Tests")
struct PortugueseLanguageTests {
    
    @Test("Portuguese language exists in AppLanguage enum")
    func portugueseLanguageEnumExists() async throws {
        let allLanguages = SpeechBoardView.AppLanguage.allCases
        
        #expect(allLanguages.contains(.portuguese), "Portuguese language should be in AppLanguage enum")
        #expect(SpeechBoardView.AppLanguage.portuguese.rawValue == "pt", "Portuguese language code should be 'pt'")
    }
    
    @Test("Portuguese has correct display name")
    func portugueseDisplayName() async throws {
        let portugueseLanguage = SpeechBoardView.AppLanguage.portuguese
        
        #expect(portugueseLanguage.displayName == "Português", "Portuguese display name should be 'Português'")
    }
    
    @Test("PortugueseLocalizationProvider can be instantiated")
    func portugueseLocalizationProviderExists() async throws {
        let provider = PortugueseLocalizationProvider()
        
        #expect(provider.languageCode == "pt", "Portuguese provider should have language code 'pt'")
        #expect(provider.displayName == "Português", "Portuguese provider should have display name 'Português'")
    }
    
    @Test("Portuguese has proper voice codes")
    func portugueseVoiceCodes() async throws {
        let provider = PortugueseLocalizationProvider()
        
        #expect(!provider.preferredVoiceCodes.isEmpty, "Portuguese should have preferred voice codes")
        #expect(provider.preferredVoiceCodes.contains("pt-PT") || 
               provider.preferredVoiceCodes.contains("pt-BR") ||
               provider.preferredVoiceCodes.contains("pt"), 
               "Portuguese should have at least one valid voice code")
    }
    
    @Test("Portuguese word bank is not empty and has sufficient words")
    func portugueseWordBankNotEmpty() async throws {
        let provider = PortugueseLocalizationProvider()
        
        #expect(!provider.wordBank.isEmpty, "Portuguese word bank should not be empty")
        #expect(provider.wordBank.count > 50, "Portuguese word bank should have at least 50 words")
    }
    
    @Test("Portuguese word bank contains essential basic words")
    func portugueseWordBankContainsBasicWords() async throws {
        let provider = PortugueseLocalizationProvider()
        let wordBank = provider.wordBank
        
        #expect(wordBank.contains("eu"), "Word bank should contain 'eu' (I)")
        #expect(wordBank.contains("água"), "Word bank should contain 'água' (water)")
        #expect(wordBank.contains("ajuda"), "Word bank should contain 'ajuda' (help)")
        #expect(wordBank.contains("por favor"), "Word bank should contain 'por favor' (please)")
    }
    
    @Test("Portuguese has 30 communication items")
    func portugueseItemsNotEmpty() async throws {
        let provider = PortugueseLocalizationProvider()
        
        #expect(!provider.items.isEmpty, "Portuguese items should not be empty")
        #expect(provider.items.count == 30, "Portuguese should have 30 items (10 needs, 10 wants, 10 feelings)")
    }
    
    @Test("Portuguese items are properly categorized")
    func portugueseItemsCategories() async throws {
        let provider = PortugueseLocalizationProvider()
        let items = provider.items
        
        let needs = items.filter { $0.category == .need }
        let wants = items.filter { $0.category == .want }
        let feelings = items.filter { $0.category == .feeling }
        
        #expect(needs.count == 10, "Portuguese should have 10 need items")
        #expect(wants.count == 10, "Portuguese should have 10 want items")
        #expect(feelings.count == 10, "Portuguese should have 10 feeling items")
    }
    
    @Test("Portuguese category titles are correct")
    func portugueseCategoryTitles() async throws {
        let provider = PortugueseLocalizationProvider()
        
        #expect(provider.categoryTitle(for: .need) == "Necessidades", "Needs category should be 'Necessidades'")
        #expect(provider.categoryTitle(for: .want) == "Desejos", "Wants category should be 'Desejos'")
        #expect(provider.categoryTitle(for: .feeling) == "Sentimentos", "Feelings category should be 'Sentimentos'")
    }
    
    @Test("Portuguese localization strings exist and are not falling back to English")
    func portugueseLocalizationStrings() async throws {
        let chooseCategory = Localizer.string("choose_category", langCode: "pt")
        let sentenceBuilder = Localizer.string("sentence_builder", langCode: "pt")
        let back = Localizer.string("back", langCode: "pt")
        
        #expect(!chooseCategory.isEmpty, "Portuguese should have 'choose_category' string")
        #expect(!sentenceBuilder.isEmpty, "Portuguese should have 'sentence_builder' string")
        #expect(!back.isEmpty, "Portuguese should have 'back' string")
        
        // Verify they're actually in Portuguese (not falling back to English)
        #expect(chooseCategory != "Choose Category", "Portuguese strings should not fall back to English")
        #expect(chooseCategory == "Escolher Categoria", "Choose category should be 'Escolher Categoria'")
    }
    
    @Test("Portuguese language selection confirmation exists")
    func portugueseLanguageSelectionConfirmation() async throws {
        let confirmation = Localizer.string("confirm_language_selected_pt", langCode: "pt")
        
        #expect(!confirmation.isEmpty, "Portuguese should have language selection confirmation")
        #expect(confirmation == "Português selecionado", "Confirmation should be 'Português selecionado'")
    }
    
    @Test("Portuguese tutorial strings exist")
    func portugueseTutorialStrings() async throws {
        let welcomeTitle = Localizer.string("tutorial_welcome_title", langCode: "pt")
        let welcomeDescription = Localizer.string("tutorial_welcome_description", langCode: "pt")
        let tutorialButton = Localizer.string("tutorial_button", langCode: "pt")
        
        #expect(!welcomeTitle.isEmpty, "Portuguese should have tutorial welcome title")
        #expect(!welcomeDescription.isEmpty, "Portuguese should have tutorial welcome description")
        #expect(!tutorialButton.isEmpty, "Portuguese should have tutorial button label")
        
        // Verify they're in Portuguese
        #expect(tutorialButton == "Tutorial Guiado", "Tutorial button should be 'Tutorial Guiado'")
    }
    
    @Test("Portuguese words have emoji mappings")
    func portugueseEmojiMappings() async throws {
        let waterEmoji = EmojiMapper.emoji(for: "água", languageCode: "pt")
        let foodEmoji = EmojiMapper.emoji(for: "comida", languageCode: "pt")
        let helpEmoji = EmojiMapper.emoji(for: "ajuda", languageCode: "pt")
        
        #expect(waterEmoji != nil, "Portuguese word 'água' should have emoji")
        #expect(foodEmoji != nil, "Portuguese word 'comida' should have emoji")
        #expect(helpEmoji != nil, "Portuguese word 'ajuda' should have emoji")
        
        #expect(waterEmoji == "💧", "água should map to water drop emoji")
        #expect(foodEmoji == "🍽️", "comida should map to food emoji")
        #expect(helpEmoji == "🆘", "ajuda should map to help emoji")
    }
    
    @Test("All languages include Portuguese")
    func allLanguagesIncludePortuguese() async throws {
        let allLanguages = SpeechBoardView.AppLanguage.allCases
        let languageCodes = allLanguages.map { $0.rawValue }
        
        #expect(languageCodes.contains("pt"), "All languages should include 'pt'")
        #expect(allLanguages.count == 6, "Should have 6 languages: en, hi, es, zh, fr, pt")
    }
    
    @Test("Portuguese items reference valid image names")
    func portugueseItemsHaveValidImages() async throws {
        let provider = PortugueseLocalizationProvider()
        let expectedImages = ["water", "food", "bed", "toilet", "help", "medicine", "break", "quiet", "hug", "space",
                            "walk", "play", "mom", "dad", "brother", "sister", "friend", "outside", "watch", "music",
                            "mad", "sad", "happy", "anxious", "scared", "jealous", "tired", "excited", "confused", "sick"]
        
        for item in provider.items {
            #expect(expectedImages.contains(item.image), "Item image '\(item.image)' should be a valid image name")
        }
    }
    
    @Test("Portuguese items have non-empty text")
    func portugueseItemsHaveNonEmptyText() async throws {
        let provider = PortugueseLocalizationProvider()
        
        for item in provider.items {
            #expect(!item.text.isEmpty, "Portuguese item with image '\(item.image)' should have non-empty text")
        }
    }
    
    @Test("All languages can announce Portuguese selection", arguments: ["en", "hi", "es", "zh", "fr", "pt"])
    func portugueseConfirmationStringsExistInAllLanguages(languageCode: String) async throws {
        let confirmation = Localizer.string("confirm_language_selected_pt", langCode: languageCode)
        #expect(!confirmation.isEmpty, "Language '\(languageCode)' should have Portuguese selection confirmation")
    }
    
    @Test("Portuguese voice availability (informational)")
    func portugueseVoiceAvailability() async throws {
        let availableVoices = AVSpeechSynthesisVoice.speechVoices()
        let portugueseVoices = availableVoices.filter { voice in
            voice.language.hasPrefix("pt")
        }
        
        // This is informational - won't fail the test
        if portugueseVoices.isEmpty {
            Issue.record("⚠️ Warning: No Portuguese voices found on this system. Speech synthesis may fall back to default voice.")
        } else {
            print("✅ Found \(portugueseVoices.count) Portuguese voice(s) available")
        }
    }
}

@Suite("Portuguese Integration Tests")
struct PortugueseIntegrationTests {
    
    @Test("Portuguese works in language picker")
    func portugueseInLanguagePicker() async throws {
        let allLanguages = SpeechBoardView.AppLanguage.allCases
        let portuguese = allLanguages.first { $0.rawValue == "pt" }
        
        #expect(portuguese != nil, "Portuguese should be available in language picker")
        #expect(portuguese?.displayName == "Português", "Portuguese should display as 'Português'")
    }
    
    @Test("Portuguese provider returns correct data for all categories")
    func portugueseProviderDataIntegrity() async throws {
        let provider = PortugueseLocalizationProvider()
        
        // Test that each category has items and they're valid
        for category in [ItemCategory.need, ItemCategory.want, ItemCategory.feeling] {
            let categoryItems = provider.items.filter { $0.category == category }
            let categoryTitle = provider.categoryTitle(for: category)
            
            #expect(categoryItems.count == 10, "Category \(category) should have 10 items")
            #expect(!categoryTitle.isEmpty, "Category \(category) should have a title")
            
            // All items should have non-empty text and valid images
            for item in categoryItems {
                #expect(!item.text.isEmpty, "Item should have text")
                #expect(!item.image.isEmpty, "Item should have image name")
            }
        }
    }
    
    @Test("Portuguese tutorial demo words match word bank")
    func tutorialDemoWordsMatchWordBank() async throws {
        let provider = PortugueseLocalizationProvider()
        let wordBank = provider.wordBank
        
        // These are the demo words used in GuidedTutorialView
        let demoWords = ["eu", "quero", "água", "comida", "ajuda", "por favor"]
        
        for word in demoWords {
            #expect(wordBank.contains(word), "Word bank should contain tutorial demo word '\(word)'")
        }
    }
}

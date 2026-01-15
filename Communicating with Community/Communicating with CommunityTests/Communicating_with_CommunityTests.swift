//
//  Communicating_with_CommunityTests.swift
//  Communicating with CommunityTests
//
//  Created by nikita on 9/17/25.
//

import XCTest
@testable import Communicating_with_Community

final class Communicating_with_CommunityTests: XCTestCase {

    // MARK: - Portuguese Language Support Tests
    
    func testPortugueseLanguageEnumExists() throws {
        // Test that Portuguese is included in the AppLanguage enum
        let allLanguages = SpeechBoardView.AppLanguage.allCases
        
        XCTAssertTrue(allLanguages.contains(.portuguese), "Portuguese language should be in AppLanguage enum")
        XCTAssertEqual(SpeechBoardView.AppLanguage.portuguese.rawValue, "pt", "Portuguese language code should be 'pt'")
    }
    
    func testPortugueseDisplayName() throws {
        // Test that Portuguese has correct display name
        let portugueseLanguage = SpeechBoardView.AppLanguage.portuguese
        
        XCTAssertEqual(portugueseLanguage.displayName, "Português", "Portuguese display name should be 'Português'")
    }
    
    func testPortugueseLocalizationProviderExists() throws {
        // Test that PortugueseLocalizationProvider can be instantiated
        let provider = PortugueseLocalizationProvider()
        
        XCTAssertEqual(provider.languageCode, "pt", "Portuguese provider should have language code 'pt'")
        XCTAssertEqual(provider.displayName, "Português", "Portuguese provider should have display name 'Português'")
    }
    
    func testPortugueseVoiceCodes() throws {
        // Test that Portuguese has proper voice codes
        let provider = PortugueseLocalizationProvider()
        
        XCTAssertFalse(provider.preferredVoiceCodes.isEmpty, "Portuguese should have preferred voice codes")
        XCTAssertTrue(provider.preferredVoiceCodes.contains("pt-PT") || 
                     provider.preferredVoiceCodes.contains("pt-BR") ||
                     provider.preferredVoiceCodes.contains("pt"), 
                     "Portuguese should have at least one valid voice code")
    }
    
    func testPortugueseWordBankNotEmpty() throws {
        // Test that Portuguese word bank has words
        let provider = PortugueseLocalizationProvider()
        
        XCTAssertFalse(provider.wordBank.isEmpty, "Portuguese word bank should not be empty")
        XCTAssertGreaterThan(provider.wordBank.count, 50, "Portuguese word bank should have at least 50 words")
    }
    
    func testPortugueseWordBankContainsBasicWords() throws {
        // Test that Portuguese word bank contains essential words
        let provider = PortugueseLocalizationProvider()
        let wordBank = provider.wordBank
        
        XCTAssertTrue(wordBank.contains("eu"), "Word bank should contain 'eu' (I)")
        XCTAssertTrue(wordBank.contains("água"), "Word bank should contain 'água' (water)")
        XCTAssertTrue(wordBank.contains("ajuda"), "Word bank should contain 'ajuda' (help)")
        XCTAssertTrue(wordBank.contains("por favor"), "Word bank should contain 'por favor' (please)")
    }
    
    func testPortugueseItemsNotEmpty() throws {
        // Test that Portuguese items exist
        let provider = PortugueseLocalizationProvider()
        
        XCTAssertFalse(provider.items.isEmpty, "Portuguese items should not be empty")
        XCTAssertEqual(provider.items.count, 30, "Portuguese should have 30 items (10 needs, 10 wants, 10 feelings)")
    }
    
    func testPortugueseItemsCategories() throws {
        // Test that Portuguese items are properly categorized
        let provider = PortugueseLocalizationProvider()
        let items = provider.items
        
        let needCategory: ItemCategory = .need
        let wantCategory: ItemCategory = .want
        let feelingCategory: ItemCategory = .feeling
        
        let needs = items.filter { $0.category == needCategory }
        let wants = items.filter { $0.category == wantCategory }
        let feelings = items.filter { $0.category == feelingCategory }
        
        XCTAssertEqual(needs.count, 10, "Portuguese should have 10 need items")
        XCTAssertEqual(wants.count, 10, "Portuguese should have 10 want items")
        XCTAssertEqual(feelings.count, 10, "Portuguese should have 10 feeling items")
    }
    
    func testPortugueseCategoryTitles() throws {
        // Test that Portuguese category titles are correct
        let provider = PortugueseLocalizationProvider()
        
        XCTAssertEqual(provider.categoryTitle(for: .need), "Necessidades", "Needs category should be 'Necessidades'")
        XCTAssertEqual(provider.categoryTitle(for: .want), "Desejos", "Wants category should be 'Desejos'")
        XCTAssertEqual(provider.categoryTitle(for: .feeling), "Sentimentos", "Feelings category should be 'Sentimentos'")
    }
    
    func testPortugueseLocalizationStrings() throws {
        // Test that key Portuguese localization strings exist in Localizer
        let chooseCategory = Localizer.string("choose_category", langCode: "pt")
        let sentenceBuilder = Localizer.string("sentence_builder", langCode: "pt")
        let back = Localizer.string("back", langCode: "pt")
        
        XCTAssertFalse(chooseCategory.isEmpty, "Portuguese should have 'choose_category' string")
        XCTAssertFalse(sentenceBuilder.isEmpty, "Portuguese should have 'sentence_builder' string")
        XCTAssertFalse(back.isEmpty, "Portuguese should have 'back' string")
        
        // Verify they're actually in Portuguese (not falling back to English)
        XCTAssertNotEqual(chooseCategory, "Choose Category", "Portuguese strings should not fall back to English")
        XCTAssertEqual(chooseCategory, "Escolher Categoria", "Choose category should be 'Escolher Categoria'")
    }
    
    func testPortugueseLanguageSelectionConfirmation() throws {
        // Test that Portuguese language selection confirmation exists
        let confirmation = Localizer.string("confirm_language_selected_pt", langCode: "pt")
        
        XCTAssertFalse(confirmation.isEmpty, "Portuguese should have language selection confirmation")
        XCTAssertEqual(confirmation, "Português selecionado", "Confirmation should be 'Português selecionado'")
    }
    
    func testPortugueseTutorialStrings() throws {
        // Test that Portuguese tutorial strings exist
        let welcomeTitle = Localizer.string("tutorial_welcome_title", langCode: "pt")
        let welcomeDescription = Localizer.string("tutorial_welcome_description", langCode: "pt")
        let tutorialButton = Localizer.string("tutorial_button", langCode: "pt")
        
        XCTAssertFalse(welcomeTitle.isEmpty, "Portuguese should have tutorial welcome title")
        XCTAssertFalse(welcomeDescription.isEmpty, "Portuguese should have tutorial welcome description")
        XCTAssertFalse(tutorialButton.isEmpty, "Portuguese should have tutorial button label")
        
        // Verify they're in Portuguese
        XCTAssertEqual(tutorialButton, "Tutorial Guiado", "Tutorial button should be 'Tutorial Guiado'")
    }
    
    func testPortugueseEmojiMappings() throws {
        // Test that Portuguese words have emoji mappings
        let waterEmoji = EmojiMapper.emoji(for: "água", languageCode: "pt")
        let foodEmoji = EmojiMapper.emoji(for: "comida", languageCode: "pt")
        let helpEmoji = EmojiMapper.emoji(for: "ajuda", languageCode: "pt")
        
        XCTAssertNotNil(waterEmoji, "Portuguese word 'água' should have emoji")
        XCTAssertNotNil(foodEmoji, "Portuguese word 'comida' should have emoji")
        XCTAssertNotNil(helpEmoji, "Portuguese word 'ajuda' should have emoji")
        
        XCTAssertEqual(waterEmoji, "💧", "água should map to water drop emoji")
        XCTAssertEqual(foodEmoji, "🍽️", "comida should map to food emoji")
        XCTAssertEqual(helpEmoji, "🆘", "ajuda should map to help emoji")
    }
    
    func testAllLanguagesIncludePortuguese() throws {
        // Test that Portuguese is properly integrated with other languages
        let allLanguages = SpeechBoardView.AppLanguage.allCases
        let languageCodes = allLanguages.map { $0.rawValue }
        
        XCTAssertTrue(languageCodes.contains("pt"), "All languages should include 'pt'")
        XCTAssertEqual(allLanguages.count, 6, "Should have 6 languages: en, hi, es, zh, fr, pt")
    }
    
    func testPortugueseItemsHaveValidImages() throws {
        // Test that Portuguese items reference valid image names
        let provider = PortugueseLocalizationProvider()
        let expectedImages = ["water", "food", "bed", "toilet", "help", "medicine", "break", "quiet", "hug", "space",
                            "walk", "play", "mom", "dad", "brother", "sister", "friend", "outside", "watch", "music",
                            "mad", "sad", "happy", "anxious", "scared", "jealous", "tired", "excited", "confused", "sick"]
        
        for item in provider.items {
            XCTAssertTrue(expectedImages.contains(item.image), "Item image '\(item.image)' should be a valid image name")
        }
    }
    
    func testPortugueseItemsHaveNonEmptyText() throws {
        // Test that all Portuguese items have text
        let provider = PortugueseLocalizationProvider()
        
        for item in provider.items {
            XCTAssertFalse(item.text.isEmpty, "Portuguese item with image '\(item.image)' should have non-empty text")
        }
    }
    
    func testPortugueseVoiceAvailability() throws {
        // Test that Portuguese voice codes are configured
        let provider = PortugueseLocalizationProvider()
        
        // Verify voice codes are configured
        XCTAssertFalse(provider.preferredVoiceCodes.isEmpty, "Portuguese should have voice codes configured")
        XCTAssertTrue(provider.preferredVoiceCodes.contains(where: { $0.hasPrefix("pt") }), 
                     "Portuguese voice codes should start with 'pt'")
    }
    
    func testPortugueseAllConfirmationStringsExist() throws {
        // Test that all languages can announce Portuguese selection
        let languages = ["en", "hi", "es", "zh", "fr", "pt"]
        
        for langCode in languages {
            let confirmation = Localizer.string("confirm_language_selected_pt", langCode: langCode)
            XCTAssertFalse(confirmation.isEmpty, "Language '\(langCode)' should have Portuguese selection confirmation")
        }
    }
    
    // MARK: - All Languages Tests
    
    func testAllLanguagesExistInEnum() throws {
        // Test that all expected languages are in the AppLanguage enum
        let allLanguages = SpeechBoardView.AppLanguage.allCases
        let expectedCodes = ["en", "hi", "es", "zh", "fr", "pt"]
        
        XCTAssertEqual(allLanguages.count, 6, "Should have exactly 6 languages")
        
        for code in expectedCodes {
            XCTAssertTrue(allLanguages.contains { $0.rawValue == code }, "Should contain language with code '\(code)'")
        }
    }
    
    func testAllLanguagesHaveDisplayNames() throws {
        // Test that all languages have non-empty display names
        let allLanguages = SpeechBoardView.AppLanguage.allCases
        
        for language in allLanguages {
            XCTAssertFalse(language.displayName.isEmpty, "Language '\(language.rawValue)' should have display name")
        }
        
        // Verify specific display names
        XCTAssertEqual(SpeechBoardView.AppLanguage.english.displayName, "English")
        XCTAssertEqual(SpeechBoardView.AppLanguage.hindi.displayName, "हिन्दी")
        XCTAssertEqual(SpeechBoardView.AppLanguage.spanish.displayName, "Español")
        XCTAssertEqual(SpeechBoardView.AppLanguage.chinese.displayName, "中文")
        XCTAssertEqual(SpeechBoardView.AppLanguage.french.displayName, "Français")
        XCTAssertEqual(SpeechBoardView.AppLanguage.portuguese.displayName, "Português")
    }
    
    func testAllLanguagesHaveVoiceCodes() throws {
        // Test that all languages have voice codes
        let allLanguages = SpeechBoardView.AppLanguage.allCases
        
        for language in allLanguages {
            XCTAssertFalse(language.preferredVoiceCodes.isEmpty, "Language '\(language.rawValue)' should have voice codes")
        }
    }
    
    // MARK: - English Language Tests
    
    func testEnglishLocalizationProvider() throws {
        let provider = EnglishLocalizationProvider()
        
        XCTAssertEqual(provider.languageCode, "en")
        XCTAssertEqual(provider.displayName, "English")
        XCTAssertFalse(provider.wordBank.isEmpty)
        XCTAssertEqual(provider.items.count, 30)
        
        // Test category titles
        XCTAssertEqual(provider.categoryTitle(for: .need), "Needs")
        XCTAssertEqual(provider.categoryTitle(for: .want), "Wants")
        XCTAssertEqual(provider.categoryTitle(for: .feeling), "Feelings")
    }
    
    func testEnglishWordBank() throws {
        let provider = EnglishLocalizationProvider()
        let wordBank = provider.wordBank
        
        XCTAssertTrue(wordBank.contains("I"))
        XCTAssertTrue(wordBank.contains("water"))
        XCTAssertTrue(wordBank.contains("help"))
        XCTAssertTrue(wordBank.contains("please"))
    }
    
    func testEnglishItems() throws {
        let provider = EnglishLocalizationProvider()
        let items = provider.items
        
        let needCategory: ItemCategory = .need
        let wantCategory: ItemCategory = .want
        let feelingCategory: ItemCategory = .feeling
        
        let needs = items.filter { $0.category == needCategory }
        let wants = items.filter { $0.category == wantCategory }
        let feelings = items.filter { $0.category == feelingCategory }
        
        XCTAssertEqual(needs.count, 10)
        XCTAssertEqual(wants.count, 10)
        XCTAssertEqual(feelings.count, 10)
    }
    
    // MARK: - Hindi Language Tests
    
    func testHindiLocalizationProvider() throws {
        let provider = HindiLocalizationProvider()
        
        XCTAssertEqual(provider.languageCode, "hi")
        XCTAssertEqual(provider.displayName, "हिन्दी")
        XCTAssertFalse(provider.wordBank.isEmpty)
        XCTAssertEqual(provider.items.count, 30)
        
        // Test category titles
        XCTAssertEqual(provider.categoryTitle(for: .need), "ज़रूरतें")
        XCTAssertEqual(provider.categoryTitle(for: .want), "इच्छाएँ")
        XCTAssertEqual(provider.categoryTitle(for: .feeling), "भावनाएँ")
    }
    
    func testHindiWordBank() throws {
        let provider = HindiLocalizationProvider()
        let wordBank = provider.wordBank
        
        XCTAssertTrue(wordBank.contains("मैं"))
        XCTAssertTrue(wordBank.contains("पानी"))
        XCTAssertTrue(wordBank.contains("मदद"))
        XCTAssertTrue(wordBank.contains("कृपया"))
    }
    
    func testHindiItems() throws {
        let provider = HindiLocalizationProvider()
        let items = provider.items
        
        let needCategory: ItemCategory = .need
        let wantCategory: ItemCategory = .want
        let feelingCategory: ItemCategory = .feeling
        
        let needs = items.filter { $0.category == needCategory }
        let wants = items.filter { $0.category == wantCategory }
        let feelings = items.filter { $0.category == feelingCategory }
        
        XCTAssertEqual(needs.count, 10)
        XCTAssertEqual(wants.count, 10)
        XCTAssertEqual(feelings.count, 10)
    }
    
    // MARK: - Spanish Language Tests
    
    func testSpanishLocalizationProvider() throws {
        let provider = SpanishLocalizationProvider()
        
        XCTAssertEqual(provider.languageCode, "es")
        XCTAssertEqual(provider.displayName, "Español")
        XCTAssertFalse(provider.wordBank.isEmpty)
        XCTAssertEqual(provider.items.count, 30)
        
        // Test category titles
        XCTAssertEqual(provider.categoryTitle(for: .need), "Necesidades")
        XCTAssertEqual(provider.categoryTitle(for: .want), "Deseos")
        XCTAssertEqual(provider.categoryTitle(for: .feeling), "Sentimientos")
    }
    
    func testSpanishWordBank() throws {
        let provider = SpanishLocalizationProvider()
        let wordBank = provider.wordBank
        
        XCTAssertTrue(wordBank.contains("yo"))
        XCTAssertTrue(wordBank.contains("agua"))
        XCTAssertTrue(wordBank.contains("ayuda"))
        XCTAssertTrue(wordBank.contains("por favor"))
    }
    
    func testSpanishItems() throws {
        let provider = SpanishLocalizationProvider()
        let items = provider.items
        
        let needCategory: ItemCategory = .need
        let wantCategory: ItemCategory = .want
        let feelingCategory: ItemCategory = .feeling
        
        let needs = items.filter { $0.category == needCategory }
        let wants = items.filter { $0.category == wantCategory }
        let feelings = items.filter { $0.category == feelingCategory }
        
        XCTAssertEqual(needs.count, 10)
        XCTAssertEqual(wants.count, 10)
        XCTAssertEqual(feelings.count, 10)
    }
    
    // MARK: - Chinese Language Tests
    
    func testChineseLocalizationProvider() throws {
        let provider = ChineseLocalizationProvider()
        
        XCTAssertEqual(provider.languageCode, "zh")
        XCTAssertEqual(provider.displayName, "中文")
        XCTAssertFalse(provider.wordBank.isEmpty)
        XCTAssertEqual(provider.items.count, 30)
        
        // Test category titles
        XCTAssertEqual(provider.categoryTitle(for: .need), "需求")
        XCTAssertEqual(provider.categoryTitle(for: .want), "想要")
        XCTAssertEqual(provider.categoryTitle(for: .feeling), "感受")
    }
    
    func testChineseWordBank() throws {
        let provider = ChineseLocalizationProvider()
        let wordBank = provider.wordBank
        
        XCTAssertTrue(wordBank.contains("我"))
        XCTAssertTrue(wordBank.contains("水"))
        XCTAssertTrue(wordBank.contains("帮助"))
        XCTAssertTrue(wordBank.contains("请"))
    }
    
    func testChineseItems() throws {
        let provider = ChineseLocalizationProvider()
        let items = provider.items
        
        let needCategory: ItemCategory = .need
        let wantCategory: ItemCategory = .want
        let feelingCategory: ItemCategory = .feeling
        
        let needs = items.filter { $0.category == needCategory }
        let wants = items.filter { $0.category == wantCategory }
        let feelings = items.filter { $0.category == feelingCategory }
        
        XCTAssertEqual(needs.count, 10)
        XCTAssertEqual(wants.count, 10)
        XCTAssertEqual(feelings.count, 10)
    }
    
    // MARK: - French Language Tests
    
    func testFrenchLocalizationProvider() throws {
        let provider = FrenchLocalizationProvider()
        
        XCTAssertEqual(provider.languageCode, "fr")
        XCTAssertEqual(provider.displayName, "Français")
        XCTAssertFalse(provider.wordBank.isEmpty)
        XCTAssertEqual(provider.items.count, 30)
        
        // Test category titles
        XCTAssertEqual(provider.categoryTitle(for: .need), "Besoins")
        XCTAssertEqual(provider.categoryTitle(for: .want), "Envies")
        XCTAssertEqual(provider.categoryTitle(for: .feeling), "Émotions")
    }
    
    func testFrenchWordBank() throws {
        let provider = FrenchLocalizationProvider()
        let wordBank = provider.wordBank
        
        XCTAssertTrue(wordBank.contains("je"))
        XCTAssertTrue(wordBank.contains("eau"))
        XCTAssertTrue(wordBank.contains("aide"))
        XCTAssertTrue(wordBank.contains("s'il vous plaît"))
    }
    
    func testFrenchItems() throws {
        let provider = FrenchLocalizationProvider()
        let items = provider.items
        
        let needCategory: ItemCategory = .need
        let wantCategory: ItemCategory = .want
        let feelingCategory: ItemCategory = .feeling
        
        let needs = items.filter { $0.category == needCategory }
        let wants = items.filter { $0.category == wantCategory }
        let feelings = items.filter { $0.category == feelingCategory }
        
        XCTAssertEqual(needs.count, 10)
        XCTAssertEqual(wants.count, 10)
        XCTAssertEqual(feelings.count, 10)
    }
    
    // MARK: - Localizer Tests for All Languages
    
    func testLocalizerStringForAllLanguages() throws {
        let languages = ["en", "hi", "es", "zh", "fr", "pt"]
        let testKeys = ["choose_category", "sentence_builder", "back"]
        
        for langCode in languages {
            for key in testKeys {
                let value = Localizer.string(key, langCode: langCode)
                XCTAssertFalse(value.isEmpty, "Language '\(langCode)' should have localization for '\(key)'")
            }
        }
    }
    
    func testAllLanguagesHaveConfirmationStrings() throws {
        let languages = ["en", "hi", "es", "zh", "fr", "pt"]
        
        for langCode in languages {
            for targetLang in languages {
                let key = "confirm_language_selected_\(targetLang)"
                let value = Localizer.string(key, langCode: langCode)
                XCTAssertFalse(value.isEmpty, "Language '\(langCode)' should have confirmation for '\(targetLang)'")
            }
        }
    }
    
    func testAllLanguagesHaveTutorialStrings() throws {
        let languages = ["en", "hi", "es", "zh", "fr", "pt"]
        let tutorialKeys = [
            "tutorial_welcome_title",
            "tutorial_welcome_description",
            "tutorial_button",
            "tutorial_categories_title",
            "tutorial_needs_demo_title",
            "tutorial_sentence_builder_title",
            "tutorial_word_bank_title",
            "tutorial_typing_title",
            "tutorial_completion_title"
        ]
        
        for langCode in languages {
            for key in tutorialKeys {
                let value = Localizer.string(key, langCode: langCode)
                XCTAssertFalse(value.isEmpty, "Language '\(langCode)' should have tutorial string '\(key)'")
            }
        }
    }
    
    // MARK: - NeedItem Model Tests
    
    func testNeedItemModel() throws {
        let item = NeedItem(image: "water", text: "I need water", category: .need)
        
        XCTAssertEqual(item.image, "water")
        XCTAssertEqual(item.text, "I need water")
        XCTAssertEqual(item.category, .need)
        XCTAssertNotNil(item.id)
    }
    
    func testNeedItemCategories() throws {
        let needItem = NeedItem(image: "water", text: "Test", category: .need)
        let wantItem = NeedItem(image: "play", text: "Test", category: .want)
        let feelingItem = NeedItem(image: "happy", text: "Test", category: .feeling)
        
        XCTAssertEqual(needItem.category, .need)
        XCTAssertEqual(wantItem.category, .want)
        XCTAssertEqual(feelingItem.category, .feeling)
    }
    
    // MARK: - EmojiMapper Tests
    
    func testEmojiMapperForCommonWords() throws {
        // Test English
        XCTAssertEqual(EmojiMapper.emoji(for: "water", languageCode: "en"), "💧")
        XCTAssertEqual(EmojiMapper.emoji(for: "happy", languageCode: "en"), "😊")
        XCTAssertEqual(EmojiMapper.emoji(for: "help", languageCode: "en"), "🆘")
        
        // Test Spanish
        XCTAssertEqual(EmojiMapper.emoji(for: "agua", languageCode: "es"), "💧")
        XCTAssertEqual(EmojiMapper.emoji(for: "feliz", languageCode: "es"), "😊")
        
        // Test Chinese
        XCTAssertEqual(EmojiMapper.emoji(for: "水", languageCode: "zh"), "💧")
        XCTAssertEqual(EmojiMapper.emoji(for: "开心", languageCode: "zh"), "😊")
        
        // Test Portuguese
        XCTAssertEqual(EmojiMapper.emoji(for: "água", languageCode: "pt"), "💧")
        XCTAssertEqual(EmojiMapper.emoji(for: "feliz", languageCode: "pt"), "😊")
    }
    
    func testEmojiMapperHandlesUnknownWords() throws {
        let unknownEmoji = EmojiMapper.emoji(for: "nonexistent_word_xyz", languageCode: "en")
        XCTAssertNil(unknownEmoji, "Unknown words should return nil")
    }
    
    // MARK: - Use Case Tests
    
    func testLanguageSelectionUseCase() throws {
        // Simulate selecting each language
        let languages = SpeechBoardView.AppLanguage.allCases
        
        for language in languages {
            // Verify language code is valid
            XCTAssertFalse(language.rawValue.isEmpty)
            
            // Verify display name exists
            XCTAssertFalse(language.displayName.isEmpty)
            
            // Verify voice codes exist
            XCTAssertFalse(language.preferredVoiceCodes.isEmpty)
        }
    }
    
    func testCategoryViewUseCase() throws {
        // Test that each language has items for all categories
        let providers: [LocalizationProvider] = [
            EnglishLocalizationProvider(),
            HindiLocalizationProvider(),
            SpanishLocalizationProvider(),
            ChineseLocalizationProvider(),
            FrenchLocalizationProvider(),
            PortugueseLocalizationProvider()
        ]
        
        let needCategory: ItemCategory = .need
        let wantCategory: ItemCategory = .want
        let feelingCategory: ItemCategory = .feeling
        
        for provider in providers {
            let items = provider.items
            
            // Check each category has items
            let needItems = items.filter { $0.category == needCategory }
            let wantItems = items.filter { $0.category == wantCategory }
            let feelingItems = items.filter { $0.category == feelingCategory }
            
            XCTAssertGreaterThan(needItems.count, 0, "\(provider.languageCode) should have need items")
            XCTAssertGreaterThan(wantItems.count, 0, "\(provider.languageCode) should have want items")
            XCTAssertGreaterThan(feelingItems.count, 0, "\(provider.languageCode) should have feeling items")
            
            // Verify all items have required properties
            for item in items {
                XCTAssertFalse(item.image.isEmpty, "Item should have image")
                XCTAssertFalse(item.text.isEmpty, "Item should have text")
            }
        }
    }
    
    func testSentenceBuilderUseCase() throws {
        // Test that each language has a word bank for sentence building
        let providers: [LocalizationProvider] = [
            EnglishLocalizationProvider(),
            HindiLocalizationProvider(),
            SpanishLocalizationProvider(),
            ChineseLocalizationProvider(),
            FrenchLocalizationProvider(),
            PortugueseLocalizationProvider()
        ]
        
        for provider in providers {
            let wordBank = provider.wordBank
            
            XCTAssertGreaterThan(wordBank.count, 30, "\(provider.languageCode) should have substantial word bank")
            
            // Verify no empty words
            for word in wordBank {
                XCTAssertFalse(word.isEmpty, "Word bank should not contain empty strings")
            }
        }
    }
    
    func testTutorialUseCase() throws {
        // Test that all tutorial steps have localizations for all languages
        let languages = ["en", "hi", "es", "zh", "fr", "pt"]
        let tutorialSteps = [
            "tutorial_welcome_title",
            "tutorial_categories_title",
            "tutorial_needs_demo_title",
            "tutorial_sentence_builder_title",
            "tutorial_word_bank_title",
            "tutorial_typing_title",
            "tutorial_completion_title"
        ]
        
        for langCode in languages {
            for step in tutorialSteps {
                let title = Localizer.string(step, langCode: langCode)
                XCTAssertFalse(title.isEmpty, "Tutorial step '\(step)' should exist in \(langCode)")
            }
        }
    }
    
    func testTextToSpeechUseCase() throws {
        // Test that voice codes are properly formatted
        let languages = SpeechBoardView.AppLanguage.allCases
        
        for language in languages {
            let voiceCodes = language.preferredVoiceCodes
            
            for code in voiceCodes {
                // Voice codes should be in format "xx-XX" or "xx"
                XCTAssertTrue(code.contains("-") || code.count == 2, "Voice code '\(code)' should be properly formatted")
            }
        }
    }
    
    func testLanguageSwitchingUseCase() throws {
        // Test that switching between languages provides correct providers
        let languageCodes = ["en", "hi", "es", "zh", "fr", "pt"]
        
        for code in languageCodes {
            let language = SpeechBoardView.AppLanguage(rawValue: code)
            XCTAssertNotNil(language, "Language code '\(code)' should create valid AppLanguage")
        }
    }
    
    // MARK: - Integration Tests
    
    func testAllItemsHaveValidImageReferences() throws {
        // Standard image names used across all languages
        let validImages = [
            "water", "food", "bed", "toilet", "help", "medicine", "break", "quiet", "hug", "space",
            "walk", "play", "mom", "dad", "brother", "sister", "friend", "outside", "watch", "music",
            "mad", "sad", "happy", "anxious", "scared", "jealous", "tired", "excited", "confused", "sick"
        ]
        
        let providers: [LocalizationProvider] = [
            EnglishLocalizationProvider(),
            HindiLocalizationProvider(),
            SpanishLocalizationProvider(),
            ChineseLocalizationProvider(),
            FrenchLocalizationProvider(),
            PortugueseLocalizationProvider()
        ]
        
        for provider in providers {
            for item in provider.items {
                XCTAssertTrue(validImages.contains(item.image), 
                            "Item image '\(item.image)' in \(provider.languageCode) should be a standard image")
            }
        }
    }
    
    func testAllProvidersHaveConsistentItemCount() throws {
        let providers: [LocalizationProvider] = [
            EnglishLocalizationProvider(),
            HindiLocalizationProvider(),
            SpanishLocalizationProvider(),
            ChineseLocalizationProvider(),
            FrenchLocalizationProvider(),
            PortugueseLocalizationProvider()
        ]
        
        let expectedCount = 30
        
        for provider in providers {
            XCTAssertEqual(provider.items.count, expectedCount, 
                          "\(provider.languageCode) should have exactly \(expectedCount) items")
        }
    }
    
    func testAllProvidersHaveBalancedCategories() throws {
        let providers: [LocalizationProvider] = [
            EnglishLocalizationProvider(),
            HindiLocalizationProvider(),
            SpanishLocalizationProvider(),
            ChineseLocalizationProvider(),
            FrenchLocalizationProvider(),
            PortugueseLocalizationProvider()
        ]
        
        let needCategory: ItemCategory = .need
        let wantCategory: ItemCategory = .want
        let feelingCategory: ItemCategory = .feeling
        
        for provider in providers {
            let items = provider.items
            let needs = items.filter { $0.category == needCategory }
            let wants = items.filter { $0.category == wantCategory }
            let feelings = items.filter { $0.category == feelingCategory }
            
            XCTAssertEqual(needs.count, wants.count, 
                          "\(provider.languageCode) should have balanced categories")
            XCTAssertEqual(wants.count, feelings.count, 
                          "\(provider.languageCode) should have balanced categories")
        }
    }
    
    // MARK: - Performance Tests
    
    func testProviderCreationPerformance() throws {
        measure {
            _ = EnglishLocalizationProvider()
            _ = HindiLocalizationProvider()
            _ = SpanishLocalizationProvider()
            _ = ChineseLocalizationProvider()
            _ = FrenchLocalizationProvider()
            _ = PortugueseLocalizationProvider()
        }
    }
    
    func testLocalizationLookupPerformance() throws {
        let keys = ["choose_category", "sentence_builder", "back", "tutorial_button"]
        
        measure {
            for langCode in ["en", "hi", "es", "zh", "fr", "pt"] {
                for key in keys {
                    _ = Localizer.string(key, langCode: langCode)
                }
            }
        }
    }
    
    func testEmojiLookupPerformance() throws {
        let words = ["water", "food", "happy", "help", "home"]
        
        measure {
            for langCode in ["en", "hi", "es", "zh", "fr", "pt"] {
                for word in words {
                    _ = EmojiMapper.emoji(for: word, languageCode: langCode)
                }
            }
        }
    }

}


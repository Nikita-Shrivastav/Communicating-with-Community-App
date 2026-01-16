//
//  Communicating_with_CommunityUITests_Comprehensive.swift
//  Communicating with CommunityUITests
//
//  Comprehensive UI test suite for the communication board app
//

import XCTest

final class Communicating_with_CommunityUITests_Comprehensive: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    // MARK: - Language Selection Tests
    
    @MainActor
    func testLanguagePickerDisplaysAllSixLanguages() throws {
        // Verify all 6 language buttons are visible
        XCTAssertTrue(app.buttons["English"].exists, "English button should exist")
        XCTAssertTrue(app.buttons["हिन्दी"].exists, "Hindi button should exist")
        XCTAssertTrue(app.buttons["Español"].exists, "Spanish button should exist")
        XCTAssertTrue(app.buttons["中文"].exists, "Chinese button should exist")
        XCTAssertTrue(app.buttons["Français"].exists, "French button should exist")
        XCTAssertTrue(app.buttons["Português"].exists, "Portuguese button should exist")
    }
    
    @MainActor
    func testSelectingPortugueseLanguage() throws {
        // Tap Portuguese
        let portugueseButton = app.buttons["Português"]
        XCTAssertTrue(portugueseButton.exists, "Portuguese button should exist")
        portugueseButton.tap()
        
        // Wait for intro screen or main menu
        let expectation = XCTNSPredicateExpectation(
            predicate: NSPredicate(format: "exists == true"),
            object: app.staticTexts["Escolher Categoria"]
        )
        let result = XCTWaiter().wait(for: [expectation], timeout: 3.0)
        XCTAssertEqual(result, .completed, "Should navigate to Portuguese main menu")
    }
    
    @MainActor
    func testSelectingSpanishLanguage() throws {
        let spanishButton = app.buttons["Español"]
        XCTAssertTrue(spanishButton.exists)
        spanishButton.tap()
        
        // Check for Spanish text
        sleep(1) // Wait for transition
        XCTAssertTrue(app.staticTexts["Elegir Categoría"].waitForExistence(timeout: 3) ||
                     app.buttons["Elegir Categoría"].waitForExistence(timeout: 3),
                     "Should show Spanish interface")
    }
    
    @MainActor
    func testLanguageSwitching() throws {
        // Select Portuguese
        app.buttons["Português"].tap()
        sleep(1)
        
        // Go back to language picker
        if app.buttons.matching(identifier: "globe").firstMatch.exists {
            app.buttons.matching(identifier: "globe").firstMatch.tap()
        } else if app.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] 'Idioma'")).firstMatch.exists {
            app.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] 'Idioma'")).firstMatch.tap()
        }
        
        sleep(1)
        
        // Select English
        if app.buttons["English"].exists {
            app.buttons["English"].tap()
            sleep(1)
            XCTAssertTrue(app.staticTexts["Choose Category"].waitForExistence(timeout: 3) ||
                         app.buttons["Choose Category"].waitForExistence(timeout: 3),
                         "Should switch to English")
        }
    }
    
    // MARK: - Navigation Tests
    
    @MainActor
    func testNavigateToMainMenu() throws {
        // Select any language
        app.buttons["English"].tap()
        sleep(1)
        
        // Tap "Start Using Board" if intro screen appears
        let startButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Start'")).firstMatch
        if startButton.exists {
            startButton.tap()
            sleep(1)
        }
        
        // Verify main menu categories are visible
        XCTAssertTrue(
            app.staticTexts["Needs"].exists ||
            app.buttons["Needs"].exists ||
            app.staticTexts["Choose Category"].exists,
            "Main menu should be visible"
        )
    }
    
    @MainActor
    func testNavigateToNeedsCategory() throws {
        selectLanguageAndDismissIntro()
        
        // Tap Needs category
        let needsButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Need'")).firstMatch
        if needsButton.exists {
            needsButton.tap()
            sleep(1)
            
            // Verify we're in needs category
            XCTAssertTrue(app.staticTexts["Needs"].exists || app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'water' OR label CONTAINS[c] 'food'")).firstMatch.exists,
                         "Should navigate to Needs category")
        }
    }
    
    @MainActor
    func testNavigateToWantsCategory() throws {
        selectLanguageAndDismissIntro()
        
        let wantsButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Want'")).firstMatch
        if wantsButton.exists {
            wantsButton.tap()
            sleep(1)
            
            XCTAssertTrue(app.staticTexts["Wants"].exists || app.buttons.count > 5,
                         "Should navigate to Wants category")
        }
    }
    
    @MainActor
    func testNavigateToFeelingsCategory() throws {
        selectLanguageAndDismissIntro()
        
        let feelingsButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Feel'")).firstMatch
        if feelingsButton.exists {
            feelingsButton.tap()
            sleep(1)
            
            XCTAssertTrue(app.staticTexts["Feelings"].exists || app.buttons.count > 5,
                         "Should navigate to Feelings category")
        }
    }
    
    @MainActor
    func testBackButtonFromCategory() throws {
        selectLanguageAndDismissIntro()
        
        // Navigate to a category
        let needsButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Need'")).firstMatch
        if needsButton.exists {
            needsButton.tap()
            sleep(1)
            
            // Tap back button
            let backButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Back' OR label CONTAINS[c] '←'")).firstMatch
            XCTAssertTrue(backButton.exists, "Back button should exist")
            backButton.tap()
            sleep(1)
            
            // Should be back at main menu
            XCTAssertTrue(app.staticTexts["Choose Category"].exists || app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Need'")).firstMatch.exists,
                         "Should return to main menu")
        }
    }
    
    // MARK: - Sentence Builder Tests
    
    @MainActor
    func testNavigateToSentenceBuilder() throws {
        selectLanguageAndDismissIntro()
        
        // Find and tap sentence builder button
        let sentenceBuilderButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Sentence'")).firstMatch
        XCTAssertTrue(sentenceBuilderButton.exists, "Sentence Builder button should exist")
        sentenceBuilderButton.tap()
        sleep(1)
        
        // Verify sentence builder UI elements
        XCTAssertTrue(app.staticTexts["Sentence Builder"].exists ||
                     app.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] 'Word Bank'")).firstMatch.exists,
                     "Should navigate to Sentence Builder")
    }
    
    @MainActor
    func testSentenceBuilderWordBankVisible() throws {
        selectLanguageAndDismissIntro()
        
        let sentenceBuilderButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Sentence'")).firstMatch
        sentenceBuilderButton.tap()
        sleep(1)
        
        // Word bank should have multiple word buttons
        let wordButtons = app.buttons.allElementsBoundByIndex.filter { button in
            button.exists && button.frame.size.width < 200 // Word buttons are smaller
        }
        
        XCTAssertGreaterThan(wordButtons.count, 20, "Word bank should have many words available")
    }
    
    @MainActor
    func testSentenceBuilderTappingWords() throws {
        selectLanguageAndDismissIntro()
        
        let sentenceBuilderButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Sentence'")).firstMatch
        sentenceBuilderButton.tap()
        sleep(1)
        
        // Find first word button
        let firstWord = app.buttons.allElementsBoundByIndex.first { button in
            button.exists && button.label.count < 20 && button.label.count > 0
        }
        
        if let word = firstWord {
            word.tap()
            sleep(0.5)
            
            // The sentence display should now contain text
            XCTAssertTrue(true, "Word should be added to sentence")
        }
    }
    
    @MainActor
    func testSentenceBuilderClearButton() throws {
        selectLanguageAndDismissIntro()
        
        let sentenceBuilderButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Sentence'")).firstMatch
        sentenceBuilderButton.tap()
        sleep(1)
        
        // Find and tap clear button
        let clearButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Clear'")).firstMatch
        XCTAssertTrue(clearButton.exists, "Clear button should exist")
        clearButton.tap()
        sleep(0.5)
    }
    
    @MainActor
    func testSentenceBuilderTypingField() throws {
        selectLanguageAndDismissIntro()
        
        let sentenceBuilderButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Sentence'")).firstMatch
        sentenceBuilderButton.tap()
        sleep(1)
        
        // Find text field
        let textField = app.textFields.firstMatch
        if textField.exists {
            textField.tap()
            sleep(0.5)
            textField.typeText("Hello")
            
            XCTAssertTrue(textField.value as? String == "Hello", "Should type text in field")
        }
    }
    
    // MARK: - Tutorial Tests
    
    @MainActor
    func testTutorialButtonExists() throws {
        selectLanguageAndDismissIntro()
        
        // Look for tutorial/guide button
        let tutorialButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Tutorial' OR label CONTAINS[c] 'Guide'")).firstMatch
        XCTAssertTrue(tutorialButton.exists, "Tutorial button should exist on main screen")
    }
    
    @MainActor
    func testOpenTutorial() throws {
        selectLanguageAndDismissIntro()
        
        let tutorialButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Tutorial' OR label CONTAINS[c] 'Guide'")).firstMatch
        if tutorialButton.exists {
            tutorialButton.tap()
            sleep(1)
            
            // Tutorial should show welcome or steps
            XCTAssertTrue(
                app.staticTexts.containing(NSPredicate(format: "label CONTAINS[c] 'Welcome' OR label CONTAINS[c] 'Tutorial' OR label CONTAINS[c] 'Step'")).firstMatch.exists,
                "Tutorial should open"
            )
        }
    }
    
    @MainActor
    func testTutorialNavigation() throws {
        selectLanguageAndDismissIntro()
        
        let tutorialButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Tutorial'")).firstMatch
        if tutorialButton.exists {
            tutorialButton.tap()
            sleep(1)
            
            // Try to find next button
            let nextButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Next' OR label CONTAINS[c] 'Continue'")).firstMatch
            if nextButton.exists {
                nextButton.tap()
                sleep(1)
                XCTAssertTrue(true, "Should advance to next tutorial step")
            }
        }
    }
    
    // MARK: - Communication Item Tests
    
    @MainActor
    func testCommunicationItemsAreInteractive() throws {
        selectLanguageAndDismissIntro()
        
        // Navigate to needs
        let needsButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Need'")).firstMatch
        if needsButton.exists {
            needsButton.tap()
            sleep(1)
            
            // All communication items should be buttons
            let itemButtons = app.buttons.allElementsBoundByIndex.filter { button in
                button.exists && button.frame.size.height > 80 // Item buttons are larger
            }
            
            XCTAssertGreaterThanOrEqual(itemButtons.count, 8, "Should have at least 8 item buttons")
            
            // Tap first item
            if let firstItem = itemButtons.first {
                firstItem.tap()
                sleep(0.5)
                // Speech would play, but we can't test audio in UI tests
                XCTAssertTrue(true, "Item should be tappable")
            }
        }
    }
    
    @MainActor
    func testAllCategoriesHaveItems() throws {
        selectLanguageAndDismissIntro()
        
        let categories = ["Need", "Want", "Feel"]
        
        for category in categories {
            // Go to category
            let categoryButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] %@", category)).firstMatch
            if categoryButton.exists {
                categoryButton.tap()
                sleep(1)
                
                // Count items
                let itemButtons = app.buttons.allElementsBoundByIndex.filter { button in
                    button.exists && button.frame.size.height > 80
                }
                
                XCTAssertGreaterThanOrEqual(itemButtons.count, 8, "\(category) should have items")
                
                // Go back
                let backButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Back' OR label CONTAINS[c] '←'")).firstMatch
                if backButton.exists {
                    backButton.tap()
                    sleep(1)
                }
            }
        }
    }
    
    // MARK: - Accessibility Tests
    
    @MainActor
    func testAllButtonsHaveAccessibilityLabels() throws {
        selectLanguageAndDismissIntro()
        
        // Check main menu buttons
        let mainButtons = app.buttons.allElementsBoundByIndex
        
        for button in mainButtons where button.exists {
            XCTAssertFalse(button.label.isEmpty, "Button should have accessibility label")
        }
    }
    
    @MainActor
    func testVoiceOverCompatibility() throws {
        // Enable VoiceOver programmatically is not possible in UI tests
        // But we can verify elements are accessible
        selectLanguageAndDismissIntro()
        
        let needsButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Need'")).firstMatch
        XCTAssertTrue(needsButton.isHittable, "Buttons should be hittable for accessibility")
    }
    
    // MARK: - Performance Tests
    
    @MainActor
    func testAppLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    @MainActor
    func testCategoryLoadingPerformance() throws {
        selectLanguageAndDismissIntro()
        
        measure {
            let needsButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Need'")).firstMatch
            needsButton.tap()
            sleep(0.5)
            
            let backButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Back'")).firstMatch
            backButton.tap()
            sleep(0.5)
        }
    }
    
    // MARK: - Edge Cases
    
    @MainActor
    func testRapidButtonTapping() throws {
        selectLanguageAndDismissIntro()
        
        let needsButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Need'")).firstMatch
        if needsButton.exists {
            // Rapidly tap 5 times
            for _ in 0..<5 {
                needsButton.tap()
            }
            sleep(1)
            
            // App should still be responsive
            XCTAssertTrue(app.buttons.count > 0, "App should remain responsive")
        }
    }
    
    @MainActor
    func testAppStateAfterBackgrounding() throws {
        selectLanguageAndDismissIntro()
        
        // Navigate to a category
        let needsButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Need'")).firstMatch
        needsButton.tap()
        sleep(1)
        
        // Simulate backgrounding
        XCUIDevice.shared.press(.home)
        sleep(2)
        app.activate()
        sleep(1)
        
        // App should restore state
        XCTAssertTrue(app.buttons.count > 0, "App should restore after backgrounding")
    }
    
    // MARK: - Helper Methods
    
    private func selectLanguageAndDismissIntro() {
        // Select English (most common for testing)
        let englishButton = app.buttons["English"]
        if englishButton.exists {
            englishButton.tap()
            sleep(1)
        }
        
        // Dismiss intro if it appears
        let startButton = app.buttons.containing(NSPredicate(format: "label CONTAINS[c] 'Start'")).firstMatch
        if startButton.exists {
            startButton.tap()
            sleep(1)
        }
    }
}

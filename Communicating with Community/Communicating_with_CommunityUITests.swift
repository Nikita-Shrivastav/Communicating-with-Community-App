//
//  Communicating_with_CommunityUITests.swift
//  Communicating with CommunityUITests
//

import XCTest

final class Communicating_with_CommunityUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        // Signal the app to reset UserDefaults before @AppStorage initialises,
        // so every test starts cleanly at the language picker.
        // launchEnvironment is read via ProcessInfo in App.init().
        app.launchEnvironment["UI_TESTING_RESET"] = "1"
        app.launch()
        // Allow time for the window and any full-screen/layout animations to
        // settle before any test interaction begins.
        _ = app.buttons["English"].waitForExistence(timeout: 8)
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - Helper: find intro screen action buttons
    // Buttons are pinned at the top of IntroView so no scrolling is needed,
    // but we still wait for existence to let the view transition complete.
    private func scrollIntroToButton(identifier: String) -> XCUIElement {
        let button = app.buttons[identifier]
        _ = button.waitForExistence(timeout: 5)
        return button
    }

    // MARK: - Helper: reach the main menu from a cold launch

    /// Selects English on the language picker, dismisses the intro, and lands on the main menu.
    private func navigateToMainMenu() {
        let englishButton = app.buttons["English"]
        XCTAssertTrue(englishButton.waitForExistence(timeout: 5), "Language picker should show English button")
        englishButton.tap()

        let startButton = app.buttons["intro_start_button"]
        XCTAssertTrue(startButton.waitForExistence(timeout: 5), "Intro screen start button should appear")
        startButton.tap()

        // Wait for the main menu heading identifier — language-independent and unambiguous
        XCTAssertTrue(
            app.staticTexts["main_menu_heading"].waitForExistence(timeout: 5),
            "Main menu should appear after tapping Start"
        )
    }

    // MARK: - Language Picker Tests

    func testLanguagePickerAppears() {
        XCTAssertTrue(app.buttons["English"].waitForExistence(timeout: 3),
                      "Language picker should display the English language button")
    }

    func testAllSixLanguageButtonsAreVisible() {
        XCTAssertTrue(app.buttons["English"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["Español"].exists)
        XCTAssertTrue(app.buttons["Français"].exists)
        XCTAssertTrue(app.buttons["Português"].exists)

        // Hindi and Chinese use their native scripts
        XCTAssertTrue(app.buttons["हिन्दी"].exists)
        XCTAssertTrue(app.buttons["中文"].exists)
    }

    func testSelectingEnglishDismissesLanguagePicker() {
        app.buttons["English"].tap()
        // After selection the picker should be gone and the intro should appear
        XCTAssertFalse(app.buttons["English"].waitForExistence(timeout: 1),
                       "Language picker should be dismissed after selection")
        let startButton = app.buttons.matching(NSPredicate(format: "label CONTAINS 'Start'")).firstMatch
        XCTAssertTrue(startButton.waitForExistence(timeout: 3),
                      "Intro screen should appear after language selection")
    }

    func testSelectingSpanishShowsSpanishIntro() {
        app.buttons["Español"].tap()
        // The start button has a stable identifier regardless of language
        let startButton = app.buttons["intro_start_button"]
        XCTAssertTrue(startButton.waitForExistence(timeout: 5),
                      "After selecting Spanish the intro should show a start button")
    }

    func testHearPromptButtonExists() {
        // "Hear a prompt" / "Hear the prompt" button on the language picker
        let hearButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'hear' OR label CONTAINS[c] 'prompt' OR label CONTAINS[c] 'escuchar'")).firstMatch
        XCTAssertTrue(hearButton.waitForExistence(timeout: 3),
                      "A 'Hear prompt' button should be visible on the language picker")
    }

    // MARK: - Intro Screen Tests

    func testIntroScreenShowsTitle() {
        app.buttons["English"].tap()
        let title = app.staticTexts["Communicating with Community"]
        XCTAssertTrue(title.waitForExistence(timeout: 3),
                      "Intro screen should display the app title")
    }

    func testIntroScreenStartButtonNavigatesToMainMenu() {
        app.buttons["English"].tap()
        let startButton = app.buttons["intro_start_button"]
        XCTAssertTrue(startButton.waitForExistence(timeout: 5))
        startButton.tap()

        XCTAssertTrue(
            app.staticTexts["main_menu_heading"].waitForExistence(timeout: 5),
            "Main menu should appear after tapping start on the intro screen"
        )
    }

    func testIntroScreenGuidedTutorialButtonExists() {
        app.buttons["English"].tap()
        let tutorialButton = scrollIntroToButton(identifier: "intro_tutorial_button")
        XCTAssertTrue(tutorialButton.waitForExistence(timeout: 3),
                      "Intro screen should show a Guided Tutorial button")
    }

    func testIntroScreenHearSummaryButtonExists() {
        app.buttons["English"].tap()
        let hearButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'summary' OR label CONTAINS[c] 'hear'")).firstMatch
        XCTAssertTrue(hearButton.waitForExistence(timeout: 3),
                      "Intro screen should show a 'Hear a quick summary' button")
    }

    // MARK: - Main Menu Tests

    func testMainMenuShowsCategoryButtons() {
        navigateToMainMenu()

        // All three category buttons should be visible
        let needsButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'need'")).firstMatch
        let wantsButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'want'")).firstMatch
        let feelingsButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'feel'")).firstMatch

        XCTAssertTrue(needsButton.waitForExistence(timeout: 3), "Main menu should show a Needs button")
        XCTAssertTrue(wantsButton.exists, "Main menu should show a Wants button")
        XCTAssertTrue(feelingsButton.exists, "Main menu should show a Feelings button")
    }

    func testMainMenuShowsSentenceBuilderButton() {
        navigateToMainMenu()
        let sbButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'sentence'")).firstMatch
        XCTAssertTrue(sbButton.waitForExistence(timeout: 3),
                      "Main menu should show a Sentence Builder button")
    }

    func testMainMenuShowsTranscribeButton() {
        navigateToMainMenu()
        let transcribeButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'transcribe'")).firstMatch
        XCTAssertTrue(transcribeButton.waitForExistence(timeout: 3),
                      "Main menu should show a Transcribe button")
    }

    func testMainMenuShowsTutorialButton() {
        navigateToMainMenu()
        let tutorialButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'tutorial'")).firstMatch
        XCTAssertTrue(tutorialButton.waitForExistence(timeout: 3),
                      "Main menu should show a Tutorial button in the toolbar area")
    }

    func testMainMenuShowsChangeLanguageButton() {
        navigateToMainMenu()
        let changeButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'language'")).firstMatch
        XCTAssertTrue(changeButton.waitForExistence(timeout: 3),
                      "Main menu should show a Change Language button")
    }

    func testMainMenuInfoButtonExists() {
        navigateToMainMenu()
        let infoButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'info'")).firstMatch
        XCTAssertTrue(infoButton.waitForExistence(timeout: 3),
                      "Main menu should show an Info button")
    }

    // MARK: - Category Navigation Tests

    func testTappingNeedsOpensCategoryView() {
        navigateToMainMenu()
        let needsButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'need'")).firstMatch
        XCTAssertTrue(needsButton.waitForExistence(timeout: 3))
        needsButton.tap()

        // A back button should now be visible
        let backButton = app.buttons.matching(NSPredicate(format: "label CONTAINS '←' OR label CONTAINS[c] 'back'")).firstMatch
        XCTAssertTrue(backButton.waitForExistence(timeout: 3),
                      "Category view should show a back button")
    }

    func testTappingWantsOpensCategoryView() {
        navigateToMainMenu()
        let wantsButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'want'")).firstMatch
        XCTAssertTrue(wantsButton.waitForExistence(timeout: 3))
        wantsButton.tap()

        let backButton = app.buttons.matching(NSPredicate(format: "label CONTAINS '←' OR label CONTAINS[c] 'back'")).firstMatch
        XCTAssertTrue(backButton.waitForExistence(timeout: 3),
                      "Category view should show a back button after tapping Wants")
    }

    func testTappingFeelingsOpensCategoryView() {
        navigateToMainMenu()
        let feelingsButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'feel'")).firstMatch
        XCTAssertTrue(feelingsButton.waitForExistence(timeout: 3))
        feelingsButton.tap()

        let backButton = app.buttons.matching(NSPredicate(format: "label CONTAINS '←' OR label CONTAINS[c] 'back'")).firstMatch
        XCTAssertTrue(backButton.waitForExistence(timeout: 3),
                      "Category view should show a back button after tapping Feelings")
    }

    func testNeedsCategoryShowsTenItems() {
        navigateToMainMenu()
        app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'need'")).firstMatch.tap()

        // Wait for the grid to load and count communication item buttons
        // Back button also matches 'button', so we look for at least 10 content buttons
        let allButtons = app.buttons.allElementsBoundByIndex
        let itemButtons = allButtons.filter { btn in
            let label = btn.label
            return !label.contains("←") && !label.isEmpty && !label.lowercased().contains("back")
        }
        XCTAssertGreaterThanOrEqual(itemButtons.count, 10,
                                    "Needs category should display at least 10 item buttons")
    }

    func testBackButtonReturnsToMainMenu() {
        navigateToMainMenu()
        app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'need'")).firstMatch.tap()

        let backButton = app.buttons.matching(NSPredicate(format: "label CONTAINS '←' OR label CONTAINS[c] 'back'")).firstMatch
        XCTAssertTrue(backButton.waitForExistence(timeout: 3))
        backButton.tap()

        // Main menu category buttons should reappear
        let needsButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'need'")).firstMatch
        XCTAssertTrue(needsButton.waitForExistence(timeout: 3),
                      "Tapping back should return to the main menu")
    }

    // MARK: - Helper: navigate into Sentence Builder

    /// Taps the Sentence Builder button from the main menu and waits for the
    /// unique heading identifier that only exists inside the builder.
    private func openSentenceBuilder() {
        let sbButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'sentence'")).firstMatch
        XCTAssertTrue(sbButton.waitForExistence(timeout: 3))
        sbButton.tap()
        // "sentence_builder_heading" is only present inside the builder, not on the menu
        XCTAssertTrue(
            app.staticTexts["sentence_builder_heading"].waitForExistence(timeout: 3),
            "Sentence Builder heading should appear"
        )
    }

    /// Scrolls the sentence builder until the word bank heading is hittable.
    private func scrollSentenceBuilderToWordBank() {
        let wordBankHeading = app.staticTexts["word_bank_heading"]
        let scrollView = app.scrollViews.firstMatch
        _ = scrollView.waitForExistence(timeout: 2)
        for _ in 0..<8 {
            if wordBankHeading.exists && wordBankHeading.isHittable { break }
            scrollView.swipeUp()
        }
    }

    // MARK: - Sentence Builder Tests

    func testSentenceBuilderOpens() {
        navigateToMainMenu()
        let sbButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'sentence'")).firstMatch
        XCTAssertTrue(sbButton.waitForExistence(timeout: 3))
        sbButton.tap()

        // "sentence_builder_heading" is only present inside the builder
        let heading = app.staticTexts["sentence_builder_heading"]
        XCTAssertTrue(heading.waitForExistence(timeout: 3),
                      "Sentence Builder screen should appear with a heading")
    }

    func testSentenceBuilderShowsSpeakButton() {
        navigateToMainMenu()
        openSentenceBuilder()

        let speakButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'speak'")).firstMatch
        XCTAssertTrue(speakButton.waitForExistence(timeout: 3),
                      "Sentence Builder should have a Speak button")
    }

    func testSentenceBuilderShowsClearButton() {
        navigateToMainMenu()
        openSentenceBuilder()

        let clearButton = app.buttons["clear_words_button"]
        XCTAssertTrue(clearButton.waitForExistence(timeout: 3),
                      "Sentence Builder should have a Clear button")
    }

    func testSentenceBuilderShowsWordBank() {
        navigateToMainMenu()
        openSentenceBuilder()
        scrollSentenceBuilderToWordBank()

        let wordBankLabel = app.staticTexts["word_bank_heading"]
        XCTAssertTrue(wordBankLabel.waitForExistence(timeout: 3),
                      "Sentence Builder should display a word bank section")
    }

    func testTappingWordBankWordAddsItToSentence() {
        navigateToMainMenu()
        openSentenceBuilder()
        scrollSentenceBuilderToWordBank()

        // "I" is the first English word bank word; .accessibilityLabel(word) gives exact match
        let wordButton = app.buttons["I"]
        XCTAssertTrue(wordButton.waitForExistence(timeout: 5))
        wordButton.tap()

        // sentence_display accessibilityValue reflects the sentence regardless of scroll position
        let sentenceDisplay = app.staticTexts["sentence_display"]
        XCTAssertTrue(sentenceDisplay.waitForExistence(timeout: 3),
                      "Tapping a word bank word should add it to the sentence display")
        XCTAssertTrue(sentenceDisplay.value as? String == "I",
                      "Sentence display should contain the tapped word")
    }

    func testClearWordsBankResetsTheSentence() {
        navigateToMainMenu()
        openSentenceBuilder()
        scrollSentenceBuilderToWordBank()

        // Tap "I" from the word bank
        let wordButton = app.buttons["I"]
        XCTAssertTrue(wordButton.waitForExistence(timeout: 5))
        wordButton.tap()

        // clear_words_button lives in the sticky header above the scroll view.
        // Use a coordinate tap to bypass macOS hit-test region checks.
        let clearButton = app.buttons["clear_words_button"]
        XCTAssertTrue(clearButton.waitForExistence(timeout: 3))
        clearButton.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()

        // Poll for up to 4 seconds for the sentence display to report an empty value
        let sentenceDisplay = app.staticTexts["sentence_display"]
        XCTAssertTrue(sentenceDisplay.waitForExistence(timeout: 3))
        var cleared = false
        for _ in 0..<8 {
            if (sentenceDisplay.value as? String ?? "x").isEmpty {
                cleared = true
                break
            }
            Thread.sleep(forTimeInterval: 0.5)
        }
        XCTAssertTrue(cleared, "Sentence display should be empty after tapping Clear")
    }

    func testSentenceBuilderBackButtonReturnsToMenu() {
        navigateToMainMenu()
        openSentenceBuilder()

        let backButton = app.buttons.matching(NSPredicate(format: "label CONTAINS '←' OR label CONTAINS[c] 'back'")).firstMatch
        XCTAssertTrue(backButton.waitForExistence(timeout: 3))
        backButton.tap()

        let sbButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'sentence'")).firstMatch
        XCTAssertTrue(sbButton.waitForExistence(timeout: 3),
                      "Back from Sentence Builder should return to the main menu")
    }

    // MARK: - Transcribe Screen Tests

    func testTranscribeSheetOpens() {
        navigateToMainMenu()
        let transcribeButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'transcribe'")).firstMatch
        XCTAssertTrue(transcribeButton.waitForExistence(timeout: 3))
        transcribeButton.tap()

        // The sheet's Start button should appear
        let startButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'start'")).firstMatch
        XCTAssertTrue(startButton.waitForExistence(timeout: 4),
                      "Transcribe sheet should open and show a Start button")
    }

    func testTranscribeSheetShowsStopButton() {
        navigateToMainMenu()
        app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'transcribe'")).firstMatch.tap()

        let startButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'start'")).firstMatch
        XCTAssertTrue(startButton.waitForExistence(timeout: 4))
        startButton.tap()

        let stopButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'stop'")).firstMatch
        XCTAssertTrue(stopButton.waitForExistence(timeout: 3),
                      "Tapping Start in Transcribe should reveal a Stop button")
    }

    // MARK: - Tutorial Tests

    func testTutorialOpensFromMainMenu() {
        navigateToMainMenu()
        let tutorialButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'tutorial'")).firstMatch
        XCTAssertTrue(tutorialButton.waitForExistence(timeout: 3))
        tutorialButton.tap()

        // Tutorial should show a "Next" or step indicator
        let nextOrStep = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'next' OR label CONTAINS[c] 'step'")).firstMatch
        let stepText = app.staticTexts.matching(NSPredicate(format: "label CONTAINS[c] 'step'")).firstMatch
        let found = nextOrStep.waitForExistence(timeout: 3) || stepText.waitForExistence(timeout: 1)
        XCTAssertTrue(found, "Tutorial should display step navigation controls")
    }

    func testTutorialOpensFromIntroScreen() {
        app.buttons["English"].tap()
        let tutorialButton = scrollIntroToButton(identifier: "intro_tutorial_button")
        XCTAssertTrue(tutorialButton.exists, "Intro tutorial button should exist")
        tutorialButton.tap()

        // Wait for the step indicator, which is always visible at the top of GuidedTutorialView
        XCTAssertTrue(
            app.staticTexts["tutorial_step_indicator"].waitForExistence(timeout: 8),
            "Tutorial should open from the intro screen"
        )
    }

    func testTutorialCanBeExited() {
        navigateToMainMenu()
        app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'tutorial'")).firstMatch.tap()

        // Exit/close button
        let exitButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'exit' OR label CONTAINS[c] 'close' OR label CONTAINS[c] 'done' OR label CONTAINS[c] 'skip'")).firstMatch
        XCTAssertTrue(exitButton.waitForExistence(timeout: 3),
                      "Tutorial should provide an exit or close button")
        exitButton.tap()

        // Should return to the main menu
        let sbButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'sentence'")).firstMatch
        XCTAssertTrue(sbButton.waitForExistence(timeout: 3),
                      "Exiting the tutorial should return to the main menu")
    }

    // MARK: - Language Switching Tests

    func testChangeLanguageButtonReturnsToLanguagePicker() {
        navigateToMainMenu()
        let changeLangButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'language'")).firstMatch
        XCTAssertTrue(changeLangButton.waitForExistence(timeout: 3))
        changeLangButton.tap()

        // The language picker grid should reappear
        XCTAssertTrue(app.buttons["English"].waitForExistence(timeout: 3),
                      "Tapping Change Language should bring back the language picker")
    }

    func testSwitchingToFrenchShowsFrenchMainMenu() {
        navigateToMainMenu()

        // Switch to French
        app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'language'")).firstMatch.tap()
        app.buttons["Français"].tap()

        // French intro — scroll to reveal "Commencer à Utiliser le Tableau"
        let frenchStart = scrollIntroToButton(identifier: "intro_start_button")
        XCTAssertTrue(frenchStart.waitForExistence(timeout: 3),
                      "French intro start button should appear after switching to French")
        frenchStart.tap()

        // French menu should show "Besoins" (Needs in French)
        let besoinsButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'besoins'")).firstMatch
        XCTAssertTrue(besoinsButton.waitForExistence(timeout: 3),
                      "Switching to French should localise the main menu to French")
    }

    func testSwitchingToPortugueseShowsPortugueseMainMenu() {
        navigateToMainMenu()

        app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'language'")).firstMatch.tap()
        app.buttons["Português"].tap()

        // Portuguese intro — scroll to reveal "Começar a Usar o Quadro"
        let ptStart = scrollIntroToButton(identifier: "intro_start_button")
        XCTAssertTrue(ptStart.waitForExistence(timeout: 3),
                      "Portuguese intro start button should appear after switching to Portuguese")
        ptStart.tap()

        // Portuguese menu should show "Necessidades" (Needs in Portuguese)
        let needsButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'necessidades'")).firstMatch
        XCTAssertTrue(needsButton.waitForExistence(timeout: 3),
                      "Switching to Portuguese should localise the main menu to Portuguese")
    }

    // MARK: - Accessibility Tests

    func testCategoryButtonsMeetMinimumTapTargetSize() {
        navigateToMainMenu()

        let needsButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'need'")).firstMatch
        XCTAssertTrue(needsButton.waitForExistence(timeout: 3))

        let frame = needsButton.frame
        // The app targets a minimum of 140×160 pt
        XCTAssertGreaterThanOrEqual(frame.width, 140,
                                    "Category buttons should be at least 140pt wide")
        XCTAssertGreaterThanOrEqual(frame.height, 140,
                                    "Category buttons should be at least 140pt tall")
    }

    func testInfoButtonNavigatesToIntroScreen() {
        navigateToMainMenu()
        let infoButton = app.buttons.matching(NSPredicate(format: "label CONTAINS[c] 'info'")).firstMatch
        XCTAssertTrue(infoButton.waitForExistence(timeout: 3))
        infoButton.tap()

        let introTitle = app.staticTexts["Communicating with Community"]
        XCTAssertTrue(introTitle.waitForExistence(timeout: 3),
                      "Tapping Info should navigate back to the intro screen")
    }
}

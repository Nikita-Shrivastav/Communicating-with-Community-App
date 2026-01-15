import Foundation
import AVFoundation

/// Quick verification script for Portuguese language support
/// Run this in a Playground or add to a test target to verify Portuguese integration
struct PortugueseVerification {
    
    // MARK: - Verification Results
    
    struct VerificationResult {
        let testName: String
        let passed: Bool
        let message: String
    }
    
    // MARK: - Main Verification
    
    static func runAllVerifications() -> [VerificationResult] {
        var results: [VerificationResult] = []
        
        print("🔍 Starting Portuguese Language Verification...\n")
        
        // Test 1: Enum exists
        results.append(verifyEnumExists())
        
        // Test 2: Provider exists
        results.append(verifyProviderExists())
        
        // Test 3: Items count
        results.append(verifyItemsCount())
        
        // Test 4: Word bank
        results.append(verifyWordBank())
        
        // Test 5: Localizations
        results.append(verifyLocalizations())
        
        // Test 6: Voice codes
        results.append(verifyVoiceCodes())
        
        // Test 7: Category titles
        results.append(verifyCategoryTitles())
        
        // Test 8: Emojis
        results.append(verifyEmojis())
        
        // Print summary
        printSummary(results)
        
        return results
    }
    
    // MARK: - Individual Verifications
    
    static func verifyEnumExists() -> VerificationResult {
        let allLanguages = SpeechBoardView.AppLanguage.allCases
        let hasPortuguese = allLanguages.contains(.portuguese)
        let correctCode = SpeechBoardView.AppLanguage.portuguese.rawValue == "pt"
        
        let passed = hasPortuguese && correctCode
        let message = passed 
            ? "✅ Portuguese enum exists with code 'pt'" 
            : "❌ Portuguese enum missing or has wrong code"
        
        print(message)
        return VerificationResult(testName: "Enum Exists", passed: passed, message: message)
    }
    
    static func verifyProviderExists() -> VerificationResult {
        let provider = PortugueseLocalizationProvider()
        let passed = provider.languageCode == "pt" && provider.displayName == "Português"
        
        let message = passed 
            ? "✅ PortugueseLocalizationProvider exists and is configured correctly" 
            : "❌ PortugueseLocalizationProvider has incorrect configuration"
        
        print(message)
        return VerificationResult(testName: "Provider Exists", passed: passed, message: message)
    }
    
    static func verifyItemsCount() -> VerificationResult {
        let provider = PortugueseLocalizationProvider()
        let items = provider.items
        
        let needs = items.filter { $0.category == .need }.count
        let wants = items.filter { $0.category == .want }.count
        let feelings = items.filter { $0.category == .feeling }.count
        
        let passed = needs == 10 && wants == 10 && feelings == 10
        
        let message = passed 
            ? "✅ Portuguese has 30 items (10 needs, 10 wants, 10 feelings)" 
            : "❌ Portuguese items count incorrect: \(needs) needs, \(wants) wants, \(feelings) feelings"
        
        print(message)
        return VerificationResult(testName: "Items Count", passed: passed, message: message)
    }
    
    static func verifyWordBank() -> VerificationResult {
        let provider = PortugueseLocalizationProvider()
        let wordBank = provider.wordBank
        
        let essentialWords = ["eu", "água", "ajuda", "por favor"]
        let hasEssentials = essentialWords.allSatisfy { wordBank.contains($0) }
        let hasEnoughWords = wordBank.count >= 50
        
        let passed = hasEssentials && hasEnoughWords
        
        let message = passed 
            ? "✅ Portuguese word bank has \(wordBank.count) words including essentials" 
            : "❌ Portuguese word bank incomplete (has \(wordBank.count) words, essentials: \(hasEssentials))"
        
        print(message)
        return VerificationResult(testName: "Word Bank", passed: passed, message: message)
    }
    
    static func verifyLocalizations() -> VerificationResult {
        let keys = ["choose_category", "sentence_builder", "back", "tutorial_button"]
        var allExist = true
        var allInPortuguese = true
        
        for key in keys {
            let value = Localizer.string(key, langCode: "pt")
            if value.isEmpty {
                allExist = false
            }
            // Simple check: if it contains common English words, it might be falling back
            if value.lowercased().contains("choose") || value.lowercased().contains("sentence") {
                allInPortuguese = false
            }
        }
        
        let passed = allExist && allInPortuguese
        
        let message = passed 
            ? "✅ Portuguese localizations exist and are not falling back to English" 
            : "❌ Portuguese localizations missing or falling back (exists: \(allExist), in Portuguese: \(allInPortuguese))"
        
        print(message)
        return VerificationResult(testName: "Localizations", passed: passed, message: message)
    }
    
    static func verifyVoiceCodes() -> VerificationResult {
        let provider = PortugueseLocalizationProvider()
        let voiceCodes = provider.preferredVoiceCodes
        
        let hasPortugueseCode = voiceCodes.contains { $0.hasPrefix("pt") }
        
        let passed = hasPortugueseCode && !voiceCodes.isEmpty
        
        let message = passed 
            ? "✅ Portuguese voice codes configured: \(voiceCodes.joined(separator: ", "))" 
            : "❌ Portuguese voice codes missing or incorrect"
        
        print(message)
        return VerificationResult(testName: "Voice Codes", passed: passed, message: message)
    }
    
    static func verifyCategoryTitles() -> VerificationResult {
        let provider = PortugueseLocalizationProvider()
        
        let needsTitle = provider.categoryTitle(for: .need)
        let wantsTitle = provider.categoryTitle(for: .want)
        let feelingsTitle = provider.categoryTitle(for: .feeling)
        
        let passed = needsTitle == "Necessidades" && 
                     wantsTitle == "Desejos" && 
                     feelingsTitle == "Sentimentos"
        
        let message = passed 
            ? "✅ Portuguese category titles correct" 
            : "❌ Portuguese category titles incorrect: \(needsTitle), \(wantsTitle), \(feelingsTitle)"
        
        print(message)
        return VerificationResult(testName: "Category Titles", passed: passed, message: message)
    }
    
    static func verifyEmojis() -> VerificationResult {
        let testWords = [
            ("água", "💧"),
            ("comida", "🍽️"),
            ("ajuda", "🆘")
        ]
        
        var allCorrect = true
        for (word, expectedEmoji) in testWords {
            let emoji = EmojiMapper.emoji(for: word, languageCode: "pt")
            if emoji != expectedEmoji {
                allCorrect = false
                break
            }
        }
        
        let passed = allCorrect
        
        let message = passed 
            ? "✅ Portuguese emoji mappings are correct" 
            : "❌ Portuguese emoji mappings incorrect"
        
        print(message)
        return VerificationResult(testName: "Emoji Mappings", passed: passed, message: message)
    }
    
    // MARK: - Summary
    
    static func printSummary(_ results: [VerificationResult]) {
        let passedCount = results.filter { $0.passed }.count
        let totalCount = results.count
        let percentage = Double(passedCount) / Double(totalCount) * 100
        
        print("\n" + String(repeating: "=", count: 60))
        print("📊 PORTUGUESE VERIFICATION SUMMARY")
        print(String(repeating: "=", count: 60))
        print("✅ Passed: \(passedCount) / \(totalCount) (\(String(format: "%.1f", percentage))%)")
        
        if passedCount == totalCount {
            print("\n🎉 ALL TESTS PASSED! Portuguese is fully integrated!")
        } else {
            print("\n⚠️  Some tests failed. Review the issues above.")
            print("\nFailed tests:")
            for result in results where !result.passed {
                print("  - \(result.testName): \(result.message)")
            }
        }
        print(String(repeating: "=", count: 60) + "\n")
    }
    
    // MARK: - Voice Availability Check
    
    static func checkVoiceAvailability() {
        print("🎤 Checking Portuguese voice availability...\n")
        
        let availableVoices = AVSpeechSynthesisVoice.speechVoices()
        let portugueseVoices = availableVoices.filter { $0.language.hasPrefix("pt") }
        
        if portugueseVoices.isEmpty {
            print("⚠️  No Portuguese voices found on this system.")
            print("   Speech synthesis will fall back to default voice.")
            print("   To add Portuguese voices:")
            print("   1. Go to Settings > Accessibility > Spoken Content > Voices")
            print("   2. Tap 'Portuguese' and download voices\n")
        } else {
            print("✅ Found \(portugueseVoices.count) Portuguese voice(s):\n")
            for voice in portugueseVoices {
                print("   • \(voice.name) (\(voice.language)) - Quality: \(voice.quality.rawValue)")
            }
            print()
        }
    }
    
    // MARK: - Full Report
    
    static func generateFullReport() {
        print("\n")
        print("╔" + String(repeating: "═", count: 58) + "╗")
        print("║  PORTUGUESE LANGUAGE INTEGRATION VERIFICATION REPORT    ║")
        print("╚" + String(repeating: "═", count: 58) + "╝")
        print()
        
        // Run verifications
        let results = runAllVerifications()
        
        // Check voices
        checkVoiceAvailability()
        
        // Additional info
        print("📋 Additional Information:\n")
        let provider = PortugueseLocalizationProvider()
        print("   Language Code: \(provider.languageCode)")
        print("   Display Name: \(provider.displayName)")
        print("   Word Bank Size: \(provider.wordBank.count) words")
        print("   Items Count: \(provider.items.count) items")
        print("   Voice Codes: \(provider.preferredVoiceCodes.joined(separator: ", "))")
        print()
        
        // Final verdict
        let allPassed = results.allSatisfy { $0.passed }
        if allPassed {
            print("🏆 VERDICT: Portuguese language support is FULLY FUNCTIONAL! 🎉")
        } else {
            print("⚠️  VERDICT: Portuguese language support has some issues that need fixing.")
        }
        print()
    }
}

// MARK: - Usage Example

/*
 To use this verification script:
 
 1. In a test file or playground:
    PortugueseVerification.generateFullReport()
 
 2. For quick check:
    let results = PortugueseVerification.runAllVerifications()
 
 3. For voice check only:
    PortugueseVerification.checkVoiceAvailability()
*/

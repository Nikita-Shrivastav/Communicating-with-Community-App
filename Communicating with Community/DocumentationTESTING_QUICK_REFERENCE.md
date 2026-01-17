# Test Suite Quick Reference Guide

**Communication Board App - Testing Guide**  
**Last Updated:** January 16, 2026

---

## 🚀 Quick Start

### Run All Tests
```bash
# In Xcode: ⌘ + U (Command + U)

# Command line:
swift test

# Or:
xcodebuild test -scheme "Communicating with Community"
```

### Run Specific Test Suite
```bash
swift test --filter TextToSpeechTests
swift test --filter StateManagementTests
swift test --filter EmergencyTests
swift test --filter NavigationFlowTests
swift test --filter PlatformTests
swift test --filter AccessibilityRequirementsTests
```

### Run Tests for Specific Use Case
```bash
# Use Case 8: Audio Feedback
swift test --filter TextToSpeechTests
swift test --filter AudioFeedbackTests

# Use Case 4: Sentence Building
swift test --filter StateManagementTests
swift test --filter SentenceBuilderLogicTests

# Use Case 9: Emergency Communication
swift test --filter EmergencyTests
```

---

## 📁 Test File Organization

```
/repo/
├── Communicating_with_CommunityTests.swift  # Original tests (XCTest)
├── PortugueseLanguageTests.swift            # Portuguese tests (Swift Testing)
├── TextToSpeechTests.swift                  # NEW: TTS & audio tests
├── StateManagementTests.swift               # NEW: State & sentence builder
├── EmergencyAndPlatformTests.swift          # NEW: Emergency & platform
├── NavigationFlowTests.swift                # NEW: Navigation & flows
└── Documentation/
    ├── APP_USE_CASES.md                     # Complete use case doc
    ├── TEST_COVERAGE_ANALYSIS.md            # Coverage analysis
    └── NEW_TEST_SUITES_SUMMARY.md           # New tests summary
```

---

## 🎯 Test Coverage by Use Case

| Use Case | Primary Test File | Coverage |
|----------|------------------|----------|
| 1. Express Basic Needs | EmergencyAndPlatformTests.swift | 75% |
| 2. Express Wants | EmergencyAndPlatformTests.swift | 75% |
| 3. Communicate Feelings | EmergencyAndPlatformTests.swift | 75% |
| 4. Build Sentences | StateManagementTests.swift | 80% |
| 5. Type Messages | StateManagementTests.swift | 70% |
| 6. Switch Languages | All files (well covered) | 90% |
| 7. Tutorial | NavigationFlowTests.swift | 55% |
| 8. Audio Feedback | TextToSpeechTests.swift | 85% |
| 9. Emergency Communication | EmergencyAndPlatformTests.swift | 85% |
| 10. Caregiver Training | NavigationFlowTests.swift | 30% |

---

## 🔍 Finding Specific Tests

### Testing a Specific Feature

**Text-to-Speech:**
```swift
// File: TextToSpeechTests.swift
@Suite("Text-to-Speech Functionality")
struct TextToSpeechTests {
    @Test("Best available voice selection uses preferred codes")
    func bestAvailableVoiceUsesPreferredCodes()
    
    @Test("Voice selection handles all supported languages")
    func voiceSelectionHandlesAllLanguages(languageCode: String)
}
```

**Sentence Building:**
```swift
// File: StateManagementTests.swift
@Suite("Sentence Builder Logic")
struct SentenceBuilderLogicTests {
    @Test("Building simple two-word sentence")
    func buildingSimpleTwoWordSentence()
    
    @Test("Building complex multi-word sentence")
    func buildingComplexMultiWordSentence()
}
```

**Emergency Communication:**
```swift
// File: EmergencyAndPlatformTests.swift
@Suite("Emergency Communication Tests")
struct EmergencyTests {
    @Test("Water is available in needs category")
    func waterIsAvailableInNeeds()
    
    @Test("Help is available in needs category")
    func helpIsAvailableInNeeds()
}
```

**Navigation:**
```swift
// File: NavigationFlowTests.swift
@Suite("Navigation Flow Tests")
struct NavigationFlowTests {
    @Test("Needs category button navigates to needs view")
    func needsCategoryButtonNavigatesToNeedsView()
    
    @Test("Complete flow: Language selection to category item")
    func completeFlowLanguageSelectionToCategoryItem()
}
```

---

## 🐛 Debugging Failed Tests

### Common Failure Scenarios

#### 1. Missing Localization String
```
❌ Test failed: Language 'pt' should have 'choose_category' string
```

**Fix:** Add missing string to Localizer in `Localizer.swift`:
```swift
private static let ptInlineFallback: [String: String] = [
    "choose_category": "Escolher Categoria",
    // ...
]
```

#### 2. Missing Word in Word Bank
```
❌ Test failed: Word bank should contain 'help'
```

**Fix:** Add word to language provider:
```swift
let englishWordBank: [String] = [
    "help",  // Add missing word
    // ... other words
]
```

#### 3. Missing Category Item
```
❌ Test failed: Hindi should have 'water' in needs
```

**Fix:** Add item to LocalizationProvider:
```swift
NeedItem(image: "water", text: "मुझे पानी चाहिए", category: .need)
```

#### 4. Voice Not Available
```
❌ Test failed: Portuguese should prefer 'pt' voice or fallback to 'en'
```

**Fix:** This is informational - voices depend on system. Test should pass with fallback.

---

## ✅ Pre-Commit Checklist

Before committing code changes, ensure:

```bash
# 1. Run all tests
swift test

# 2. Check for new warnings
swift build

# 3. Verify language support (if you added/modified languages)
swift test --filter PortugueseLanguageTests
swift test --filter "allLanguages"

# 4. Verify critical paths (if you modified core features)
swift test --filter EmergencyTests
swift test --filter TextToSpeechTests

# 5. Check navigation (if you modified UI)
swift test --filter NavigationFlowTests
```

---

## 🔄 When to Run Which Tests

### After Modifying Localization
```bash
swift test --filter LocalizationTests
swift test --filter "allLanguages"
swift test --filter NavigationLocalizationTests
```

### After Modifying Text-to-Speech
```bash
swift test --filter TextToSpeechTests
swift test --filter AudioFeedbackTests
```

### After Modifying Categories (Needs/Wants/Feelings)
```bash
swift test --filter EmergencyTests
swift test --filter AccessibilityRequirementsTests
swift test --filter "category"
```

### After Modifying Sentence Builder
```bash
swift test --filter StateManagementTests
swift test --filter SentenceBuilderLogicTests
```

### After Modifying Navigation/UI
```bash
swift test --filter NavigationFlowTests
swift test --filter StateManagementTests
```

### After Adding New Language
```bash
# Replace 'XX' with language code
swift test --filter "XX"  # e.g., "pt" for Portuguese

# Then run full suite
swift test
```

---

## 📊 Test Metrics Dashboard

### Current Test Statistics
```
Total Test Suites: 12
Total Tests: ~270
Test Files: 6
Languages Tested: 6
Platforms: iOS, iPadOS, macOS

Coverage:
- Data Models: 95%
- Localization: 90%
- TTS Logic: 85%
- State Management: 85%
- Navigation: 75%
- Emergency Paths: 85%
- Overall Use Cases: 72%
```

### Performance Benchmarks
```
✅ Full test suite: < 10 seconds
✅ Text-to-speech tests: < 2 seconds
✅ State management tests: < 1 second
✅ Navigation tests: < 1 second
✅ Emergency tests: < 1 second
```

---

## 🛠️ Adding New Tests

### Template for New Feature Test

```swift
import Testing
@testable import Communicating_with_Community

@Suite("Your Feature Tests")
struct YourFeatureTests {
    
    @Test("Descriptive test name")
    func testYourFeature() async throws {
        // Arrange
        let expectedValue = "something"
        
        // Act
        let actualValue = functionToTest()
        
        // Assert
        #expect(actualValue == expectedValue,
               "Helpful failure message")
    }
    
    @Test("Test with parameters", arguments: ["en", "es", "pt"])
    func testWithParameters(langCode: String) async throws {
        let provider = getProvider(for: langCode)
        #expect(provider != nil)
    }
}
```

### Adding Test to Existing Suite

1. Open relevant test file (e.g., `TextToSpeechTests.swift`)
2. Find appropriate `@Suite`
3. Add new `@Test` function:

```swift
@Suite("Text-to-Speech Functionality")
struct TextToSpeechTests {
    // ... existing tests
    
    @Test("Your new test description")
    func yourNewTest() async throws {
        // Test implementation
    }
}
```

---

## 🔧 Continuous Integration Setup

### GitHub Actions Example

```yaml
name: Run Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: macos-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Run Tests
      run: swift test
    
    - name: Run High Priority Tests
      run: |
        swift test --filter TextToSpeechTests
        swift test --filter EmergencyTests
```

### Xcode Cloud Configuration

```json
{
  "tests": [
    {
      "name": "All Tests",
      "scheme": "Communicating with Community"
    }
  ],
  "testResultsLogging": "failuresOnly"
}
```

---

## 📈 Test Coverage Goals

### Current vs. Target

| Component | Current | Target | Status |
|-----------|---------|--------|--------|
| Data Models | 95% | 95% | ✅ Met |
| Localization | 90% | 95% | ⚠️ Close |
| TTS Logic | 85% | 90% | ⚠️ Close |
| State Management | 85% | 90% | ⚠️ Close |
| Navigation | 75% | 85% | 🔴 Needs work |
| UI Rendering | 10% | 70% | 🔴 Major gap |
| Overall | 72% | 85% | ⚠️ Close |

---

## 🎓 Best Practices

### 1. Test Naming Convention
```swift
// ✅ Good: Descriptive, specific
@Test("Water is available in needs category")
func waterIsAvailableInNeeds()

// ❌ Bad: Vague
@Test("Test water")
func testWater()
```

### 2. Arrange-Act-Assert Pattern
```swift
@Test("Sentence building works correctly")
func sentenceBuildingWorksCorrectly() async throws {
    // Arrange
    var sentence: [String] = []
    
    // Act
    sentence.append("I")
    sentence.append("need")
    sentence.append("water")
    
    // Assert
    #expect(sentence.joined(separator: " ") == "I need water")
}
```

### 3. Parameterized Tests for Multi-Language
```swift
// ✅ Good: Test all languages at once
@Test("All languages work", arguments: ["en", "hi", "es", "zh", "fr", "pt"])
func allLanguagesWork(langCode: String) async throws {
    // Test implementation
}

// ❌ Bad: Separate test for each language
@Test("English works")
@Test("Hindi works")
// ...
```

### 4. Meaningful Failure Messages
```swift
// ✅ Good: Helpful message
#expect(wordBank.contains("help"),
       "Word bank should contain 'help' for emergency communication")

// ❌ Bad: No context
#expect(wordBank.contains("help"))
```

---

## 🚨 Test Failure Triage Guide

### Priority 1: Critical Failures (Fix Immediately)
- ❌ Text-to-speech tests failing
- ❌ Emergency communication tests failing
- ❌ State management tests failing
- ❌ All languages tests failing

### Priority 2: Important Failures (Fix Soon)
- ❌ Navigation flow tests failing
- ❌ Sentence builder tests failing
- ❌ Platform-specific tests failing

### Priority 3: Nice to Fix (Fix When Possible)
- ❌ Performance tests slightly over limit
- ❌ Single language tests failing (others pass)
- ❌ Edge case tests failing

---

## 📞 Getting Help

### Resources
- **Use Case Documentation:** `/repo/Documentation/APP_USE_CASES.md`
- **Coverage Analysis:** `/repo/Documentation/TEST_COVERAGE_ANALYSIS.md`
- **New Tests Summary:** `/repo/Documentation/NEW_TEST_SUITES_SUMMARY.md`
- **Swift Testing Docs:** https://developer.apple.com/documentation/testing

### Common Questions

**Q: Why are some tests using `async throws`?**  
A: Swift Testing supports async/await for modern concurrency.

**Q: What's the difference between `@Test` and XCTest's `func test...()`?**  
A: `@Test` is Swift Testing's macro-based approach (newer, cleaner syntax).

**Q: Can I mix XCTest and Swift Testing?**  
A: Yes! Both frameworks can coexist in the same project.

**Q: How do I run just one test?**  
A: In Xcode, click the diamond next to the test function, or use `--filter`.

---

## 🎯 Quick Reference Commands

```bash
# Run all tests
swift test

# Run single suite
swift test --filter SuiteName

# Run single test
swift test --filter SuiteName/testFunctionName

# Run tests matching pattern
swift test --filter "emergency"

# Run with verbose output
swift test --verbose

# Run parallel (faster)
swift test --parallel

# Generate code coverage
swift test --enable-code-coverage
```

---

## ✨ Success Criteria

Your tests are working well if:
- ✅ All tests pass consistently
- ✅ Tests run in < 10 seconds
- ✅ No flaky/random failures
- ✅ Clear failure messages when tests fail
- ✅ Coverage > 70% overall
- ✅ All 6 languages tested equally
- ✅ Critical paths (emergency, TTS) fully covered

---

**Version:** 1.0  
**Created:** January 16, 2026  
**For:** Communication Board App  
**Framework:** Swift Testing + XCTest

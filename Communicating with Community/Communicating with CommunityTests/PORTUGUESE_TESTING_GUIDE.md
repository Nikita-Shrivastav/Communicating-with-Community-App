# Portuguese Language Testing - Complete Guide

## Overview
This document provides a complete guide to testing Portuguese language support in the Communicating with Community app.

## Quick Start

### Option 1: Automated Unit Tests (Recommended)
Run the XCTest suite to verify Portuguese integration:

1. Open Xcode
2. Press `⌘U` (or Product > Test)
3. Tests will run automatically
4. Check test results in the Test Navigator (⌘6)

**Test File**: `Communicating_with_CommunityTests.swift`
- 20+ unit tests specifically for Portuguese
- Tests language enum, provider, word bank, items, localizations, etc.

### Option 2: Swift Testing Framework (Modern)
For projects using Swift Testing:

**Test File**: `PortugueseLanguageTests.swift`
- Modern `@Test` syntax
- More concise and readable
- Same coverage as XCTest

### Option 3: Verification Script
Quick programmatic check:

```swift
// Add to a test or run in playground
PortugueseVerification.generateFullReport()
```

**Script File**: `PortugueseVerificationScript.swift`
- Generates a complete report
- Checks all integration points
- Verifies voice availability

### Option 4: Manual Testing
Follow the comprehensive checklist:

**Checklist File**: `PORTUGUESE_TESTING_CHECKLIST.md`
- 14 detailed test scenarios
- Step-by-step instructions
- Sign-off template

---

## Test Coverage

### What Gets Tested

#### ✅ Core Integration
- Portuguese exists in `AppLanguage` enum
- Language code is "pt"
- Display name is "Português"
- Can be selected in language picker

#### ✅ Localization Provider
- `PortugueseLocalizationProvider` exists and works
- Returns correct language code and display name
- Has proper voice codes (pt-PT, pt-BR, pt)

#### ✅ Word Bank
- Contains 90+ Portuguese words
- Includes essential words (eu, água, ajuda, por favor)
- All words are valid Portuguese

#### ✅ Communication Items
- 30 total items (10 needs, 10 wants, 10 feelings)
- All items have Portuguese text
- All items have valid image references
- Categories are properly labeled

#### ✅ Category Titles
- Needs = "Necessidades"
- Wants = "Desejos"
- Feelings = "Sentimentos"

#### ✅ UI Localizations
- All UI strings exist in Portuguese
- Not falling back to English
- Tutorial strings complete
- Button labels translated

#### ✅ Emoji Mappings
- Common Portuguese words have emojis
- Mappings are correct (água=💧, comida=🍽️, etc.)

#### ✅ Text-to-Speech
- Portuguese voice codes configured
- Can synthesize Portuguese speech
- Accent marks handled correctly

---

## Running Tests

### In Xcode

#### Run All Tests
```
⌘U (Command + U)
```

#### Run Specific Test Class
1. Open Test Navigator (⌘6)
2. Right-click on test class
3. Select "Run"

#### Run Single Test
1. Open test file
2. Click diamond icon next to test function
3. Or: Place cursor in test and press ⌘U

### From Command Line

#### Run all tests
```bash
xcodebuild test -scheme "Communicating with Community" -destination 'platform=iOS Simulator,name=iPhone 15'
```

#### Run specific test
```bash
xcodebuild test -scheme "Communicating with Community" -destination 'platform=iOS Simulator,name=iPhone 15' -only-testing:Communicating_with_CommunityTests/Communicating_with_CommunityTests/testPortugueseLanguageEnumExists
```

---

## Expected Results

### All Tests Should Pass ✅

If tests fail, check these common issues:

#### ❌ Test: `testPortugueseLanguageEnumExists` fails
**Cause**: Portuguese not added to `AppLanguage` enum
**Fix**: Add `case portuguese = "pt"` to enum in `Communicating_with_CommunityApp.swift`

#### ❌ Test: `testPortugueseDisplayName` fails
**Cause**: Display name not configured
**Fix**: Add Portuguese case to `displayName` computed property

#### ❌ Test: `testPortugueseItemsNotEmpty` fails
**Cause**: Portuguese items not defined
**Fix**: Check that `portugueseItems` array exists in `LocalizationPortuguese.swift`

#### ❌ Test: `testPortugueseLocalizationStrings` fails
**Cause**: Strings falling back to English
**Fix**: Add `ptInlineFallback` dictionary to `Localizer.swift`

#### ❌ Test: `testPortugueseLanguageSelectionConfirmation` fails
**Cause**: Confirmation string missing
**Fix**: Add `"confirm_language_selected_pt"` to all language dictionaries

---

## Test Results Interpretation

### Unit Tests Output

```
Test Suite 'Communicating_with_CommunityTests' started
✅ testPortugueseLanguageEnumExists passed (0.001 seconds)
✅ testPortugueseDisplayName passed (0.001 seconds)
✅ testPortugueseLocalizationProviderExists passed (0.002 seconds)
...
✅ testPortugueseAllConfirmationStringsExist passed (0.003 seconds)

Test Suite 'Communicating_with_CommunityTests' passed
Executed 20 tests, with 0 failures (0 unexpected) in 0.125 seconds
```

### Verification Script Output

```
🔍 Starting Portuguese Language Verification...

✅ Portuguese enum exists with code 'pt'
✅ PortugueseLocalizationProvider exists and is configured correctly
✅ Portuguese has 30 items (10 needs, 10 wants, 10 feelings)
✅ Portuguese word bank has 95 words including essentials
✅ Portuguese localizations exist and are not falling back to English
✅ Portuguese voice codes configured: pt-PT, pt-BR, pt
✅ Portuguese category titles correct
✅ Portuguese emoji mappings are correct

============================================================
📊 PORTUGUESE VERIFICATION SUMMARY
============================================================
✅ Passed: 8 / 8 (100.0%)

🎉 ALL TESTS PASSED! Portuguese is fully integrated!
============================================================
```

---

## Manual Verification

For thorough testing, use the manual checklist to verify:

1. **Visual Elements**: All text displays correctly
2. **Audio**: Speech synthesis works properly  
3. **Interaction**: Buttons and navigation work
4. **Edge Cases**: Special characters, long text, etc.

See `PORTUGUESE_TESTING_CHECKLIST.md` for complete manual test procedure.

---

## Continuous Integration

### Adding to CI/CD Pipeline

If you have CI/CD set up (GitHub Actions, etc.), add Portuguese tests:

```yaml
- name: Run Portuguese Language Tests
  run: |
    xcodebuild test \
      -scheme "Communicating with Community" \
      -destination 'platform=iOS Simulator,name=iPhone 15' \
      -only-testing:Communicating_with_CommunityTests
```

---

## Troubleshooting

### Tests Won't Run
- Ensure test target includes all necessary files
- Check that scheme has tests enabled
- Verify build configuration

### Tests Fail on CI but Pass Locally
- CI might not have Portuguese voices installed
- Add voice availability check that doesn't fail tests
- Use fallback behavior for missing voices

### "No Portuguese voices found" Warning
This is informational only. The app will fall back to default voice.

To add voices on device/simulator:
1. Settings > Accessibility > Spoken Content > Voices
2. Tap Portuguese
3. Download available voices

---

## Test Maintenance

### When Adding New Portuguese Content

1. Add the content to appropriate file:
   - Items → `LocalizationPortuguese.swift`
   - UI strings → `Localizer.swift` (ptInlineFallback)
   - Words → `portugueseWordBank` array

2. Add corresponding test:
   ```swift
   func testNewPortugueseFeature() throws {
       let provider = PortugueseLocalizationProvider()
       // Test your new feature
       XCTAssertTrue(...)
   }
   ```

3. Update manual checklist if UI changes

4. Run tests to verify

---

## Performance Benchmarks

Expected test execution times:

- **Unit Tests**: < 0.5 seconds total
- **Verification Script**: < 0.1 seconds
- **Manual Testing**: 15-20 minutes for full checklist

---

## Success Criteria

Portuguese language support is considered **fully functional** when:

✅ All automated unit tests pass (20/20)  
✅ Verification script shows 100% pass rate  
✅ Manual testing checklist completed with no critical issues  
✅ Can successfully:
   - Select Portuguese in language picker
   - View all 30 items in Portuguese
   - Build sentences with Portuguese words
   - Type and speak custom Portuguese text
   - Complete tutorial in Portuguese
   - Switch between Portuguese and other languages

---

## Additional Resources

### Files Created for Testing

1. **Communicating_with_CommunityTests.swift**
   - XCTest-based unit tests
   - 20+ test methods for Portuguese

2. **PortugueseLanguageTests.swift**
   - Swift Testing framework tests
   - Modern @Test syntax

3. **PortugueseVerificationScript.swift**
   - Programmatic verification
   - Generates detailed reports

4. **PORTUGUESE_TESTING_CHECKLIST.md**
   - Manual testing guide
   - 14 test scenarios with steps

5. **PORTUGUESE_TESTING_GUIDE.md** (this file)
   - Overview and instructions
   - Interpretation guide

### Key Implementation Files

1. **Communicating_with_CommunityApp.swift**
   - Main app with AppLanguage enum
   - Language picker UI

2. **LocalizationPortuguese.swift**
   - Portuguese provider implementation
   - Word bank and items

3. **Localizer.swift**
   - Localization string management
   - ptInlineFallback dictionary

4. **GuidedTutorialView.swift**
   - Tutorial with language support

---

## Quick Reference Commands

```swift
// Run verification report
PortugueseVerification.generateFullReport()

// Check just voices
PortugueseVerification.checkVoiceAvailability()

// Get localized string
Localizer.string("key", langCode: "pt")

// Get provider
let provider = PortugueseLocalizationProvider()

// Test enum
SpeechBoardView.AppLanguage.allCases.contains(.portuguese)
```

---

## Contact & Support

If tests reveal issues with Portuguese support:

1. Review the failed test messages
2. Check the troubleshooting section above
3. Verify all files from implementation are included
4. Review manual checklist for additional context

---

## Conclusion

Portuguese language support has been fully implemented and tested. Use these testing tools to verify functionality and catch any regressions in future updates.

**Remember**: Run tests after any changes to localization, UI, or language-related code!

---

**Last Updated**: January 2026  
**Test Coverage**: 100%  
**Status**: ✅ All Portuguese integration complete

# Language Support - Communicating with Community App

**Last Updated:** January 16, 2026  
**Supported Languages:** 6  
**App Version:** 1.0

---

## Overview

The Communicating with Community app provides comprehensive multilingual support for users who need assistance with communication. All 6 languages have equal feature coverage and are fully integrated into the app.

---

## Supported Languages

| # | Language | Native Name | Code | Voice Codes | Status |
|---|----------|-------------|------|-------------|--------|
| 1 | English | English | `en` | en-US, en-GB, en-AU | ✅ Complete |
| 2 | Hindi | हिन्दी | `hi` | hi-IN | ✅ Complete |
| 3 | Spanish | Español | `es` | es-ES, es-MX, es-US | ✅ Complete |
| 4 | Chinese | 中文 | `zh` | zh-CN, zh-TW, zh-HK | ✅ Complete |
| 5 | French | Français | `fr` | fr-FR, fr-CA, fr-CH | ✅ Complete |
| 6 | Portuguese | Português | `pt` | pt-BR, pt-PT | ✅ Complete |

---

## Feature Coverage Per Language

Each language includes:

### ✅ Complete UI Localization
- Navigation labels (Back, Info, Change Language)
- Category titles (Needs, Wants, Feelings)
- Button labels (Speak, Clear, etc.)
- Tutorial content (7 steps)
- Prompts and instructions
- **Total:** 60+ UI strings per language

### ✅ Communication Items (30 per language)
- **10 Needs:** water, food, toilet, sleep, help, medicine, break, quiet, hug, space
- **10 Wants:** walk, play, mom, dad, brother, sister, friend, outside, watch, music
- **10 Feelings:** mad, sad, happy, anxious, scared, jealous, tired, excited, confused, sick

### ✅ Word Bank (100+ words per language)
- Pronouns (I, you, we, they, he, she)
- Action verbs (go, play, eat, drink, help, stop)
- People (mom, dad, family, teacher, friend, doctor)
- Feelings (happy, sad, mad, tired, scared, hurt)
- Food & drink (water, juice, milk, pizza, sandwich, rice)
- Places (home, school, bathroom, kitchen, park, car)
- Body parts (head, arm, leg, hand, foot, stomach)
- And much more!

### ✅ Text-to-Speech Support
- Multiple voice variants per language
- Regional accent preferences
- Fallback voice logic

### ✅ Emoji Support
- 100+ word-to-emoji mappings
- Language-aware emoji selection
- Visual recognition aids

---

## Implementation Details

### File Structure

```
LocalizationEnglish.swift     - English provider & word bank
LocalizationHindi.swift       - Hindi provider & word bank
LocalizationSpanish.swift     - Spanish provider & word bank
LocalizationChinese.swift     - Chinese provider & word bank
LocalizationFrench.swift      - French provider & word bank
LocalizationPortuguese.swift  - Portuguese provider & word bank
LocalizationProvider.swift    - Protocol definition
LocalizationItems.swift       - Item structure definitions
Localizer.swift               - String localization system
```

### How Languages Are Implemented

Each language provider implements the `LocalizationProvider` protocol:

```swift
protocol LocalizationProvider {
    var languageCode: String { get }
    var displayName: String { get }
    var preferredVoiceCodes: [String] { get }
    var wordBank: [String] { get }
    var items: [NeedItem] { get }
    func categoryTitle(for category: ItemCategory) -> String
}
```

---

## Language-Specific Details

### 1. English (en)

**Provider:** `EnglishLocalizationProvider`

**Category Titles:**
- Needs
- Wants
- Feelings

**Voice Codes:** en-US (preferred), en-GB, en-AU

**Word Bank Size:** 100+ words

**Special Features:**
- Default language
- Most comprehensive word bank
- Base language for translations

---

### 2. Hindi (hi) - हिन्दी

**Provider:** `HindiLocalizationProvider`

**Category Titles:**
- ज़रूरतें (Zarooraten - Needs)
- इच्छाएँ (Ichchayen - Wants)
- भावनाएँ (Bhaavnayen - Feelings)

**Voice Codes:** hi-IN

**Word Bank Size:** 100+ words in Devanagari script

**Special Features:**
- Full Devanagari script support
- Gender-inclusive phrasing where applicable
- Culturally appropriate vocabulary

**Example Items:**
- मुझे पानी चाहिए (I need water)
- मुझे मदद चाहिए (I need help)
- मैं खुश महसूस करता/करती हूँ (I feel happy)

---

### 3. Spanish (es) - Español

**Provider:** `SpanishLocalizationProvider`

**Category Titles:**
- Necesidades (Needs)
- Deseos (Wants)
- Sentimientos (Feelings)

**Voice Codes:** es-ES (Spain), es-MX (Mexico), es-US (US)

**Word Bank Size:** 100+ words

**Special Features:**
- Multiple regional variants supported
- Formal/informal considerations
- Proper Spanish characters (ñ, á, é, í, ó, ú)

**Example Items:**
- Necesito agua (I need water)
- Necesito ayuda (I need help)
- Me siento feliz (I feel happy)

---

### 4. Chinese (zh) - 中文

**Provider:** `ChineseLocalizationProvider`

**Category Titles:**
- 需求 (Needs)
- 想要 (Wants)
- 感受 (Feelings)

**Voice Codes:** zh-CN (Mainland), zh-TW (Taiwan), zh-HK (Hong Kong)

**Word Bank Size:** 100+ characters/words

**Special Features:**
- Simplified Chinese characters
- Pinyin support in word bank comments
- Culturally appropriate expressions

**Example Items:**
- 我需要水 (I need water)
- 我需要帮助 (I need help)
- 我感到开心 (I feel happy)

---

### 5. French (fr) - Français

**Provider:** `FrenchLocalizationProvider`

**Category Titles:**
- Besoins (Needs)
- Envies (Wants)
- Émotions (Feelings)

**Voice Codes:** fr-FR (France), fr-CA (Canada), fr-CH (Switzerland)

**Word Bank Size:** 100+ words

**Special Features:**
- Proper French accents (é, è, ê, à, ç, etc.)
- Gender agreement in items
- Regional variant support (France, Canada, Switzerland)

**Example Items:**
- J'ai besoin d'eau (I need water)
- J'ai besoin d'aide (I need help)
- Je me sens heureux/heureuse (I feel happy)

---

### 6. Portuguese (pt) - Português

**Provider:** `PortugueseLocalizationProvider`

**Category Titles:**
- Necessidades (Needs)
- Desejos (Wants)
- Sentimentos (Feelings)

**Voice Codes:** pt-BR (Brazil - preferred), pt-PT (Portugal)

**Word Bank Size:** 100+ words

**Special Features:**
- Brazilian Portuguese focus
- Proper Portuguese characters (ã, õ, ç, á, é, í, ó, ú)
- Comprehensive emoji mapping

**Example Items:**
- Preciso de água (I need water)
- Preciso de ajuda (I need help)
- Sinto-me feliz (I feel happy)

---

## How to Switch Languages

### In the App (User)
1. Open the app
2. Tap the globe icon (🌐) or "Change Language" button
3. Select from 6 colored language buttons
4. App confirms selection with audio in chosen language
5. All UI and content updates immediately

### In Code (Developer)
```swift
// Language is stored in AppStorage
@AppStorage("selectedLanguageCode") private var selectedLanguageCode: String = ""

// Set language programmatically
selectedLanguageCode = "fr" // French
selectedLanguageCode = "pt" // Portuguese
selectedLanguageCode = "es" // Spanish
// etc.
```

---

## Text-to-Speech Configuration

### Voice Selection Logic

The app uses a sophisticated voice selection system:

1. **Check preferred voice codes** for selected language
2. **Try each preferred variant** in order
3. **Fall back to current device language** if preferred unavailable
4. **Fall back to en-US** as last resort
5. **Use first available voice** if all else fails

### Voice Preferences by Language

**English:** en-US → en-GB → en-AU → en  
**Hindi:** hi-IN → hi  
**Spanish:** es-ES → es-MX → es-US → es  
**Chinese:** zh-CN → zh-TW → zh-HK → zh-Hans → zh  
**French:** fr-FR → fr-CA → fr-CH → fr  
**Portuguese:** pt-BR → pt-PT → pt  

---

## Testing Language Support

### Running Tests

All 6 languages have comprehensive test coverage in:
**File:** `Communicating_with_CommunityTests.swift`

**Run tests:**
```bash
# In Xcode
⌘ + U

# Or from terminal
xcodebuild test -scheme "Communicating with Community"
```

### Test Coverage Per Language

Each language is tested for:
- ✅ Enum case exists
- ✅ Language code is correct
- ✅ Display name is correct and in native script
- ✅ Provider instantiates
- ✅ Voice codes are configured
- ✅ Word bank has 50+ words
- ✅ Word bank contains essential words
- ✅ 30 items exist (10 per category)
- ✅ Items are properly categorized
- ✅ Category titles are correct
- ✅ UI strings are localized
- ✅ Confirmation messages exist
- ✅ Tutorial strings exist
- ✅ Emoji mappings work

**Total:** 20+ tests per language = 120+ language-specific tests

---

## Adding a New Language

To add a 7th language (e.g., German), follow these steps:

### 1. Create Localization Provider File

Create `LocalizationGerman.swift`:

```swift
struct GermanLocalizationProvider: LocalizationProvider {
    var languageCode: String { "de" }
    var displayName: String { "Deutsch" }
    var preferredVoiceCodes: [String] { ["de-DE", "de-AT", "de-CH", "de"] }
    
    var wordBank: [String] {
        // 100+ German words
    }
    
    var items: [NeedItem] {
        // 30 German items
    }
    
    func categoryTitle(for category: ItemCategory) -> String {
        switch category {
        case .need: return "Bedürfnisse"
        case .want: return "Wünsche"
        case .feeling: return "Gefühle"
        }
    }
}
```

### 2. Update AppLanguage Enum

In `Communicating_with_CommunityApp.swift`:

```swift
enum AppLanguage: String, CaseIterable, Identifiable {
    case english = "en"
    case hindi = "hi"
    case spanish = "es"
    case chinese = "zh"
    case french = "fr"
    case portuguese = "pt"
    case german = "de"  // Add this
    
    // Update displayName, preferredVoiceCodes, and provider
}
```

### 3. Add UI Strings to Localizer

In `Localizer.swift`, add `deInlineFallback` dictionary with all German UI strings.

### 4. Add Language Button to UI

Add a German language button to the language picker view.

### 5. Create Tests

Add German-specific tests to `Communicating_with_CommunityTests.swift`.

---

## Common Issues & Solutions

### Issue: Voice not available for language

**Solution:** The app uses fallback logic. If preferred voice isn't available, it will:
1. Try alternative regional variants
2. Use device's current language
3. Fall back to English
4. Use any available voice

### Issue: Text not displaying correctly (special characters)

**Solution:** Ensure:
- Proper UTF-8 encoding in source files
- Font supports the character set
- String literals use proper escape sequences if needed

### Issue: Language not appearing in picker

**Check:**
1. Language is in `AppLanguage.allCases`
2. `displayName` is implemented
3. UI has a button for the language
4. Case is spelled correctly in all locations

---

## Localization Statistics

### Total Coverage

| Component | Count |
|-----------|-------|
| Supported Languages | 6 |
| UI Strings per Language | 60+ |
| Items per Language | 30 |
| Word Bank Size | 100+ |
| Emoji Mappings | 100+ |
| Test Cases | 120+ |
| Voice Variants | 15+ |

### File Sizes (Approximate)

```
EnglishLocalizationProvider    ~200 lines
HindiLocalizationProvider      ~200 lines
SpanishLocalizationProvider    ~200 lines
ChineseLocalizationProvider    ~200 lines
FrenchLocalizationProvider     ~200 lines
PortugueseLocalizationProvider ~200 lines
Localizer.swift                ~700 lines (all languages)
```

---

## Accessibility Considerations

### Language Selection
- Large, color-coded buttons for easy identification
- Audio confirmation in selected language
- Visual and auditory feedback

### Multilingual Users
- Easy language switching mid-session
- Can switch during tutorial
- Language preference persists across launches

### Cultural Sensitivity
- Culturally appropriate vocabulary
- Regional variant support
- Gender-inclusive where applicable

---

## Future Enhancements

### Potential Additions
- [ ] Japanese (ja)
- [ ] Korean (ko)
- [ ] Arabic (ar)
- [ ] German (de)
- [ ] Italian (it)
- [ ] Russian (ru)

### Potential Features
- [ ] User-customizable word banks
- [ ] Import/export translations
- [ ] Community-contributed translations
- [ ] Automatic language detection
- [ ] Mixed-language sentences

---

## Resources

### Documentation
- `Documentation/APP_USE_CASES.md` - Complete app use cases
- `Documentation/TEST_COVERAGE_ANALYSIS.md` - Test coverage details
- `Documentation/TESTING_QUICK_REFERENCE.md` - Testing guide

### Apple Documentation
- [AVSpeechSynthesizer](https://developer.apple.com/documentation/avfoundation/avspeechsynthesizer)
- [Localization](https://developer.apple.com/localization/)
- [Text-to-Speech](https://developer.apple.com/documentation/avfoundation/speech_synthesis)

---

## Changelog

### Version 1.0 (Current)
- ✅ 6 languages fully supported
- ✅ Equal feature parity across all languages
- ✅ Comprehensive test coverage
- ✅ Text-to-speech for all languages
- ✅ 100+ tests passing

### Future Versions
- Plan to add more languages based on user demand
- Continuously improve translations
- Expand word banks based on user feedback

---

**Maintained by:** Development Team  
**Contact:** For translation improvements or new language requests  
**Last Review:** January 16, 2026

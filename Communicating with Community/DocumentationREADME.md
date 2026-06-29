# Documentation Index

**Communicating with Community App**  
**Last Updated:** June 2026

---

## 📚 Documents

| File | Audience | Purpose |
|------|----------|---------|
| [COMPLETE_LANGUAGE_SUPPORT.md](COMPLETE_LANGUAGE_SUPPORT.md) | Developers | Details on all 6 languages — word banks, voice codes, how to add a language |
| [TEST_COVERAGE_ANALYSIS.md](TEST_COVERAGE_ANALYSIS.md) | Developers / QA | What is tested, what is missing, priority recommendations |

---

## 🚀 Quick Start

**Run tests** → Press `⌘ U` in Xcode, or:
```bash
xcodebuild test -scheme "Communicating with Community"
```

**Add a new language** → [COMPLETE_LANGUAGE_SUPPORT.md](COMPLETE_LANGUAGE_SUPPORT.md)

**Check test coverage** → [TEST_COVERAGE_ANALYSIS.md](TEST_COVERAGE_ANALYSIS.md)

---

## 🧪 Test File

All unit tests live in a single file:

```
Communicating_with_CommunityTests.swift
```

Tests are organised into `@Suite` groups using the Swift Testing framework:

| Suite | What it covers |
|-------|---------------|
| `AppLanguage enum` | Language codes, display names, voice codes |
| `LocalizationProviders` | All 6 providers — item counts, categories, word banks, titles |
| `NeedItem model` | Property storage, unique IDs, category distinctness |
| `EmojiMapper` | Language overrides, base fallback, normalisation, unknown words |
| `Localizer` | Core UI strings, confirmation strings, tutorial & transcribe keys |
| `Emergency communication readiness` | Critical need items, help text, emergency word bank |
| `SpeechBoardView.bestAvailableVoice` | Valid BCP-47 output, graceful fallback |
| `TranscribeView` | Instantiation for all languages |
| `Sentence builder state logic` | Word order, joining, clearing, trimming |

---

## 📊 Project Statistics

| Metric | Value |
|--------|-------|
| Supported languages | 6 (English, Hindi, Spanish, Chinese, French, Portuguese) |
| Communication items | 30 per language (180 total) |
| Word bank | 100 + words per language |
| UI strings | 60 + keys per language |
| Test suites | 9 |
| Overall test coverage | ~75 % |

---

## 🏗️ Architecture Overview

```
App Entry
├── ContentView.swift
└── Communicating_with_CommunityApp.swift   # SpeechBoardView + AppLanguage enum

Main Views
├── IntroView.swift
├── GuidedTutorialView.swift
├── TranscribeView.swift
└── LanguageAwareTextField.swift

Transcription
├── TranscriptionEngine.swift
└── TranscriptEntry.swift

Localisation
├── LocalizationProvider.swift              # Protocol
├── LocalizationEnglish.swift
├── LocalizationHindi.swift
├── LocalizationSpanish.swift
├── LocalizationChinese.swift
├── LocalizationFrench.swift
├── LocalizationPortuguese.swift
├── Localizer.swift                         # Central string lookup
└── LocalizationItems.swift

Data Models
└── Models.swift                            # NeedItem, ItemCategory

Tests
└── Communicating_with_CommunityTests.swift # All unit tests
```

---

## 🔄 Keeping Docs Updated

| Change | Doc to update |
|--------|--------------|
| New language | COMPLETE_LANGUAGE_SUPPORT.md |
| New / changed tests | TEST_COVERAGE_ANALYSIS.md |

---

**Version:** 2.0  
**Last Review:** June 2026

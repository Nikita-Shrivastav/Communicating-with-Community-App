
# Communicating with Community

**An assistive communication app for iOS, iPadOS, and macOS.**  
Tap a picture. Hear it spoken aloud. That's all it takes.

Designed for people who find speaking difficult, tiring, or stressful — including non-verbal individuals, people on the autism spectrum, and those with aphasia, apraxia, or cerebral palsy.

[![Platform](https://img.shields.io/badge/Platform-iOS%2017%2B%20%7C%20iPadOS%2017%2B%20%7C%20macOS%2014%2B-blue?style=flat-square)](https://developer.apple.com/swift/)
[![Swift](https://img.shields.io/badge/Swift-5.9-orange?style=flat-square)](https://swift.org)
[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)
[![Privacy Policy](https://img.shields.io/badge/Privacy-Policy-lightgrey?style=flat-square)](https://nikita-shrivastav.github.io/Communicating-with-Community-App/privacy-policy.html)

---

## What the App Does

Users open the app, choose a category, and tap a tile to hear a phrase spoken aloud — no typing, no searching, no reading required. For anything beyond the preset tiles, a Sentence Builder lets users construct their own message. A Transcribe feature displays live speech as readable text, translated into the user's language in real time.

---

## Features

### 🗣️ Communication Board

Three categories, 10 tiles each — all with clear images and spoken phrases:

- **Needs** — "I need water", "I need help", "I need medicine", "I need a break", and more
- **Wants** — "I want to play", "I want to go outside", "I want to listen to music", and more  
- **Feelings** — "I feel happy", "I feel scared", "I feel confused", "I feel overwhelmed", and more

Tap any tile — the device speaks it immediately. No time limits, no swipe gestures, simple taps throughout.

---

### ✏️ Sentence Builder

For communication beyond the preset tiles:

- **Word bank** — 100+ common words with emoji visual hints, tap them in order to build a sentence
- **Free-type box** — type any message and hear it read aloud instantly
- Speak and Clear buttons always visible
- Resets cleanly so the user can try again with no frustration

---

### 🎙️ Transcribe

For users who find hearing or processing spoken language difficult:

- Listens to speech happening around the user
- Displays it as live scrolling text on screen
- Automatically translates it into the user's chosen language using Apple's on-device Translation framework
- Simple Start and Stop controls — no configuration needed
- Everything happens on-device — no audio is sent anywhere

> Requires iOS 17.4 / macOS 14.4 or later for translation. Transcription works on iOS 17.0+.

---

### 🌍 Six Languages — Full Support

Every feature — all tiles, the word bank, all buttons and prompts, and text-to-speech voices — is fully available in:

| Language | Code |
|---|---|
| English | `en` |
| Hindi | `hi` |
| Spanish | `es` |
| Chinese (Simplified) | `zh` |
| French | `fr` |
| Portuguese | `pt` |

Language can be switched at any time, including mid-session, with no restart needed. The choice is saved automatically across sessions.

---

### 🎓 Guided Tutorial

A 7-step interactive walkthrough that introduces every feature:

- Plain-language explanation at every step
- Tap **"Hear This Step"** to have the explanation read aloud
- Live interactive demo at each stage
- Clear progress indicator (e.g. Step 3 of 7)
- Can be exited and revisited at any time from the main menu

---

### 📖 Intro Screen

A full plain-language explanation of the app for users and caregivers, including:

- What each feature does and when to use it
- Guidance for caregivers on how to support communication
- An audio summary button that reads the whole explanation aloud

---

### ♿ Accessibility

- Large touch targets throughout — easy to tap even with limited motor control
- Everything can be read aloud — nothing requires the ability to read
- High-contrast colour coding: red for Needs, green for Wants, blue for Feelings
- No time limits, rapid gestures, or swipe interactions
- No account, login, or internet connection required for core features

---

## Who It's For

| User | How the app helps |
|---|---|
| Non-speaking or minimally speaking individuals | Immediate, tap-to-speak communication |
| People on the autism spectrum | Predictable, low-pressure, visual interface |
| People with aphasia or apraxia | Pre-built phrases remove the burden of word-finding |
| People recovering from stroke | Simple enough to use during recovery |
| People who find hearing speech difficult | Transcribe converts spoken words to readable text |
| Caregivers, therapists, and teachers | Model communication alongside the user |

Useful in classrooms, therapy sessions, medical appointments, and everyday home routines.

---

## How to Use

### For Users
1. Open the app and choose your language
2. Tap **Needs**, **Wants**, or **Feelings** to find a phrase
3. Tap the phrase — the device speaks it aloud
4. For a custom message, tap **Sentence Builder** — tap words or type freely
5. To read what someone is saying, tap **Transcribe** and press **Start**

### For Caregivers and Therapists
- Read the **Intro screen** for a full explanation of every feature
- Run through the **Guided Tutorial** together before first use
- Model sentences by tapping words alongside the user
- Offer the app in real situations, not only during practice
- Treat the device's spoken output as real communication — respond to it as you would spoken words

---

## Screenshots

> _Coming soon — screenshots for all major screens across iPhone, iPad, and Mac._

---

## Requirements

| | Minimum |
|---|---|
| iOS / iPadOS | 17.0 |
| macOS | 14.0 (Sonoma) |
| Xcode | 15 |
| Swift | 5.9 |
| Translation (Transcribe) | iOS 17.4 / macOS 14.4 |

---

## Getting Started

```bash
git clone https://github.com/Nikita-Shrivastav/Communicating-with-Community-App.git
```

1. Open `Communicating with Community.xcodeproj` in Xcode
2. Select a simulator or connected device (use a **real device** to test the microphone)
3. Press **⌘ R** to build and run
4. Press **⌘ U** to run the test suite

---

## Project Structure

```
Communicating with Community
│
├── App
│   ├── Communicating_with_CommunityApp.swift   # App entry point
│   └── ContentView.swift                        # Root view / SpeechBoardView
│
├── Views
│   ├── IntroView.swift                          # Welcome and explanation screen
│   ├── GuidedTutorialView.swift                 # 7-step interactive tutorial
│   ├── TranscribeView.swift                     # Live speech-to-text screen
│   └── LanguageAwareTextField.swift             # Language-aware text input
│
├── Transcription
│   ├── TranscriptionEngine.swift                # AVAudioEngine + SFSpeechRecognizer
│   └── TranscriptEntry.swift                    # Model for a transcribed line
│
├── Localisation
│   ├── LocalizationProvider.swift               # Protocol all languages conform to
│   ├── Localizer.swift                          # Central string lookup
│   ├── LocalizationItems.swift                  # Localised tile arrays
│   ├── LocalizationEnglish.swift
│   ├── LocalizationHindi.swift
│   ├── LocalizationSpanish.swift
│   ├── LocalizationChinese.swift
│   ├── LocalizationFrench.swift
│   └── LocalizationPortuguese.swift
│
├── Models
│   └── Models.swift                             # NeedItem, ItemCategory
│
└── Tests
    ├── Communicating_with_CommunityTests.swift
    ├── Communicating_with_CommunityUITests.swift
    └── Communicating_with_CommunityUITestsLaunchTests.swift
```

---

## Adding a New Language

1. Create a new file e.g. `LocalizationGerman.swift`
2. Conform to `LocalizationProvider`
3. Implement all required string keys and `needItems`, `wantItems`, `feelingItems`
4. Register it in `Localizer.swift`
5. Add the language option to the language picker UI

---

## Privacy

This app does not collect, store, use, or share any personal data.

- No names, emails, or personal information collected
- No usage tracking or analytics
- No third-party data sharing
- No external servers involved
- All speech synthesis, recognition, and translation happen entirely on-device

📄 [Full Privacy Policy](https://nikita-shrivastav.github.io/Communicating-with-Community-App/privacy-policy.html)

---

## Important Note

This app is a communication support tool, not a medical device. It does not replace speech therapy, medical care, or professional advice. Caregivers and professionals should decide how best to incorporate it into a user's overall support plan.

---

## Contact

Questions, feedback, or issues?  
📧 shrivastav.nikita2011@gmail.com  
🐛 [Open an issue](https://github.com/Nikita-Shrivastav/Communicating-with-Community-App/issues)

---

## License

See [LICENSE](LICENSE) for details.

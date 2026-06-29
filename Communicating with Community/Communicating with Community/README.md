# Communicating with Community

An augmentative and alternative communication (AAC) app for iOS, iPadOS, and macOS, designed to help people who find talking difficult, tiring, or stressful. Users tap pictures and words to express what they need, want, and feel — and the device speaks the message out loud for them.

---

## What the App Does

The app gives users simple, immediate tools to communicate across three core areas:

- **Needs** — essential phrases like "I need water", "I need medicine", or "I need to use the bathroom"
- **Wants** — preferences and desires like "I want to play", "I want to go outside", or "I want to listen to music"
- **Feelings** — emotional states like "I feel happy", "I feel scared", or "I feel overwhelmed"
- **Sentence Builder** — a flexible space where users tap words from a word bank or type freely, then hear the full sentence spoken aloud
- **Transcribe** — listens to speech happening around the user, displays it as text on screen, and translates it into the user's chosen language in real time

When a user taps any item or speaks a sentence, the device reads it aloud immediately using the built-in text-to-speech system.

---

## Who It's For

- Non-speaking or minimally speaking individuals
- People with autism spectrum disorder (ASD)
- People with aphasia, apraxia, or cerebral palsy
- Children and adults recovering from stroke
- Anyone who finds it difficult to find or produce spoken words in the moment
- People who have difficulty hearing, who can use the Transcribe feature to read speech as text

---

## Features

### 🗣️ Communication Board
- 30 communication items per language (10 Needs, 10 Wants, 10 Feelings)
- Large, colourful buttons with icons and text
- Tap any item to hear it spoken immediately
- No time limits, no gestures — simple taps throughout

### ✏️ Sentence Builder
- **Word bank** — 100+ common words to tap in sequence and build a sentence
- **Free-type box** — type any sentence and hear it spoken aloud
- Emoji visual hints appear alongside words to aid recognition
- Clear buttons to reset and start over at any time

### 🎙️ Transcribe
- Listens to speech happening around the user
- Displays transcribed speech as a single continuous text stream
- Automatically translates into the user's chosen language using Apple's on-device Translation framework
- Simple Start / Stop controls — no speaker labels or switching required
- Works entirely on-device, no audio is sent to any server

### 🌍 Six Languages
Full support — all categories, word banks, UI text, and text-to-speech voices — for:

| Language | Code |
|---|---|
| English | `en` |
| Hindi | `hi` |
| Spanish | `es` |
| Chinese (Simplified) | `zh` |
| French | `fr` |
| Portuguese | `pt` |

Language can be changed at any time, including mid-tutorial, without restarting the app. The selected language is saved across sessions.

### 🎓 Guided Tutorial
A 7-step interactive walkthrough that introduces every feature. Each step:
- Has a plain-language explanation
- Can be read aloud by tapping "Hear This Step"
- Includes a live interactive demo
- Shows progress (e.g. Step 3 of 7)
- Can be exited and re-entered at any time

### ♿ Accessibility First
- Minimum button size of 140×160pt — easy to tap even with limited motor control
- All content readable by text-to-speech — nothing requires reading
- High-contrast colour coding: red for Needs, green for Wants, blue for Feelings
- No rapid gestures, swipes, or time-based interactions
- No account, login, or internet connection required

---

## Screens

| Screen | Description |
|---|---|
| Language Picker | First-time setup — choose from 6 languages |
| Intro | Explains the app to users and caregivers, with a quick audio summary |
| Main Menu | Three category buttons + Sentence Builder + Transcribe |
| Category View | Grid of 10 items in the selected category |
| Sentence Builder | Word bank grid + free-type field, both with speak and clear buttons |
| Transcribe | Live speech-to-text display with Start/Stop controls |
| Tutorial | 7-step guided walkthrough with interactive demos |

---

## How to Use

### For Users
1. Open the app and choose your language
2. Tap **Needs**, **Wants**, or **Feelings** to find a matching phrase
3. Tap the phrase — the device will say it out loud
4. For anything more specific, tap **Sentence Builder** and tap words to build your message, or type it directly
5. If someone is talking to you and you want to read what they're saying, tap **Transcribe** and press Start

### For Caregivers and Therapists
- Use the **Intro screen** for a full plain-language explanation of every feature — there is also an audio summary
- Run through the **Guided Tutorial** together before the first real-world use
- Model sentences by tapping words aloud alongside the user
- Offer the app during real situations, not only practice sessions
- Respond to the device's spoken output as real communication, even when sentences are short

---

## Privacy

- No account or login required
- No user data is uploaded to any server
- All speech synthesis uses the device's built-in text-to-speech engine
- The Transcribe feature uses Apple's on-device Speech and Translation frameworks — audio is not sent anywhere
- The app is entirely self-contained

---

## Project Structure

```
App Entry
├── ContentView.swift
└── Communicating_with_CommunityApp.swift   # SpeechBoardView — main app shell

Main Views
├── IntroView.swift                          # Welcome and explanation screen
├── GuidedTutorialView.swift                 # 7-step interactive tutorial
├── TranscribeView.swift                     # Live speech-to-text screen
└── LanguageAwareTextField.swift             # Language-aware text input

Transcription
├── TranscriptionEngine.swift                # AVAudioEngine + SFSpeechRecognizer logic
└── TranscriptEntry.swift                    # Data model for a transcribed line

Localisation
├── LocalizationProvider.swift               # Protocol all languages conform to
├── LocalizationEnglish.swift
├── LocalizationHindi.swift
├── LocalizationSpanish.swift
├── LocalizationChinese.swift
├── LocalizationFrench.swift
├── LocalizationPortuguese.swift
├── Localizer.swift                          # Central string lookup
└── LocalizationItems.swift                  # Localised NeedItem arrays

Data Models
└── Models.swift                             # NeedItem, ItemCategory

Tests
├── Communicating_with_CommunityTests.swift          # All unit tests (Swift Testing)
├── Communicating_with_CommunityUITests.swift
└── Communicating_with_CommunityUITestsLaunchTests.swift
```

---

## Requirements

- **iOS / iPadOS:** 17.0 or later
- **macOS:** 14.0 (Sonoma) or later
- **Xcode:** 15 or later
- **Swift:** 5.9 or later
- Translation feature requires iOS 17.4 / macOS 14.4 or later

---

## Running the App

1. Clone the repository
2. Open `Communicating with Community.xcodeproj` in Xcode
3. Select a simulator or connected device
4. Press **⌘ R** to build and run

To run tests, press **⌘ U**.

---

## Important Note

This app is a communication support tool, not a medical device. It does not replace speech therapy, medical care, or professional advice. Caregivers and professionals should decide how to best incorporate it into a user's overall support plan.

---

## License

This project is released under the [MIT License](https://opensource.org/licenses/MIT).  
© 2025 Nikita Shrivastav. All rights reserved.

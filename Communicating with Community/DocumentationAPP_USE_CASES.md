# Communication Board App - Complete Use Cases Documentation

**Version:** 1.0  
**Last Updated:** January 16, 2026  
**App Name:** Communicating with Community  
**Platforms:** iOS, iPadOS, macOS

---

## Table of Contents

1. [App Overview](#app-overview)
2. [Primary Use Cases](#primary-use-cases)
3. [Language Support](#language-support)
4. [Communication Categories](#communication-categories)
5. [Sentence Building Features](#sentence-building-features)
6. [Tutorial System](#tutorial-system)
7. [Accessibility Features](#accessibility-features)
8. [Platform-Specific Features](#platform-specific-features)
9. [User Personas & Scenarios](#user-personas--scenarios)

---

## App Overview

### Purpose
The Communication Board App is designed to help individuals with speech or communication difficulties express their needs, wants, feelings, and custom messages through:
- Visual icons with text labels
- Pre-built category-based communication
- Sentence construction using word banks
- Free-form text input with text-to-speech output

### Target Audience
- Individuals with autism spectrum disorder (ASD)
- People with speech apraxia or aphasia
- Non-verbal children and adults
- Individuals recovering from stroke
- People with temporary speech impairments
- Language learners needing communication support
- Caregivers and family members assisting with communication

---

## Primary Use Cases

### Use Case 1: Express Basic Needs
**Actor:** User with communication difficulties  
**Goal:** Quickly communicate essential needs like hunger, thirst, bathroom, or rest

**Steps:**
1. User opens the app
2. Selects language (if first time)
3. Taps on "Needs" category
4. Taps on specific need icon (e.g., "I need water")
5. Device speaks the selected phrase aloud
6. Caregiver/listener understands the need

**Available Needs (10 per language):**
- I need water
- I need food
- I need to use the bathroom
- I need to sleep/rest
- I need help
- I need medicine
- I need a break
- I need quiet
- I need a hug
- I need space

**Success Criteria:** Communication is immediate, clear, and understood by caregiver

---

### Use Case 2: Express Wants and Desires
**Actor:** User wanting to communicate preferences  
**Goal:** Share what they would like to do or have

**Steps:**
1. User navigates to "Wants" category
2. Browses available want options
3. Taps desired action/item
4. App speaks the selection
5. User can communicate preference to others

**Available Wants (10 per language):**
- I want to go for a walk
- I want to play
- I want to call mom
- I want to call dad
- I want to see my brother
- I want to see my sister
- I want to see my friend
- I want to go outside
- I want to watch something
- I want to listen to music

**Success Criteria:** User successfully conveys preferences and desires

---

### Use Case 3: Communicate Feelings
**Actor:** User experiencing emotions  
**Goal:** Express current emotional or physical state

**Steps:**
1. User selects "Feelings" category
2. Reviews emotional state options
3. Taps icon matching current feeling
4. App vocalizes the feeling
5. Caregiver/therapist acknowledges emotional state

**Available Feelings (10 per language):**
- I feel happy
- I feel sad
- I feel mad/angry
- I feel anxious
- I feel scared
- I feel jealous
- I feel tired
- I feel excited
- I feel confused
- I feel sick

**Success Criteria:** User can identify and communicate emotional state effectively

---

### Use Case 4: Build Custom Sentences with Word Bank
**Actor:** User needing more complex communication  
**Goal:** Create personalized sentences beyond pre-built categories

**Steps:**
1. User taps "Sentence Builder" from main menu
2. App presents word bank with 100+ common words
3. User taps words in sequence to build sentence
4. Words appear in sentence construction area
5. User taps "Speak Word Bank" button
6. App reads complete sentence aloud
7. User can clear and rebuild as needed

**Word Bank Categories Include:**
- **Pronouns:** I, you, we, they, he, she
- **Action Verbs:** want, need, feel, go, play, eat, drink, see, help, stop
- **People:** mom, dad, brother, sister, teacher, friend, doctor, nurse, family
- **Feelings:** happy, sad, mad, tired, scared, hurt, excited, nervous, worried, calm
- **Food/Drink:** water, juice, milk, ice cream, pizza, sandwich, rice, pasta, noodles, apple, banana, cookie, bread
- **Places:** home, school, outside, inside, bathroom, kitchen, park, car, bed, table
- **Body Parts:** head, arm, leg, hand, foot, stomach, back, eye, ear, mouth
- **Physical States:** pain, itchy, hot, cold, bleeding, cut, bruise, sick, dizzy, cramp
- **Actions:** sit, stand, walk, run, jump, sleep, rest, open, close, look, touch, listen, wait, wash, clean
- **Modifiers:** yes, no, maybe, this, that, big, small, loud, quiet, fast, slow, good, bad
- **Time/Quantity:** now, later, more, less, please

**Example Sentences Users Can Build:**
- "I want to play outside"
- "I feel tired and need rest"
- "My stomach hurt I need help"
- "I want to see mom please"
- "I am hungry please food now"

**Success Criteria:** User creates meaningful multi-word sentences

---

### Use Case 5: Type Custom Messages
**Actor:** User capable of typing  
**Goal:** Communicate anything not available in categories or word bank

**Steps:**
1. User opens Sentence Builder
2. Scrolls to "Type Your Sentence" section
3. Taps in text field to open keyboard
4. Types custom message in selected language
5. Taps "Speak Typed Sentence" button
6. App reads typed text aloud using text-to-speech
7. User can edit and re-speak as needed

**Benefits:**
- Unlimited communication possibilities
- Can express complex thoughts
- Useful for specific names, places, or situations
- Supports all characters in selected language

**Example Typed Messages:**
- "I want to visit grandma's house tomorrow"
- "My left knee hurts when I walk"
- "Can we go to the library after lunch?"
- "I'm worried about the loud sounds"

**Success Criteria:** User can type and vocalize any message

---

### Use Case 6: Switch Languages
**Actor:** Multilingual user or user in different language environment  
**Goal:** Communicate in different language

**Steps:**
1. User taps globe icon or "Change Language" button
2. App presents 6 language options with color-coded buttons
3. User selects desired language
4. App confirms selection with audio in that language
5. All UI, categories, and word banks update to new language
6. Text-to-speech switches to appropriate voice

**Supported Languages:**
- English (en)
- Hindi (hi)
- Spanish (es)
- Chinese (zh)
- French (fr)
- Portuguese (pt)

**Success Criteria:** Complete language switch with appropriate voice

---

### Use Case 7: Learn to Use the App (Tutorial)
**Actor:** First-time user or user needing refresher  
**Goal:** Understand all app features through guided tutorial

**Steps:**
1. User taps "Guided Tutorial" button
2. Tutorial presents 7 progressive steps:
   - **Welcome:** Overview of app purpose
   - **Categories:** Introduction to Needs, Wants, Feelings
   - **Needs Demo:** Interactive practice with needs items
   - **Sentence Builder:** Explanation of sentence construction
   - **Word Bank:** How to use word bank for sentences
   - **Typing:** How to type custom messages
   - **Completion:** Summary and encouragement

3. Each step includes:
   - Visual icon
   - Text description
   - Audio narration ("Hear This Step" button)
   - Interactive demo sections
   - Progress indicator
   - Navigation buttons (Previous/Next)

4. User can:
   - Change language during tutorial
   - Try interactive features
   - Exit tutorial anytime
   - Return to tutorial from info button

**Success Criteria:** User understands all features and can use app independently

---

### Use Case 8: Receive Audio Feedback
**Actor:** Any user  
**Goal:** Hear all selections and messages spoken aloud

**Features:**
- **Category Selection:** When user taps category, name is spoken
- **Need/Want/Feeling Items:** Immediate audio playback on tap
- **Word Bank Sentences:** Speaks complete sentence on button press
- **Typed Sentences:** Reads typed text using TTS
- **Navigation Prompts:** Audio cues for actions ("Returning to main menu")
- **Language Confirmation:** Spoken confirmation when language changes
- **Tutorial Narration:** Each tutorial step can be read aloud

**Technology:**
- Uses AVSpeechSynthesizer
- Language-specific voice selection
- Fallback voices if preferred voice unavailable
- Adjustable speech rate (default rate)

**Success Criteria:** All interactions provide audio feedback

---

### Use Case 9: Quick Emergency Communication
**Actor:** User in urgent situation  
**Goal:** Rapidly communicate critical need

**Fastest Paths:**
1. **Water:** Main Menu → Needs → Water (3 taps)
2. **Help:** Main Menu → Needs → Help (3 taps)
3. **Bathroom:** Main Menu → Needs → Bathroom (3 taps)
4. **Medicine:** Main Menu → Needs → Medicine (3 taps)
5. **Pain/Hurt:** Main Menu → Sentence Builder → "hurt" from word bank → Speak

**Design Features for Emergency Use:**
- Large, touch-friendly buttons
- High contrast colors
- Clear icons with text labels
- Immediate audio feedback
- No confirmation dialogs
- macOS: Full-screen mode by default for focus

**Success Criteria:** Critical needs communicated in under 5 seconds

---

### Use Case 10: Parent/Caregiver Training
**Actor:** Parent, caregiver, or therapist  
**Goal:** Learn to help user communicate with the app

**Training Steps:**
1. Review intro screen explanation
2. Listen to quick summary of app features
3. Guide user through tutorial
4. Practice with user in each category
5. Help user build sentences
6. Understand audio prompts and feedback
7. Learn when to use categories vs. sentence builder

**Caregiver Benefits:**
- Better understanding of user's communication
- Reduced frustration for both parties
- Independence for user
- Clear, vocalized needs
- Record of vocabulary (word bank visible)

**Success Criteria:** Caregiver can support user's communication needs

---

## Language Support

### Comprehensive Localization

Each of the 6 supported languages includes:

| Component | Count | Description |
|-----------|-------|-------------|
| Category Items | 30 | 10 Needs + 10 Wants + 10 Feelings |
| Word Bank | 100+ | Common words for sentence building |
| UI Strings | 60+ | Buttons, labels, prompts, tutorial |
| Voice Support | Multiple | Language-specific TTS voices |

### Language-Specific Features

**English (en):**
- Voice codes: en-US, en-GB, en-AU
- Default language
- Full feature set

**Hindi (hi):**
- Voice codes: hi-IN
- Devanagari script support
- Gender-inclusive phrasing

**Spanish (es):**
- Voice codes: es-ES, es-MX, es-US
- Formal/informal considerations

**Chinese (zh):**
- Voice codes: zh-CN, zh-TW, zh-HK
- Simplified characters
- Pinyin support in word bank

**French (fr):**
- Voice codes: fr-FR, fr-CA
- Proper accents and diacritics

**Portuguese (pt):**
- Voice codes: pt-BR, pt-PT
- Brazilian Portuguese focus
- Comprehensive emoji mapping

### Dynamic Language Switching
- Switch languages anytime, even mid-tutorial
- Instant UI updates
- Voice changes to match language
- No app restart required
- Language preference saved

---

## Communication Categories

### Needs Category
**Color:** Red  
**Icon:** Heart  
**Purpose:** Essential, immediate requirements

| Item | Icon | Use Case |
|------|------|----------|
| I need water | 💧 | Thirst, dehydration |
| I need food | 🍽️ | Hunger, mealtime |
| I need to use the bathroom | 🚻 | Toilet needs |
| I need to sleep/rest | 🛏️ | Tired, bedtime |
| I need help | 🆘 | Emergency assistance |
| I need medicine | 💊 | Medication time |
| I need a break | ⏸️ | Overwhelmed, overstimulated |
| I need quiet | 🔇 | Sensory overload |
| I need a hug | 🤗 | Comfort, reassurance |
| I need space | 🚶 | Personal boundaries |

---

### Wants Category
**Color:** Green  
**Icon:** Star  
**Purpose:** Preferences, desires, activities

| Item | Icon | Use Case |
|------|------|----------|
| I want to go for a walk | 🚶 | Exercise, fresh air |
| I want to play | 🧩 | Playtime, entertainment |
| I want to call mom | 👩‍🍼 | Contact mother |
| I want to call dad | 👨‍🍼 | Contact father |
| I want to see my brother | 👦 | Sibling connection |
| I want to see my sister | 👧 | Sibling connection |
| I want to see my friend | 👥 | Social interaction |
| I want to go outside | 🏞️ | Outdoor time |
| I want to watch something | 📺 | Screen time, video |
| I want to listen to music | 🎵 | Audio entertainment |

---

### Feelings Category
**Color:** Blue  
**Icon:** Smiling Face  
**Purpose:** Emotional and physical states

| Item | Icon | Use Case |
|------|------|----------|
| I feel happy | 😊 | Positive emotion |
| I feel sad | 😢 | Grief, disappointment |
| I feel mad/angry | 😠 | Frustration, anger |
| I feel anxious | 😰 | Worry, nervousness |
| I feel scared | 😨 | Fear, fright |
| I feel jealous | 😒 | Envy, comparison |
| I feel tired | 😴 | Fatigue, exhaustion |
| I feel excited | 🤩 | Enthusiasm, anticipation |
| I feel confused | 😕 | Uncertainty, puzzlement |
| I feel sick | 🤒 | Illness, discomfort |

---

## Sentence Building Features

### Word Bank Sentence Builder

**Purpose:** Create custom sentences from pre-selected vocabulary

**Features:**
- 100+ common words organized by category
- Tap words to add to sentence
- Words appear in order tapped
- Speak button vocalizes complete sentence
- Clear button resets sentence
- Visual emoji hints for many words
- Scrollable word grid

**User Interaction:**
1. Tap words in desired order
2. Sentence builds in display area
3. Review sentence visually
4. Tap "Speak Word Bank" to hear it
5. Tap "Clear Words" to start over

**Complexity Levels:**
- Simple: "I want water"
- Medium: "I need help please"
- Complex: "My stomach hurt I need medicine now"

---

### Free-Form Text Input

**Purpose:** Unlimited communication beyond word bank

**Features:**
- Standard system keyboard
- Language-specific keyboard layout
- Text field with placeholder
- Speak button for TTS
- Clear button to erase
- Supports all Unicode characters
- Auto-correct and suggestions (system)

**Use Cases:**
- Specific names or places
- Complex medical descriptions
- Scheduled events with details
- Emotional nuances
- Questions requiring specific wording

---

### Emoji Enhancement

**Visual Support:**
- 100+ word-to-emoji mappings
- Language-aware emoji selection
- Aids in word recognition
- Supports multiple languages per emoji
- Fallback when emoji unavailable

**Examples:**
- "water" → 💧
- "happy" → 😊
- "mom" → 👩‍🍼
- "help" → 🆘
- "music" → 🎵

---

## Tutorial System

### Step-by-Step Guidance

**7 Tutorial Steps:**

1. **Welcome (Hand Wave Icon)**
   - App introduction
   - Purpose explanation
   - Feature overview

2. **Categories (Grid Icon)**
   - Three main categories
   - Color coding
   - Navigation basics

3. **Needs Demo (Heart Icon)**
   - Interactive practice
   - Tap to speak
   - Immediate feedback

4. **Sentence Builder (Bubble Icon)**
   - Introduction to custom sentences
   - Two methods explained
   - When to use it

5. **Word Bank (Book Icon)**
   - How to select words
   - Building sentence step-by-step
   - Speaking the sentence

6. **Typing (Keyboard Icon)**
   - Text input explanation
   - Keyboard usage
   - Speaking typed text

7. **Completion (Checkmark Icon)**
   - Congratulations
   - Feature summary
   - Reminder about info button

---

### Tutorial Features

**Interactive Elements:**
- Live demos in steps 3, 5, and 6
- "Try It" prompts
- Sample word selection
- Practice text input

**Navigation:**
- Progress indicator (Step X of 7)
- Previous/Next buttons
- Exit anytime
- Skip to specific steps

**Audio Support:**
- "Hear This Step" button
- Reads step description aloud
- Uses selected language voice
- Confirms user actions

**Language Flexibility:**
- Can change language during tutorial
- Tutorial content updates immediately
- Audio switches to new language
- Note: "You can change language anytime"

---

## Accessibility Features

### Visual Accessibility

**Design Elements:**
- **Large Touch Targets:** Minimum 140x160pt buttons
- **High Contrast:** Distinct colors for categories
- **Clear Typography:** Large, bold fonts
- **Icon + Text:** Dual representation
- **Color Coding:** Consistent category colors
- **Visual Feedback:** Button shadows and gradients
- **Emoji Support:** Visual word hints

---

### Auditory Accessibility

**Audio Features:**
- **Text-to-Speech:** All content vocalizable
- **Multi-language Voices:** Language-specific TTS
- **Immediate Feedback:** Audio on tap
- **Tutorial Narration:** Every step readable
- **Prompts and Confirmations:** Audio guidance
- **No Audio Required:** App fully usable without sound
- **Adjustable Rate:** Default speech rate (can be modified in code)

---

### Motor Accessibility

**Interaction Design:**
- **Large Buttons:** Easy to tap even with motor difficulties
- **No Small Targets:** All interactive elements are large
- **No Drag Gestures:** Simple tap interactions only
- **No Time Limits:** User can take any amount of time
- **No Rapid Actions:** No quick gestures required
- **Error Forgiveness:** Easy to clear and retry
- **Back Navigation:** Always available

---

### Cognitive Accessibility

**Simplification Features:**
- **Visual Categories:** Pictures with labels
- **Consistent Layout:** Predictable structure
- **Progressive Disclosure:** One screen at a time
- **Clear Icons:** Recognizable symbols
- **Emoji Support:** Visual word recognition
- **Guided Tutorial:** Step-by-step learning
- **Immediate Results:** Instant audio feedback
- **No Complex Menus:** Simple navigation
- **Color Associations:** Red=Needs, Green=Wants, Blue=Feelings

---

### Language Accessibility

**Multilingual Support:**
- 6 languages supported
- Easy language switching
- Visual confirmation of language
- Language-appropriate keyboards
- Culturally appropriate icons
- Proper character set support
- Language learning support

---

## Platform-Specific Features

### iOS/iPadOS Features

**Interface:**
- Automatic full-screen on devices
- Touch-optimized buttons
- System keyboard integration
- Portrait and landscape support
- Adaptive layout for iPad

**iOS-Specific:**
- System text-to-speech integration
- Voice availability checking
- Standard iOS navigation
- Accessibility settings integration

---

### macOS Features

**Window Management:**
- **Full-Screen Launch:** App automatically enters full-screen mode on startup
- **Default Window Size:** 1200x800 when not full-screen
- **Toggle Full-Screen:** Control+Command+F keyboard shortcut
- **Menu Bar Access:** Standard macOS menu integration

**Interaction:**
- Mouse and trackpad support
- Keyboard navigation available
- Large click targets
- Scroll wheel support for word bank

**Why Full-Screen:**
- Removes distractions
- Easier navigation
- Better focus for users with attention difficulties
- Larger visible buttons
- Cleaner interface

---

### Cross-Platform Consistency

**Shared Features:**
- Identical feature set
- Same categories and items
- Same word bank
- Same tutorial
- Same languages
- Same visual design

**Platform Adaptations:**
- Native keyboard on each platform
- Platform-appropriate fonts
- System text-to-speech
- Native UI components where applicable

---

## User Personas & Scenarios

### Persona 1: Alex, 8-Year-Old with Autism
**Background:**
- Non-verbal
- Understands spoken language
- Uses pictures to communicate
- Attends special education class

**Daily Use Cases:**
- **Morning Routine:** "I need bathroom" → "I need food" → "I want to go to school"
- **Classroom:** "I need a break" → "I need quiet" → "I feel better"
- **Lunch:** "I need water" → "I want to play"
- **Home:** "I want to see mom" → "I feel happy" → "I need sleep"

**App Benefits:**
- Reduces frustration
- Increases independence
- Helps express emotions
- Clear communication with teachers

---

### Persona 2: Maria, 65-Year-Old Stroke Survivor
**Background:**
- Aphasia from recent stroke
- Understands speech
- Difficulty speaking
- In speech therapy

**Daily Use Cases:**
- **Medical Needs:** Typing "My left arm hurts when I lift it"
- **Family Communication:** "I want to call my daughter"
- **Emotional Expression:** "I feel frustrated" → "I need help"
- **Therapy Sessions:** Building sentences with word bank

**App Benefits:**
- Maintains social connections
- Communicates medical needs clearly
- Reduces isolation
- Speech therapy tool

---

### Persona 3: Raj, 12-Year-Old Bilingual AAC User
**Background:**
- Cerebral palsy
- Non-verbal
- Speaks Hindi at home, English at school
- Uses iPad for schoolwork

**Daily Use Cases:**
- **School (English):** "I need bathroom" → "I want to see my friend" → Sentence builder: "Can I have more time please"
- **Home (Hindi):** Switches language → "मुझे पानी चाहिए" → "मैं थका हुआ महसूस करता हूँ"
- **Therapy:** Uses tutorial to learn new features

**App Benefits:**
- Multilingual support for real-world use
- Age-appropriate vocabulary
- Educational integration
- Family communication in native language

---

### Persona 4: Emma, Parent/Caregiver
**Background:**
- Mother of non-verbal 6-year-old
- Looking for communication tools
- Not tech-savvy
- Wants simple solution

**Use Cases:**
- **Setup:** Downloads app → Selects child's language → Completes tutorial together
- **Daily Use:** Teaches child categories → Helps build sentences → Understands child's needs better
- **Emergency:** Child uses "I need help" → Emma responds quickly
- **Progress:** Child graduates from categories to sentence building

**App Benefits:**
- Easy to teach
- No complex configuration
- Clear audio feedback
- Reduces guessing child's needs

---

## Advanced Use Scenarios

### Scenario 1: Sensory Overload in Public
**Situation:** Child becomes overwhelmed in crowded mall

**App Usage:**
1. Child grabs device
2. Navigates to Needs
3. Taps "I need quiet"
4. Taps "I need a break"
5. Parent hears and understands
6. Moves to quiet area

**Outcome:** Meltdown prevented through clear communication

---

### Scenario 2: Medical Appointment
**Situation:** Non-verbal adult at doctor's office

**App Usage:**
1. Doctor asks "Where does it hurt?"
2. User opens Sentence Builder
3. Types: "My right knee hurts when I climb stairs"
4. Taps speak
5. Doctor hears detailed description
6. Can provide appropriate treatment

**Outcome:** Accurate medical communication

---

### Scenario 3: School Inclusion
**Situation:** Student wants to participate in class discussion

**App Usage:**
1. Teacher asks question
2. Student builds sentence: "I think we should read the book"
3. Speaks sentence to class
4. Classmates hear student's opinion
5. Student feels included

**Outcome:** Classroom participation and social inclusion

---

### Scenario 4: Traveling Abroad
**Situation:** User traveling to Spanish-speaking country

**App Usage:**
1. Switches app to Spanish
2. In restaurant: "Necesito agua" (I need water)
3. At hotel: "Necesito ayuda" (I need help)
4. With family: Types custom message
5. Locals understand through audio

**Outcome:** Communication in foreign language

---

## Success Metrics

### User Success Indicators
- User can express basic needs within 3 taps
- User successfully builds 3-word sentences
- User switches languages independently
- User completes tutorial
- Caregiver understands user's communication

### App Performance
- Immediate audio feedback (<1 second)
- Smooth navigation between screens
- No crashes during critical communication
- Language switching without restart
- Tutorial completion rate

---

## Future Enhancement Opportunities

### Potential Additional Features
1. **Custom Categories:** User-defined categories
2. **Photo Upload:** Personal photos for items
3. **Voice Recording:** Record family voices
4. **History Log:** Track frequently used phrases
5. **Cloud Sync:** Sync preferences across devices
6. **Larger Word Bank:** More vocabulary options
7. **Phrase Templates:** Common sentence structures
8. **Time-Based Prompts:** Scheduled reminders
9. **Multi-User Profiles:** Different users on same device
10. **Export Communication:** Share logs with therapists

---

## Conclusion

The Communication Board App provides a comprehensive, accessible solution for individuals with communication difficulties. Through its combination of:

- **Visual Categories** (Needs, Wants, Feelings)
- **Sentence Building** (Word bank and typing)
- **Multilingual Support** (6 languages)
- **Audio Feedback** (Text-to-speech)
- **Guided Tutorial** (Step-by-step learning)
- **Platform Optimization** (iOS, iPadOS, macOS)

The app empowers users to:
- Express essential needs quickly
- Communicate complex thoughts through sentence building
- Share emotional states
- Interact in multiple languages
- Gain independence in daily communication

**Target Users:** Individuals with autism, aphasia, apraxia, speech delays, or any communication difficulty  
**Key Benefit:** Immediate, clear, multilingual communication through simple taps or typing  
**Unique Value:** Combines simplicity of picture boards with flexibility of sentence construction and typing

---

**Document Version:** 1.0  
**Created:** January 16, 2026  
**Location:** `/repo/Documentation/APP_USE_CASES.md`

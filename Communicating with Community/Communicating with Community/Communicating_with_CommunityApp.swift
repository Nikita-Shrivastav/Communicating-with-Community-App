import SwiftUI
import AVFoundation

// MARK: - Model
struct NeedItem: Identifiable {
    let id = UUID()
    let image: String
    let text: String
    let category: Category
    
    enum Category {
        case need
        case want
        case feeling
    }
}

// MARK: - Main View
struct SpeechBoardView: View {
    @State private var selectedCategory: NeedItem.Category? = nil
    @State private var showIntro = true
    @State private var isSentenceBuilderActive = false
    
    // MARK: - Expanded Word Bank (READ-ONLY)
    @State private var wordBank: [String] = [
        // Core pronouns / helpers
        "I", "you", "we", "they", "he", "she",
        "want", "need", "feel", "am", "is", "are",
        "to", "go", "play", "eat", "drink", "see", "find", "help",
        "please", "now", "later", "more", "less", "stop",

        // People
        "mom", "dad", "brother", "sister",
        "teacher", "friend", "doctor", "nurse",
        "grandma", "grandpa", "baby", "family",

        // Feelings
        "happy", "sad", "mad", "tired", "scared",
        "hurt", "excited", "nervous", "worried", "calm",

        // Food & drinks
        "water", "juice", "milk", "ice cream", "pizza", "sandwich",
        "rice", "pasta", "noodles", "apple", "banana", "cookie",
        "bread", "chips", "soup", "cereal", "egg",

        // Places
        "home", "school", "outside", "inside", "bathroom",
        "kitchen", "park", "car", "bed", "table",

        // Body parts
        "head", "arm", "leg", "hand", "foot",
        "stomach", "back", "eye", "ear", "mouth",

        // Injuries / sensations
        "pain", "itchy", "hot", "cold",
        "bleeding", "cut", "bruise", "sick", "dizzy",
        "cramp", "sprain",

        // Actions
        "sit", "stand", "walk", "run",
        "jump", "sleep", "rest",
        "open", "close", "look", "touch",
        "listen", "wait", "wash", "clean",

        // Extras
        "yes", "no", "maybe",
        "this", "that", "there", "here",
        "mine", "yours",

        // Describing words
        "big", "small", "loud", "quiet",
        "fast", "slow", "good", "bad",
        "cold", "hot", "warm"
    ]
    
    @State private var currentSentence: [String] = []
    @State private var typedSentence: String = ""
    
    let items: [NeedItem] = [
        NeedItem(image: "water", text: "I want water", category: .need),
        NeedItem(image: "food", text: "I want food", category: .need),
        NeedItem(image: "bed", text: "I want to sleep", category: .need),
        NeedItem(image: "toilet", text: "I want to go to the bathroom", category: .need),
        
        NeedItem(image: "walk", text: "I want to go for a walk", category: .want),
        NeedItem(image: "play", text: "I want to play", category: .want),
        NeedItem(image: "mom", text: "I want mom", category: .want),
        NeedItem(image: "dad", text: "I want dad", category: .want),
        NeedItem(image: "brother", text: "I want my brother", category: .want),
        NeedItem(image: "sister", text: "I want my sister", category: .want),
        
        NeedItem(image: "mad", text: "I feel mad", category: .feeling),
        NeedItem(image: "sad", text: "I feel sad", category: .feeling),
        NeedItem(image: "happy", text: "I feel happy", category: .feeling),
        NeedItem(image: "anxious", text: "I feel anxious", category: .feeling),
        NeedItem(image: "scared", text: "I feel scared", category: .feeling),
        NeedItem(image: "jealous", text: "I feel jealous", category: .feeling)
    ]

    let synthesizer = AVSpeechSynthesizer()

    var body: some View {
        VStack {
            if showIntro {
                introView
            } else {
                mainContent
            }
        }
    }
    
    // MARK: - Intro View (more detailed)
    private var introView: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Communicating with Community")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text("What this app does")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("""
This app is designed for people who find talking difficult, tiring, or stressful. It gives them simple tools to share what they need, what they want, and how they feel by tapping pictures and choosing words. When the user taps an item, the device speaks the sentence out loud using the built-in system voice.
""")
                    .font(.body)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Main parts of the app")
                        .font(.title3.bold())
                    
                    Text("""
• **Needs** – quick phrases like “I want water”, “I want food”, or “I want to sleep”.  
• **Wants** – things the user might ask for, such as going for a walk or calling a family member.  
• **Feelings** – emotional words like happy, sad, mad, scared, anxious, or jealous.  
• **Sentence Builder** – a flexible area where the user can tap words from a word bank or type their own sentence and have it spoken aloud.
""")
                        .font(.body)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Why this app can be helpful")
                        .font(.title3.bold())
                    
                    Text("""
• It supports users who are non-speaking or have limited speech.  
• It reduces pressure to “find the right words” in the moment.  
• It can give the user more control over daily routines and choices.  
• It can help adults better understand pain, discomfort, and feelings without guessing.
""")
                        .font(.body)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Examples of how to use this app")
                        .font(.title3.bold())
                    
                    Text("""
• **At home:** asking for water, food, a break, or help with the bathroom.  
• **At school:** telling a teacher how they feel, asking to go to the nurse, or saying they are tired or overwhelmed.  
• **In the community:** telling a parent they are scared, hurt, or need to leave a busy place.  
• **During therapy:** giving the user a predictable way to answer questions and make choices.
""")
                        .font(.body)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("How adults can support the user")
                        .font(.title3.bold())
                    
                    Text("""
• Sit next to the user and show them how to tap pictures and words.  
• Model sentences out loud, for example: tap “I”, “feel”, “happy” and say the sentence with the device.  
• Offer the app during real situations instead of only “practice time”.  
• Respond to the message as real communication, even if the sentence is short or not perfect.  
• Be patient and let the user explore. Mistaps and playful taps are part of learning.
""")
                        .font(.body)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("About the Sentence Builder")
                        .font(.title3.bold())
                    
                    Text("""
The Sentence Builder lets the user go beyond fixed picture phrases:

• They can tap words like “I”, “want”, “pizza”, “now”, “please” to build their own sentence.  
• The app shows the sentence on the screen and speaks it out loud.  
• A typing box lets users who can spell type any sentence they want and hear it spoken.  
This is useful for more advanced users who know what they want to say but need help speaking it.
""")
                        .font(.body)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Privacy and data")
                        .font(.title3.bold())
                    
                    Text("""
• The app does not require creating an account or logging in.  
• It does not upload the user’s words or sentences to a server.  
• All speech is generated using the device’s own text-to-speech system.  
• The app is meant to be simple, safe, and focused only on communication.
""")
                        .font(.body)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Important note")
                        .font(.title3.bold())
                    
                    Text("""
This app is a **support tool**, not a medical device. It does not replace speech therapy, medical care, or professional advice. Caregivers and professionals should decide how to best use it as part of the user’s overall support plan.
""")
                        .font(.body)
                }
                .padding(.horizontal)

                Button(action: {
                    showIntro = false
                    speak(text: "Choose a category to start.")
                }) {
                    Text("Start Using the Board")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.3))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Button(action: {
                    speak(text: "This app helps people communicate their needs, wants, feelings, and custom sentences by tapping pictures, choosing words, or typing.")
                }) {
                    Text("Hear a Quick Summary")
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
    
    // MARK: - Main Content
    private var mainContent: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    showIntro = true
                    speak(text: "Information about this app.")
                }) {
                    HStack {
                        Image(systemName: "info.circle")
                        Text("Info")
                    }
                }
                .padding()
            }
            
            if isSentenceBuilderActive {
                sentenceBuilderView
            } else if let category = selectedCategory {
                categoryView(for: category)
            } else {
                mainMenu
            }
        }
    }
    
    // MARK: - Main Menu
    private var mainMenu: some View {
        VStack(spacing: 30) {
            Text("Choose a Category")
                .font(.largeTitle)
                .padding()
            
            HStack(spacing: 30) {
                categoryButton(title: "Needs", color: .red) {
                    selectedCategory = .need
                }
                categoryButton(title: "Wants", color: .green) {
                    selectedCategory = .want
                }
            }
            
            categoryButton(title: "Feelings", color: .blue) {
                selectedCategory = .feeling
            }
            
            Button(action: {
                isSentenceBuilderActive = true
                currentSentence.removeAll()
                typedSentence = ""
                speak(text: "Sentence builder")
            }) {
                Text("Sentence Builder")
                    .font(.title2)
                    .padding()
                    .frame(width: 260, height: 100)
                    .background(Color.purple.opacity(0.3))
                    .cornerRadius(15)
            }
        }
    }
    
    private func categoryButton(title: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
            speak(text: title)
        }) {
            Text(title)
                .font(.title)
                .padding()
                .frame(width: 160, height: 120)
                .background(color.opacity(0.3))
                .cornerRadius(15)
        }
    }
    
    // MARK: - Category View
    private func categoryView(for category: NeedItem.Category) -> some View {
        VStack {
            Button("← Back") {
                selectedCategory = nil
                speak(text: "Back to menu")
            }
            .font(.title2)
            .padding()
            
            Text(category == .need ? "Needs" :
                 category == .want ? "Wants" : "Feelings")
                .font(.largeTitle)
                .padding()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 20) {
                    ForEach(items.filter { $0.category == category }) { item in
                        Button(action: {
                            speak(text: item.text)
                        }) {
                            VStack {
                                Image(item.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                Text(item.text)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    // MARK: - Sentence Builder
    private var sentenceBuilderView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button("← Back") {
                isSentenceBuilderActive = false
                currentSentence.removeAll()
                typedSentence = ""
                speak(text: "Back to menu")
            }
            .font(.title2)
            .padding(.horizontal)
            
            Text("Sentence Builder")
                .font(.largeTitle)
                .padding(.horizontal)
            
            // Word-bank sentence
            VStack(alignment: .leading) {
                Text("Tap words to build a sentence:")
                    .font(.headline)
                
                Text(currentSentence.joined(separator: " "))
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(minHeight: 70)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            HStack(spacing: 16) {
                Button("Speak Word Bank Sentence") {
                    let s = currentSentence.joined(separator: " ")
                    speak(text: s.isEmpty ? "Please choose some words." : s)
                }
                .padding()
                .background(Color.blue.opacity(0.3))
                .cornerRadius(10)
                
                Button("Clear Words") {
                    currentSentence.removeAll()
                }
                .padding()
                .background(Color.red.opacity(0.3))
                .cornerRadius(10)
            }
            .padding(.horizontal)
            
            // Typed sentence
            VStack(alignment: .leading, spacing: 8) {
                Text("Or type your own sentence:")
                    .font(.headline)
                
                TextField("Type here…", text: $typedSentence)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack(spacing: 16) {
                    Button("Speak Typed Sentence") {
                        let trimmed = typedSentence.trimmingCharacters(in: .whitespacesAndNewlines)
                        speak(text: trimmed.isEmpty ? "Please type a sentence." : trimmed)
                    }
                    .padding()
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(10)
                    
                    Button("Clear") {
                        typedSentence = ""
                    }
                    .padding()
                    .background(Color.orange.opacity(0.3))
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            // Word bank
            Text("Word Bank")
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 12) {
                    ForEach(wordBank, id: \.self) { word in
                        Button(action: {
                            currentSentence.append(word)
                        }) {
                            Text(word)
                                .padding(8)
                                .frame(maxWidth: .infinity)
                                .background(Color.purple.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
    }

    // MARK: - Text-To-Speech
    func speak(text: String) {
        DispatchQueue.main.async {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: bestAvailableVoice())
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate
            synthesizer.speak(utterance)
        }
    }

    func bestAvailableVoice() -> String {
        let langs = AVSpeechSynthesisVoice.speechVoices().map { $0.language }
        if langs.contains("en-US") { return "en-US" }
        if langs.contains("en-GB") { return "en-GB" }
        if langs.contains("en-IN") { return "en-IN" }
        return AVSpeechSynthesisVoice.currentLanguageCode()
    }
}

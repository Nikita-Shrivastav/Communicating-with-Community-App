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
    
    let items: [NeedItem] = [
        // Needs
        NeedItem(image: "water", text: "I want water", category: .need),
        NeedItem(image: "food", text: "I want food", category: .need),
        NeedItem(image: "bed", text: "I want to sleep", category: .need),
        NeedItem(image: "toilet", text: "I want to go to the bathroom", category: .need),
        
        // Wants
        NeedItem(image: "walk", text: "I want to go for a walk", category: .want),
        NeedItem(image: "play", text: "I want to play", category: .want),
        NeedItem(image: "mom", text: "I want mom", category: .want),
        NeedItem(image: "dad", text: "I want dad", category: .want),
        NeedItem(image: "brother", text: "I want my brother", category: .want),
        NeedItem(image: "sister", text: "I want my sister", category: .want),
        
        // Feelings
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
            if let category = selectedCategory {
                // Back button
                Button("← Back") {
                    selectedCategory = nil
                    speak(text: "Back to menu")
                }
                .font(.title2)
                .padding()

                // Title
                Text(category == .need ? "Needs" :
                     category == .want ? "Wants" : "Feelings")
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(category == .need ? .red :
                                     category == .want ? .green : .blue)

                // Scrollable grid of items
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
                                        .padding(.top, 5)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(category == .need ? Color.red.opacity(0.3) :
                                            category == .want ? Color.green.opacity(0.3) :
                                            Color.blue.opacity(0.3))
                                .cornerRadius(15)
                            }
                        }
                    }
                    .padding()
                }
            } else {
                // Main menu with Needs, Wants, Feelings
                Text("Choose a Category")
                    .font(.largeTitle)
                    .padding()
                
                VStack(spacing: 40) {
                    HStack(spacing: 40) {
                        Button(action: {
                            selectedCategory = .need
                            speak(text: "Needs")
                        }) {
                            Text("Needs")
                                .font(.title)
                                .padding()
                                .frame(width: 160, height: 120)
                                .background(Color.red.opacity(0.3))
                                .cornerRadius(15)
                        }
                        
                        Button(action: {
                            selectedCategory = .want
                            speak(text: "Wants")
                        }) {
                            Text("Wants")
                                .font(.title)
                                .padding()
                                .frame(width: 160, height: 120)
                                .background(Color.green.opacity(0.3))
                                .cornerRadius(15)
                        }
                    }
                    
                    Button(action: {
                        selectedCategory = .feeling
                        speak(text: "Feelings")
                    }) {
                        Text("Feelings")
                            .font(.title)
                            .padding()
                            .frame(width: 200, height: 120)
                            .background(Color.blue.opacity(0.3))
                            .cornerRadius(15)
                    }
                }
                .padding()
            }
        }
    }

    // MARK: - Text-to-Speech
    func speak(text: String) {
        DispatchQueue.main.async {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: bestAvailableVoice())
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate
            synthesizer.speak(utterance)
        }
    }

    func bestAvailableVoice() -> String {
        let available = AVSpeechSynthesisVoice.speechVoices().map { $0.language }
        if available.contains("en-US") { return "en-US" }
        else if available.contains("en-GB") { return "en-GB" }
        else if available.contains("en-IN") { return "en-IN" }
        else { return AVSpeechSynthesisVoice.currentLanguageCode() }
    }
}

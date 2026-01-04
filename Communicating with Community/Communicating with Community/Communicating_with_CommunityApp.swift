import SwiftUI
import SwiftUI
#if os(iOS)
import UIKit
#endif
import AVFoundation

// MARK: - Main Communication Board View

/// The main view for the communication board app
/// Supports multiple languages with text-to-speech
struct SpeechBoardView: View {
    
    // MARK: - Types
    
    /// Supported languages in the app
    enum AppLanguage: String, CaseIterable, Identifiable {
        case english = "en"
        case hindi = "hi"
        case spanish = "es"
        case chinese = "zh"
        case french = "fr"
        
        var id: String { rawValue }
        
        var displayName: String {
            switch self {
            case .english: return EnglishLocalizationProvider().displayName
            case .hindi: return HindiLocalizationProvider().displayName
            case .spanish: return SpanishLocalizationProvider().displayName
            case .chinese: return ChineseLocalizationProvider().displayName
            case .french: return FrenchLocalizationProvider().displayName
            }
        }
        
        var preferredVoiceCodes: [String] {
            switch self {
            case .english: return EnglishLocalizationProvider().preferredVoiceCodes
            case .hindi: return HindiLocalizationProvider().preferredVoiceCodes
            case .spanish: return SpanishLocalizationProvider().preferredVoiceCodes
            case .chinese: return ChineseLocalizationProvider().preferredVoiceCodes
            case .french: return FrenchLocalizationProvider().preferredVoiceCodes
            }
        }
    }
    
    // MARK: - State Properties

    @AppStorage("selectedLanguageCode") private var selectedLanguageCode: String = ""
    @State private var showLanguagePicker: Bool = true
    
    @State private var selectedCategory: NeedItem.Category? = nil
    @State private var showIntro = true
    @State private var isSentenceBuilderActive = false

    // MARK: - Computed Properties
    
    private var currentLanguage: AppLanguage {
        AppLanguage(rawValue: selectedLanguageCode) ?? .english
    }
    
    private var provider: LocalizationProvider {
        switch currentLanguage {
        case .english: return EnglishLocalizationProvider()
        case .hindi: return HindiLocalizationProvider()
        case .spanish: return SpanishLocalizationProvider()
        case .chinese: return ChineseLocalizationProvider()
        case .french: return FrenchLocalizationProvider()
        }
    }

    private var localizedWordBank: [String] {
        provider.wordBank
    }
    
    private var localizedItems: [NeedItem] {
        provider.items
    }
    
    @State private var currentSentence: [String] = []
    @State private var typedSentence: String = ""
    
    let synthesizer = AVSpeechSynthesizer()

    var body: some View {
        VStack {
            if showLanguagePicker {
                languagePickerView
            } else if showIntro {
                IntroView(
                    startLabel: L("start_using_board"),
                    hearQuickSummaryLabel: L("hear_quick_summary"),
                    onStart: {
                        showIntro = false
                        let message: String = L("prompt_choose_category")
                        speak(text: message)
                    },
                    onHearQuickSummary: {
                        speak(text: L("quick_summary_text"))
                    }
                )
            } else {
                mainContent
            }
        }
        .onAppear {
            // If a language was previously selected, skip picker
            if !selectedLanguageCode.isEmpty {
                showLanguagePicker = false
            }
        }
    }
    
    // MARK: - Language Picker View
    
    private var languagePickerView: some View {
        VStack(spacing: 20) {
            Text(L("choose_language_title"))
                .font(.largeTitle)
                .padding()

            // Grid of language buttons
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    languageButton(for: .english, color: .blue)
                    languageButton(for: .hindi, color: .green)
                }
                
                HStack(spacing: 20) {
                    languageButton(for: .spanish, color: .orange)
                    languageButton(for: .chinese, color: .red)
                }
                
                HStack(spacing: 20) {
                    languageButton(for: .french, color: .purple)
                }
            }
            .padding(.horizontal)

            Button(action: {
                // Voice a hint in currently default language (English fallback)
                speak(text: L("prompt_select_language"))
            }) {
                Text(L("hear_prompt"))
                    .font(.body)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
    }

    private func languageButton(for language: AppLanguage, color: Color) -> some View {
        Button(action: {
            selectedLanguageCode = language.rawValue
            showLanguagePicker = false
            // Dynamically construct confirmation key based on language code
            let confirmationKey = "confirm_language_selected_\(language.rawValue)"
            speak(text: L(confirmationKey))
        }) {
            Text(language.displayName)
                .font(.title)
                .padding()
                .frame(width: 160, height: 120)
                .background(color.opacity(0.3))
                .cornerRadius(15)
        }
    }
    
    // MARK: - Main Content
    private var mainContent: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    let msg = L("prompt_info")
                    speak(text: msg)
                    showIntro = true
                }) {
                    HStack {
                        Image(systemName: "info.circle")
                        Text(L("info"))
                    }
                }
                .padding()
                
                Button(action: { showLanguagePicker = true }) {
                    HStack { Image(systemName: "globe"); Text(L("change_language")) }
                }
                .padding(.trailing)
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
            Text(L("choose_category"))
                .font(.largeTitle)
                .padding()
            
            HStack(spacing: 30) {
                categoryButton(title: provider.categoryTitle(for: .need), color: .red) {
                    selectedCategory = .need
                }
                categoryButton(title: provider.categoryTitle(for: .want), color: .green) {
                    selectedCategory = .want
                }
            }
            
            categoryButton(title: provider.categoryTitle(for: .feeling), color: .blue) {
                selectedCategory = .feeling
            }
            
            Button(action: {
                isSentenceBuilderActive = true
                currentSentence.removeAll()
                typedSentence = ""
                let msg = L("prompt_sentence_builder")
                speak(text: msg)
            }) {
                Text(L("sentence_builder"))
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
            Button(action: {
                selectedCategory = nil
                let msg = L("prompt_back_to_menu")
                speak(text: msg)
            }) {
                Text("← " + L("back"))
            }
            .font(.title2)
            .padding()
            
            Text(provider.categoryTitle(for: category))
                .font(.largeTitle)
                .padding()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 20) {
                    ForEach(localizedItems.filter { $0.category == category }) { item in
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
            Button(action: {
                isSentenceBuilderActive = false
                currentSentence.removeAll()
                typedSentence = ""
                let msg = L("prompt_back_to_menu")
                speak(text: msg)
            }) {
                Text("← " + L("back"))
            }
            .font(.title2)
            .padding(.horizontal)
            
            Text(L("sentence_builder"))
                .font(.largeTitle)
                .padding(.horizontal)
            
            // Word-bank sentence
            VStack(alignment: .leading) {
                Text(L("title_word_bank_sentence"))
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
                Button(L("speak_word_bank")) {
                    let s = currentSentence.joined(separator: " ")
                    speak(text: s.isEmpty ? L("prompt_choose_words") : s)
                }
                .padding()
                .background(Color.blue.opacity(0.3))
                .cornerRadius(10)
                
                Button(L("clear_words")) {
                    currentSentence.removeAll()
                }
                .padding()
                .background(Color.red.opacity(0.3))
                .cornerRadius(10)
            }
            .padding(.horizontal)
            
            // Typed sentence
            VStack(alignment: .leading, spacing: 8) {
                Text(L("type_your_sentence"))
                    .font(.headline)
                
                LanguageAwareTextField(
                    placeholder: L("type_here"),
                    text: $typedSentence,
                    languageCode: currentLanguage.rawValue
                )
                .frame(height: 40)
                .padding(.horizontal, 4)
                
                HStack(spacing: 16) {
                    Button(L("speak_typed_sentence")) {
                        let trimmed = typedSentence.trimmingCharacters(in: .whitespacesAndNewlines)
                        speak(text: trimmed.isEmpty ? L("prompt_type_sentence") : trimmed)
                    }
                    .padding()
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(10)
                    
                    Button(L("clear")) {
                        typedSentence = ""
                    }
                    .padding()
                    .background(Color.orange.opacity(0.3))
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            
            // Word bank
            Text(L("word_bank"))
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 12) {
                    ForEach(localizedWordBank, id: \.self) { word in
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

    // Centralized localization helper to ensure we always use the resolved current language
    private func L(_ key: String) -> String {
        Localizer.string(key, langCode: currentLanguage.rawValue)
    }
    
    // MARK: - Text-To-Speech
    func speak(text: String) {
        DispatchQueue.main.async {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: bestAvailableVoice(for: selectedLanguageCode))
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate
            synthesizer.speak(utterance)
        }
    }

    func bestAvailableVoice(for selectedLangCode: String) -> String {
        let available = Set(AVSpeechSynthesisVoice.speechVoices().map { $0.language })
        // Determine target language preferences
        let target: AppLanguage = AppLanguage(rawValue: selectedLangCode) ?? .english
        for code in target.preferredVoiceCodes {
            if available.contains(code) { return code }
        }
        // Fallbacks: try current device language, then any English, then any available
        if available.contains(AVSpeechSynthesisVoice.currentLanguageCode()) {
            return AVSpeechSynthesisVoice.currentLanguageCode()
        }
        if available.contains("en-US") { return "en-US" }
        return AVSpeechSynthesisVoice.speechVoices().first?.language ?? "en-US"
    }
}


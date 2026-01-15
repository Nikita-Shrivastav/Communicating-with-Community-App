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
        case portuguese = "pt"
        
        var id: String { rawValue }
        
        var displayName: String {
            switch self {
            case .english: return EnglishLocalizationProvider().displayName
            case .hindi: return HindiLocalizationProvider().displayName
            case .spanish: return SpanishLocalizationProvider().displayName
            case .chinese: return ChineseLocalizationProvider().displayName
            case .french: return FrenchLocalizationProvider().displayName
            case .portuguese: return PortugueseLocalizationProvider().displayName
            }
        }
        
        var preferredVoiceCodes: [String] {
            switch self {
            case .english: return EnglishLocalizationProvider().preferredVoiceCodes
            case .hindi: return HindiLocalizationProvider().preferredVoiceCodes
            case .spanish: return SpanishLocalizationProvider().preferredVoiceCodes
            case .chinese: return ChineseLocalizationProvider().preferredVoiceCodes
            case .french: return FrenchLocalizationProvider().preferredVoiceCodes
            case .portuguese: return PortugueseLocalizationProvider().preferredVoiceCodes
            }
        }
    }
    
    // MARK: - State Properties

    @AppStorage("selectedLanguageCode") private var selectedLanguageCode: String = ""
    @State private var showLanguagePicker: Bool = true
    
    @State private var selectedCategory: ItemCategory? = nil
    @State private var showIntro = true
    @State private var isSentenceBuilderActive = false
    @State private var showTutorial = false

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
        case .portuguese: return PortugueseLocalizationProvider()
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
            } else if showTutorial {
                GuidedTutorialView(languageCode: currentLanguage.rawValue) {
                    showTutorial = false
                }
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
                    },
                    onStartTutorial: {
                        showIntro = false
                        showTutorial = true
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
                    languageButton(for: .portuguese, color: .cyan)
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
                    showTutorial = true
                }) {
                    HStack {
                        Image(systemName: "graduationcap.fill")
                        Text(L("tutorial_button"))
                    }
                }
                .padding()
                
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
        VStack(spacing: 0) {
            // Title section
            VStack(spacing: 12) {
                Text(L("choose_category"))
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                
                Text(L("menu_subtitle"))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 20)
            .padding(.horizontal)
            
            Spacer()
            
            // Main category buttons in 2x2 grid
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    categoryButton(
                        title: provider.categoryTitle(for: .need),
                        icon: "heart.fill",
                        color: .red,
                        action: { selectedCategory = .need }
                    )
                    
                    categoryButton(
                        title: provider.categoryTitle(for: .want),
                        icon: "star.fill",
                        color: .green,
                        action: { selectedCategory = .want }
                    )
                }
                
                HStack(spacing: 20) {
                    categoryButton(
                        title: provider.categoryTitle(for: .feeling),
                        icon: "face.smiling.fill",
                        color: .blue,
                        action: { selectedCategory = .feeling }
                    )
                    
                    sentenceBuilderButton
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
    }
    
    private var sentenceBuilderButton: some View {
        Button(action: {
            isSentenceBuilderActive = true
            currentSentence.removeAll()
            typedSentence = ""
            let msg = L("prompt_sentence_builder")
            speak(text: msg)
        }) {
            VStack(spacing: 12) {
                Image(systemName: "text.bubble.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                
                Text(L("sentence_builder"))
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.8)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 160)
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.purple, Color.purple.opacity(0.7)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(color: Color.purple.opacity(0.3), radius: 8, x: 0, y: 4)
        }
    }
    
    private func categoryButton(title: String, icon: String, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
            speak(text: title)
        }) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.8)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 160)
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [color, color.opacity(0.7)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(color: color.opacity(0.3), radius: 8, x: 0, y: 4)
        }
    }
    
    // MARK: - Category View
    private func categoryView(for category: ItemCategory) -> some View {
        let categoryColor = colorForCategory(category)
        
        return VStack {
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
                .font(.largeTitle.bold())
                .padding()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 20) {
                    ForEach(localizedItems.filter { $0.category == category }) { item in
                        Button(action: {
                            speak(text: item.text)
                        }) {
                            VStack(spacing: 12) {
                                Image(item.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.white)
                                
                                Text(item.text)
                                    .font(.headline.bold())
                                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .minimumScaleFactor(0.8)
                            }
                            .padding()
                            .frame(minHeight: 140)
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [categoryColor.opacity(0.9), categoryColor.opacity(0.7)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(15)
                            .shadow(color: categoryColor.opacity(0.4), radius: 6, x: 0, y: 3)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
    }
    
    // Helper function to get color for each category
    private func colorForCategory(_ category: ItemCategory) -> Color {
        switch category {
        case .need:
            return .red
        case .want:
            return .green
        case .feeling:
            return .blue
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
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 12) {
                    ForEach(localizedWordBank, id: \.self) { word in
                        Button(action: {
                            currentSentence.append(word)
                        }) {
                            HStack(spacing: 6) {
                                if let emoji = EmojiMapper.emoji(for: word, languageCode: currentLanguage.rawValue) {
                                    Text(emoji)
                                }
                                Text(word)
                                    .font(.body)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.8)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
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

// MARK: - Emoji Mapper for Word Bank
struct EmojiMapper {
    // Base, language-agnostic mappings by normalized lowercase word
    private static let base: [String: String] = [
        // Pronouns / People
        "i": "🙋", "me": "🙋", "yo": "🙋", "मैं": "🙋", "我": "🙋",
        "you": "👉", "tú": "👉", "usted": "👉", "आप": "👉", "你": "👉",
        "we": "👥", "nosotros": "👥", "nosotras": "👥", "हम": "👥", "我们": "👥",
        "they": "👥", "ellos": "👥", "ellas": "👥", "वे": "👥", "他们": "👥",
        "he": "👨", "él": "👨", "वह": "👨", "他": "👨",
        "she": "👩", "ella": "👩", "वह_स्त्री": "👩", "她": "👩",
        "mom": "👩‍🍼", "mother": "👩‍🍼", "mamá": "👩‍🍼", "madre": "👩‍🍼", "माँ": "👩‍🍼", "妈妈": "👩‍🍼",
        "dad": "👨‍🍼", "father": "👨‍🍼", "papá": "👨‍🍼", "padre": "👨‍🍼", "पापा": "👨‍🍼", "爸爸": "👨‍🍼",
        "brother": "👦", "hermano": "👦", "भाई": "👦", "哥哥": "👦",
        "sister": "👧", "hermana": "👧", "बहन": "👧", "姐姐": "👧",
        "teacher": "👩‍🏫", "maestro": "👨‍🏫", "maestra": "👩‍🏫", "老师": "👩‍🏫",

        // Core actions
        "want": "✨", "quiero": "✨", "quieres": "✨", "चाहता हूँ": "✨", "想要": "✨",
        "need": "❗️", "necesito": "❗️", "ज़रूरत": "❗️", "需要": "❗️",
        "go": "➡️", "ir": "➡️", "जाना": "➡️", "去": "➡️",
        "come": "⬅️", "venir": "⬅️", "आना": "⬅️", "来": "⬅️",
        "help": "🆘", "ayuda": "🆘", "मदद": "🆘", "帮助": "🆘",
        "more": "➕", "más": "➕", "और": "➕", "更多": "➕",
        "stop": "⛔️", "alto": "⛔️", "रुको": "⛔️", "停": "⛔️",
        "yes": "✅", "sí": "✅", "हाँ": "✅", "是": "✅",
        "no": "❌", "no_es": "❌", "नहीं": "❌", "不是": "❌",
        "please": "🙏", "por favor": "🙏", "कृपया": "🙏", "请": "🙏",
        "thank you": "🤝", "gracias": "🤝", "धन्यवाद": "🤝", "谢谢": "🤝",

        // Feelings
        "happy": "😊", "feliz": "😊", "खुश": "😊", "开心": "😊",
        "sad": "😢", "triste": "😢", "उदास": "😢", "难过": "😢",
        "angry": "😠", "enojado": "😠", "enojada": "😠", "गुस्सा": "😠", "生气": "😠",
        "scared": "😨", "asustado": "😨", "asustada": "😨", "डर": "😨", "害怕": "😨",
        "tired": "😴", "cansado": "😴", "cansada": "😴", "थका": "😴", "累": "😴",
        "sick": "🤒", "enfermo": "🤒", "enferma": "🤒", "बीमार": "🤒", "生病": "🤒",
        "hurt": "🤕", "duele": "🤕", "痛": "🤕",

        // Food & drink
        "water": "💧", "agua": "💧", "पानी": "💧", "水": "💧",
        "food": "🍽️", "comida": "🍽️", "खाना": "🍽️", "食物": "🍽️",
        "eat": "🍽️", "comer": "🍽️", "吃": "🍽️",
        "drink": "🥤", "beber": "🥤", "喝": "🥤",
        "milk": "🥛", "leche": "🥛", "दूध": "🥛", "牛奶": "🥛",
        "juice": "🧃", "jugo": "🧃", "रस": "🧃", "果汁": "🧃",
        "pizza": "🍕", "披萨": "🍕",
        "rice": "🍚", "arroz": "🍚", "चावल": "🍚", "米饭": "🍚",
        "bread": "🍞", "pan": "🍞", "रोटी": "🍞", "面包": "🍞",
        "apple": "🍎", "manzana": "🍎", "सेब": "🍎", "苹果": "🍎",

        // Places
        "home": "🏠", "house": "🏠", "casa": "🏠", "घर": "🏠", "家": "🏠",
        "school": "🏫", "escuela": "🏫", "स्कूल": "🏫", "学校": "🏫",
        "bathroom": "🚻", "baño": "🚻", "toilet": "🚻", "बाथरूम": "🚻", "厕所": "🚻",
        "park": "🏞️", "parque": "🏞️", "पार्क": "🏞️", "公园": "🏞️",
        "hospital": "🏥", "hospital_es": "🏥", "अस्पताल": "🏥", "医院": "🏥",

        // Activities
        "play": "🧩", "jugar": "🧩", "खेलना": "🧩", "玩": "🧩",
        "sleep": "🛌", "dormir": "🛌", "सोना": "🛌", "睡觉": "🛌",
        "read": "📖", "leer": "📖", "पढ़ना": "📖", "阅读": "📖",
        "write": "✍️", "escribir": "✍️", "लिखना": "✍️", "写": "✍️",
        "music": "🎵", "música": "🎵", "संगीत": "🎵", "音乐": "🎵",
        "phone": "📱", "teléfono": "📱", "电话": "📱",

        // Descriptors / helpers
        "big": "🟦", "grande": "🟦", "बड़ा": "🟦", "大": "🟦",
        "small": "🟩", "pequeño": "🟩", "छोटा": "🟩", "小": "🟩",
        "hot": "🔥", "caliente": "🔥", "गरम": "🔥", "热": "🔥",
        "cold": "🧊", "frío": "🧊", "ठंडा": "🧊", "冷": "🧊",
        "clean": "🧼", "limpio": "🧼", "साफ": "🧼", "干净": "🧼",
        "dirty": "🧹", "sucio": "🧹", "गंदा": "🧹", "脏": "🧹"
    ]

    // Language-specific overrides (use language code keys)
    private static let languageOverrides: [String: [String: String]] = [
        "en": [
            "hurt": "🤕", "sick": "🤒", "bathroom": "🚻", "toilet": "🚻", "play": "🧩"
        ],
        "es": [
            "baño": "🚻", "jugar": "🧩", "hospital": "🏥"
        ],
        "zh": [:],
        "hi": [:],
        "fr": [:],
        "pt": [
            "água": "💧", "comida": "🍽️", "casa": "🏠", "banheiro": "🚻",
            "feliz": "😊", "triste": "😢", "ajuda": "🆘", "por favor": "🙏"
        ]
    ]

    // Normalizes words for lookup (lowercased, trimmed)
    private static func normalize(_ word: String) -> String {
        word.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }

    static func emoji(for word: String, languageCode: String) -> String? {
        let norm = normalize(word)
        let short = languageCode.split(separator: "-").first.map(String.init) ?? languageCode
        if let langMap = languageOverrides[short], let e = langMap[norm] { return e }
        if let e = base[norm] { return e }
        return nil
    }
}


import SwiftUI
import AVFoundation

/// A guided tutorial that walks users through the main features of the app
struct GuidedTutorialView: View {
    
    // MARK: - Tutorial Steps
    
    enum TutorialStep: Int, CaseIterable {
        case welcome = 0
        case categories
        case needsDemo
        case sentenceBuilder
        case wordBank
        case typing
        case completion
        
        var title: String {
            switch self {
            case .welcome: return "tutorial_welcome_title"
            case .categories: return "tutorial_categories_title"
            case .needsDemo: return "tutorial_needs_demo_title"
            case .sentenceBuilder: return "tutorial_sentence_builder_title"
            case .wordBank: return "tutorial_word_bank_title"
            case .typing: return "tutorial_typing_title"
            case .completion: return "tutorial_completion_title"
            }
        }
        
        var description: String {
            switch self {
            case .welcome: return "tutorial_welcome_description"
            case .categories: return "tutorial_categories_description"
            case .needsDemo: return "tutorial_needs_demo_description"
            case .sentenceBuilder: return "tutorial_sentence_builder_description"
            case .wordBank: return "tutorial_word_bank_description"
            case .typing: return "tutorial_typing_description"
            case .completion: return "tutorial_completion_description"
            }
        }
        
        var icon: String {
            switch self {
            case .welcome: return "hand.wave.fill"
            case .categories: return "square.grid.2x2.fill"
            case .needsDemo: return "heart.fill"
            case .sentenceBuilder: return "text.bubble.fill"
            case .wordBank: return "character.book.closed.fill"
            case .typing: return "keyboard.fill"
            case .completion: return "checkmark.circle.fill"
            }
        }
    }
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    let languageCode: String
    let onComplete: () -> Void
    
    @State private var currentStep: TutorialStep = .welcome
    @State private var isPlaying = false
    @State private var demoSentence: [String] = []
    @State private var demoTypedText: String = ""
    @State private var showLanguagePicker = false
    @State private var selectedLanguage: String
    
    private let synthesizer = AVSpeechSynthesizer()
    
    init(languageCode: String, onComplete: @escaping () -> Void) {
        self.languageCode = languageCode
        self.onComplete = onComplete
        self._selectedLanguage = State(initialValue: languageCode)
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Progress bar with language button
                topBar
                
                // Main content
                ScrollView {
                    VStack(spacing: 24) {
                        // Step icon and title
                        stepHeader
                        
                        // Step content
                        stepContent
                        
                        // Interactive demo (if applicable)
                        if shouldShowDemo {
                            interactiveDemo
                        }
                    }
                    .padding()
                }
                
                // Navigation buttons
                navigationButtons
            }
            #if os(iOS)
            .background(Color(uiColor: .systemBackground))
            #else
            .background(Color(nsColor: .windowBackgroundColor))
            #endif
            
            // Language picker overlay
            if showLanguagePicker {
                languagePickerOverlay
            }
        }
    }
    
    // MARK: - Top Bar (Progress + Language Button + Exit)
    
    private var topBar: some View {
        ZStack(alignment: .trailing) {
            // Progress bar (centered)
            progressBar
            
            // Buttons stack (right side)
            VStack(spacing: 8) {
                // Language button (top)
                Button(action: {
                    showLanguagePicker = true
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "globe")
                            .font(.system(size: 14))
                        Text(languageDisplayName)
                            .font(.caption)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                }
                
                // Exit button (bottom)
                Button(action: {
                    onComplete()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 14))
                        Text(L("tutorial_exit"))
                            .font(.caption)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.red.opacity(0.1))
                    .foregroundColor(.red)
                    .cornerRadius(12)
                }
            }
            .padding(.trailing, 8)
        }
        .frame(height: 80)
    }
    
    private var languageDisplayName: String {
        switch selectedLanguage {
        case "hi": return "हिन्दी"
        case "es": return "Español"
        case "zh": return "中文"
        case "pt": return "Português"
        default: return "English"
        }
    }
    
    // MARK: - Language Picker Overlay
    
    private var languagePickerOverlay: some View {
        ZStack {
            // Dimmed background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    showLanguagePicker = false
                }
            
            // Language picker card
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Text(L("choose_language_title"))
                            .font(.title2.bold())
                        
                        Spacer()
                        
                        Button(action: {
                            showLanguagePicker = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        languageButton(code: "en", name: "English", icon: "🇺🇸")
                        languageButton(code: "hi", name: "हिन्दी", icon: "🇮🇳")
                        languageButton(code: "es", name: "Español", icon: "🇪🇸")
                        languageButton(code: "zh", name: "中文", icon: "🇨🇳")
                        languageButton(code: "pt", name: "Português", icon: "🇵🇹")
                    }
                    
                    Text(L("tutorial_language_change_note"))
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 8)
                }
                .padding(24)
            }
            .frame(maxHeight: 600)
            #if os(iOS)
            .background(Color(uiColor: .systemBackground))
            #else
            .background(Color(nsColor: .windowBackgroundColor))
            #endif
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding(40)
        }
    }
    
    private func languageButton(code: String, name: String, icon: String) -> some View {
        Button(action: {
            selectedLanguage = code
            showLanguagePicker = false
            
            // Announce language change
            speak(text: L("confirm_language_selected_\(code)"))
        }) {
            VStack(spacing: 8) {
                Text(icon)
                    .font(.system(size: 40))
                Text(name)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .background(selectedLanguage == code ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectedLanguage == code ? Color.blue : Color.clear, lineWidth: 2)
            )
        }
    }
    
    // MARK: - Progress Bar
    
    private var progressBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: geometry.size.width * progress)
            }
        }
        .frame(height: 6)
    }
    
    private var progress: CGFloat {
        CGFloat(currentStep.rawValue + 1) / CGFloat(TutorialStep.allCases.count)
    }
    
    // MARK: - Step Header
    
    private var stepHeader: some View {
        VStack(spacing: 16) {
            Image(systemName: currentStep.icon)
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text(L(currentStep.title))
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            
            Text(stepIndicatorText)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.top)
    }
    
    private var stepIndicatorText: String {
        let template = L("tutorial_step_indicator")
        let current = String(currentStep.rawValue + 1)
        let total = String(TutorialStep.allCases.count)
        
        // Replace %@ placeholders with actual values
        var result = template
        if let range = result.range(of: "%@") {
            result.replaceSubrange(range, with: current)
        }
        if let range = result.range(of: "%@") {
            result.replaceSubrange(range, with: total)
        }
        
        return result
    }
    
    // MARK: - Step Content
    
    private var stepContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(L(currentStep.description))
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
            
            // Audio button for each step
            Button(action: {
                speakCurrentStep()
            }) {
                HStack {
                    Image(systemName: isPlaying ? "speaker.wave.3.fill" : "speaker.wave.2.fill")
                    Text(L("tutorial_hear_step"))
                }
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green.opacity(0.2))
                .cornerRadius(12)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
    
    // MARK: - Interactive Demo
    
    private var shouldShowDemo: Bool {
        currentStep == .needsDemo || currentStep == .wordBank || currentStep == .typing
    }
    
    @ViewBuilder
    private var interactiveDemo: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(L("tutorial_try_it"))
                .font(.title3.bold())
            
            switch currentStep {
            case .needsDemo:
                needsDemoView
            case .wordBank:
                wordBankDemoView
            case .typing:
                typingDemoView
            default:
                EmptyView()
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }
    
    // MARK: - Needs Demo
    
    private var needsDemoView: some View {
        VStack(spacing: 16) {
            Text(L("tutorial_tap_item"))
                .font(.body)
                .foregroundColor(.secondary)
            
            HStack(spacing: 16) {
                demoButton(text: L("tutorial_demo_water"), image: "drop.fill") {
                    speak(text: L("tutorial_demo_water"))
                }
                
                demoButton(text: L("tutorial_demo_food"), image: "fork.knife") {
                    speak(text: L("tutorial_demo_food"))
                }
                
                demoButton(text: L("tutorial_demo_help"), image: "hand.raised.fill") {
                    speak(text: L("tutorial_demo_help"))
                }
            }
        }
    }
    
    // MARK: - Word Bank Demo
    
    private var wordBankDemoView: some View {
        VStack(spacing: 16) {
            // Display sentence
            VStack(alignment: .leading, spacing: 8) {
                Text(L("tutorial_your_sentence"))
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(demoSentence.isEmpty ? L("tutorial_empty_sentence") : demoSentence.joined(separator: " "))
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(minHeight: 60)
                    .background(Color.white)
                    .cornerRadius(8)
            }
            
            // Control buttons
            HStack(spacing: 12) {
                Button(action: {
                    let sentence = demoSentence.joined(separator: " ")
                    speak(text: sentence.isEmpty ? L("tutorial_empty_sentence") : sentence)
                }) {
                    HStack {
                        Image(systemName: "speaker.wave.2.fill")
                        Text(L("tutorial_speak"))
                    }
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(8)
                }
                
                Button(action: {
                    demoSentence.removeAll()
                }) {
                    HStack {
                        Image(systemName: "trash.fill")
                        Text(L("tutorial_clear"))
                    }
                    .font(.caption)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.red.opacity(0.3))
                    .cornerRadius(8)
                }
            }
            
            // Word bank
            Text(L("tutorial_tap_words"))
                .font(.caption)
                .foregroundColor(.secondary)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 8) {
                ForEach(demoWordBank, id: \.self) { word in
                    Button(action: {
                        demoSentence.append(word)
                    }) {
                        Text(word)
                            .font(.body)
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .background(Color.purple.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
    
    private var demoWordBank: [String] {
        switch selectedLanguage {
        case "hi":
            return ["मैं", "चाहता हूँ", "पानी", "खाना", "मदद", "कृपया"]
        case "es":
            return ["yo", "quiero", "agua", "comida", "ayuda", "por favor"]
        case "zh":
            return ["我", "想要", "水", "食物", "帮助", "请"]
        case "pt":
            return ["eu", "quero", "água", "comida", "ajuda", "por favor"]
        default:
            return ["I", "want", "water", "food", "help", "please"]
        }
    }
    
    // MARK: - Typing Demo
    
    private var typingDemoView: some View {
        VStack(spacing: 16) {
            Text(L("tutorial_type_anything"))
                .font(.body)
                .foregroundColor(.secondary)
            
            TextField(L("tutorial_type_here"), text: $demoTypedText)
                .textFieldStyle(.roundedBorder)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            
            HStack(spacing: 12) {
                Button(action: {
                    speak(text: demoTypedText.isEmpty ? L("tutorial_type_something_first") : demoTypedText)
                }) {
                    HStack {
                        Image(systemName: "speaker.wave.2.fill")
                        Text(L("tutorial_speak"))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(8)
                }
                
                Button(action: {
                    demoTypedText = ""
                }) {
                    HStack {
                        Image(systemName: "trash.fill")
                        Text(L("tutorial_clear"))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red.opacity(0.3))
                    .cornerRadius(8)
                }
            }
        }
    }
    
    private func demoButton(text: String, image: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: image)
                    .font(.title)
                Text(text)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(12)
        }
    }
    
    // MARK: - Navigation Buttons
    
    private var navigationButtons: some View {
        HStack(spacing: 16) {
            // Previous button
            if currentStep.rawValue > 0 {
                Button(action: {
                    goToPreviousStep()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text(L("tutorial_previous"))
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                }
            }
            
            // Next/Finish button
            Button(action: {
                if currentStep == .completion {
                    completeWithAnimation()
                } else {
                    goToNextStep()
                }
            }) {
                HStack {
                    Text(currentStep == .completion ? L("tutorial_finish") : L("tutorial_next"))
                    if currentStep != .completion {
                        Image(systemName: "chevron.right")
                    } else {
                        Image(systemName: "checkmark")
                    }
                }
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(currentStep == .completion ? Color.green : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
        }
        .padding()
        #if os(iOS)
        .background(Color(uiColor: .systemBackground))
        #else
        .background(Color(nsColor: .windowBackgroundColor))
        #endif
        .shadow(radius: 4)
    }
    
    // MARK: - Navigation Methods
    
    private func goToNextStep() {
        withAnimation {
            if let nextStep = TutorialStep(rawValue: currentStep.rawValue + 1) {
                currentStep = nextStep
                resetDemoState()
            }
        }
    }
    
    private func goToPreviousStep() {
        withAnimation {
            if let previousStep = TutorialStep(rawValue: currentStep.rawValue - 1) {
                currentStep = previousStep
                resetDemoState()
            }
        }
    }
    
    private func resetDemoState() {
        demoSentence.removeAll()
        demoTypedText = ""
    }
    
    private func completeWithAnimation() {
        // Mark tutorial as completed
        UserDefaults.standard.set(true, forKey: "hasCompletedTutorial")
        
        // Speak completion message
        speak(text: L("tutorial_completion_message"))
        
        // Dismiss after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            onComplete()
        }
    }
    
    // MARK: - Speech
    
    private func speak(text: String) {
        DispatchQueue.main.async {
            synthesizer.stopSpeaking(at: .immediate)
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: selectedLanguage)
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate
            synthesizer.speak(utterance)
        }
    }
    
    private func speakCurrentStep() {
        isPlaying = true
        speak(text: L(currentStep.title) + ". " + L(currentStep.description))
        
        // Reset playing state after speech
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            isPlaying = false
        }
    }
    
    // MARK: - Localization Helper
    
    private func L(_ key: String) -> String {
        Localizer.string(key, langCode: selectedLanguage)
    }
}

// MARK: - Preview

#Preview {
    GuidedTutorialView(languageCode: "en", onComplete: {
        print("Tutorial completed")
    })
}

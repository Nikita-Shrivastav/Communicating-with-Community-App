import SwiftUI
#if os(iOS)
import UIKit

// MARK: - Language-Specific UITextField

/// A custom UITextField subclass that attempts to prefer a specific language for the keyboard
class LanguageSpecificTextField: UITextField {
    var preferredLanguage: String?
    
    override var textInputMode: UITextInputMode? {
        if let preferredLanguage = preferredLanguage {
            // Try to find a text input mode matching the preferred language
            for mode in UITextInputMode.activeInputModes {
                if let language = mode.primaryLanguage,
                   language.hasPrefix(preferredLanguage) {
                    return mode
                }
            }
        }
        return super.textInputMode
    }
}

// MARK: - SwiftUI Wrapper

/// A SwiftUI wrapper for LanguageSpecificTextField that automatically switches keyboard
/// based on the selected language code (e.g., "en" for English, "hi" for Hindi)
struct LanguageAwareTextField: UIViewRepresentable {
    let placeholder: String
    @Binding var text: String
    let languageCode: String
    
    func makeUIView(context: Context) -> LanguageSpecificTextField {
        let textField = LanguageSpecificTextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.delegate = context.coordinator
        textField.autocorrectionType = .yes
        textField.spellCheckingType = .yes
        textField.preferredLanguage = languageCode
        
        return textField
    }
    
    func updateUIView(_ uiView: LanguageSpecificTextField, context: Context) {
        uiView.text = text
        uiView.placeholder = placeholder
        
        // Update preferred language if it changes
        if uiView.preferredLanguage != languageCode {
            uiView.preferredLanguage = languageCode
            // Reload input views to apply the new language preference
            if uiView.isFirstResponder {
                uiView.reloadInputViews()
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, languageCode: languageCode)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        let languageCode: String
        
        init(text: Binding<String>, languageCode: String) {
            _text = text
            self.languageCode = languageCode
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let currentText = textField.text,
               let textRange = Range(range, in: currentText) {
                let updatedText = currentText.replacingCharacters(in: textRange, with: string)
                text = updatedText
            }
            return true
        }
    }
}

#else

// MARK: - Fallback for non-iOS platforms

/// Fallback TextField for non-iOS platforms (macOS, etc.)
/// Uses standard SwiftUI TextField without language-specific keyboard switching
struct LanguageAwareTextField: View {
    let placeholder: String
    @Binding var text: String
    let languageCode: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(.roundedBorder)
    }
}

#endif

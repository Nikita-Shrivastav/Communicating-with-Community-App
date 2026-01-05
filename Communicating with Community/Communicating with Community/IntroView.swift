import SwiftUI

struct IntroView: View {
    let startLabel: String
    let hearQuickSummaryLabel: String
    let onStart: () -> Void
    let onHearQuickSummary: () -> Void
    let onStartTutorial: (() -> Void)?
    
    init(
        startLabel: String,
        hearQuickSummaryLabel: String,
        onStart: @escaping () -> Void,
        onHearQuickSummary: @escaping () -> Void,
        onStartTutorial: (() -> Void)? = nil
    ) {
        self.startLabel = startLabel
        self.hearQuickSummaryLabel = hearQuickSummaryLabel
        self.onStart = onStart
        self.onHearQuickSummary = onHearQuickSummary
        self.onStartTutorial = onStartTutorial
    }

    var body: some View {
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
                
                Text("This app is designed for people who find talking difficult, tiring, or stressful. It gives them simple tools to share what they need, what they want, and how they feel by tapping pictures and choosing words. When the user taps an item, the device speaks the sentence out loud using the built-in system voice.")
                    .font(.body)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Main parts of the app")
                        .font(.title3.bold())
                    
                    Text("• Needs – quick phrases like \"I want water\", \"I want food\", or \"I want to sleep\".\n• Wants – things the user might ask for, such as going for a walk or calling a family member.\n• Feelings – emotional words like happy, sad, mad, scared, anxious, or jealous.\n• Sentence Builder – a flexible area where the user can tap words from a word bank or type their own sentence and have it spoken aloud.")
                        .font(.body)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Why this app can be helpful")
                        .font(.title3.bold())
                    
                    Text("• It supports users who are non-speaking or have limited speech.\n• It reduces pressure to \"find the right words\" in the moment.\n• It can give the user more control over daily routines and choices.\n• It can help adults better understand pain, discomfort, and feelings without guessing.")
                        .font(.body)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Examples of how to use this app")
                        .font(.title3.bold())
                    
                    Text("• At home: asking for water, food, a break, or help with the bathroom.\n• At school: telling a teacher how they feel, asking to go to the nurse, or saying they are tired or overwhelmed.\n• In the community: telling a parent they are scared, hurt, or need to leave a busy place.\n• During therapy: giving the user a predictable way to answer questions and make choices.")
                        .font(.body)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("How adults can support the user")
                        .font(.title3.bold())
                    
                    Text("• Sit next to the user and show them how to tap pictures and words.\n• Model sentences out loud, for example: tap \"I\", \"feel\", \"happy\" and say the sentence with the device.\n• Offer the app during real situations instead of only \"practice time\".\n• Respond to the message as real communication, even if the sentence is short or not perfect.\n• Be patient and let the user explore. Mistaps and playful taps are part of learning.")
                        .font(.body)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("About the Sentence Builder")
                        .font(.title3.bold())
                    
                    Text("The Sentence Builder lets the user go beyond fixed picture phrases:\n\n• They can tap words like \"I\", \"want\", \"pizza\", \"now\", \"please\" to build their own sentence.\n• The app shows the sentence on the screen and speaks it out loud.\n• A typing box lets users who can spell type any sentence they want and hear it spoken.\nThis is useful for more advanced users who know what they want to say but need help speaking it.")
                        .font(.body)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Privacy and data")
                        .font(.title3.bold())
                    
                    Text("• The app does not require creating an account or logging in.\n• It does not upload the user’s words or sentences to a server.\n• All speech is generated using the device’s own text-to-speech system.\n• The app is meant to be simple, safe, and focused only on communication.")
                        .font(.body)
                }
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Important note")
                        .font(.title3.bold())
                    
                    Text("This app is a support tool, not a medical device. It does not replace speech therapy, medical care, or professional advice. Caregivers and professionals should decide how to best use it as part of the user’s overall support plan.")
                        .font(.body)
                }
                .padding(.horizontal)

                Button(action: {
                    onStart()
                }) {
                    Text(startLabel)
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.3))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                if let onStartTutorial = onStartTutorial {
                    Button(action: {
                        onStartTutorial()
                    }) {
                        HStack {
                            Image(systemName: "graduationcap.fill")
                            Text("Guided Tutorial")
                        }
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.3))
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
                Button(action: {
                    onHearQuickSummary()
                }) {
                    Text(hearQuickSummaryLabel)
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
}

#Preview {
    IntroView(startLabel: "Start using the board", hearQuickSummaryLabel: "Hear a quick summary", onStart: {}, onHearQuickSummary: {})
}

import SwiftUI
#if os(macOS)
import AppKit
#endif

@main
struct Communicating_with_CommunityApp: App {
    #if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif

    init() {
        // When running UI tests, reset persisted state before any SwiftUI
        // property wrappers read from UserDefaults. Setting the key to its
        // empty sentinel value (rather than removing it) guarantees that
        // @AppStorage reads "" and shows the language picker on every launch.
        if ProcessInfo.processInfo.environment["UI_TESTING_RESET"] == "1" {
            UserDefaults.standard.set("", forKey: "selectedLanguageCode")
            UserDefaults.standard.set(false, forKey: "hasCompletedTutorial")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            SpeechBoardView()
        }
        #if os(macOS)
        .defaultSize(width: 1200, height: 800)
        .commands {
            // Add full screen command to View menu
            CommandGroup(replacing: .sidebar) {
                Button("Toggle Full Screen") {
                    NSApplication.shared.keyWindow?.toggleFullScreen(nil)
                }
                .keyboardShortcut("f", modifiers: [.command, .control])
            }
        }
        #endif
    }
}

#if os(macOS)
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Skip full-screen during UI tests — window animations interfere with XCTest
        guard ProcessInfo.processInfo.environment["UI_TESTING_RESET"] != "1" else { return }
        // Enter full screen mode after a short delay to ensure window is ready
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let window = NSApplication.shared.windows.first {
                window.toggleFullScreen(nil)
            }
        }
    }
}
#endif

import SwiftUI
#if os(macOS)
import AppKit
#endif

@main
struct Communicating_with_CommunityApp: App {
    #if os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    
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
        // Enter full screen mode after a short delay to ensure window is ready
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let window = NSApplication.shared.windows.first {
                window.toggleFullScreen(nil)
            }
        }
    }
}
#endif

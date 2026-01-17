//
//  Communicating_with_CommunityUITestsLaunchTests.swift
//  Communicating with CommunityUITests
//
//  Created by nikita on 9/17/25.
//

import XCTest

final class Communicating_with_CommunityUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        #if os(macOS)
        // Enter full screen mode on macOS
        if let window = app.windows.firstMatch as? XCUIElement, window.exists {
            // Use keyboard shortcut to enter full screen (Cmd+Ctrl+F)
            window.typeKey("f", modifierFlags: [.command, .control])
            
            // Give the full screen animation time to complete
            Thread.sleep(forTimeInterval: 1.0)
        }
        #endif

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

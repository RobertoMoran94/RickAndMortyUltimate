//
//  RickAndMorty_SwiftUI_UltimateUITestsLaunchTests.swift
//  RickAndMorty_SwiftUI_UltimateUITests
//
//  Created by Roberto Moran on 12/15/24.
//

import XCTest

final class RickAndMorty_SwiftUI_UltimateUITestsLaunchTests: XCTestCase {

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

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}

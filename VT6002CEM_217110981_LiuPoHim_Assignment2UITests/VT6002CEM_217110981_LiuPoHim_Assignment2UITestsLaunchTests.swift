//
//  VT6002CEM_217110981_LiuPoHim_Assignment2UITestsLaunchTests.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2UITests
//
//  Created by user211668 on 1/4/22.
//

import XCTest

class VT6002CEM_217110981_LiuPoHim_Assignment2UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

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

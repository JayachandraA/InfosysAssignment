//
//  ViewControllerTests.swift
//  InfosysAssignmentTests
//
//  Created by Jayachandra on 12/16/19.
//  Copyright © 2019 BlueRose Technologies Pvt Ltd. All rights reserved.
//

import XCTest
@testable import InfosysAssignment

class ViewControllerTests: XCTestCase {

    let viewController = ViewController()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetup() {
        viewController.setup()
        XCTAssert(viewController.view != nil, "")
    }

}

//
//  FactTableViewCellTests.swift
//  InfosysAssignmentTests
//
//  Created by Jayachandra on 1/16/20.
//  Copyright © 2020 BlueRose Technologies Pvt Ltd. All rights reserved.
//

import XCTest
@testable import InfosysAssignment

class FactTableViewCellTests: XCTestCase {
    let cellId = "FactTableViewCell"
    var cell: FactTableViewCell!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cell = FactTableViewCell(style: .default, reuseIdentifier: cellId)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testInitializeUI() {
        cell.initializeUI()
        XCTAssert(cell.titleLabel != nil, "FactTableViewCell's sub views are not loaded")
    }

    func testSetData() {
        let expectation = self.expectation(description: "FactsAPIResponse")
        let urlPath = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        self.sendGetRequest(url: urlPath, mapTo: FactResponse.self) { (result) in
            switch result {
            case .error(let error):
                XCTFail(error.localizedDescription)
            case .success(let value):
                if let factResponse = value as? FactResponse, let firstObject = factResponse.rows.first {
                    let indexPath = IndexPath(row: 0, section: 0)
                    DispatchQueue.main.async {
                        self.cell.setData(fact: firstObject, at: indexPath)
                        XCTAssertEqual(self.cell.titleLabel.text, firstObject.title)
                    }
                    expectation.fulfill()
                } else {
                    XCTFail("Facts response is not a valid")
                }
            }
        }
        wait(for: [expectation], timeout: 30)
    }
}

extension FactTableViewCellTests: APIRestClient {}

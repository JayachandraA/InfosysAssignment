//
//  APIRestClientTests.swift
//  InfosysAssignmentTests
//
//  Created by Jayachandra on 12/16/19.
//  Copyright © 2019 BlueRose Technologies Pvt Ltd. All rights reserved.
//

import XCTest
@testable import InfosysAssignment
class APIRestClientTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSendGetRequest() {
        let expectation = self.expectation(description: "FactsAPIResponse")
        let urlPath = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        self.sendGetRequest(url: urlPath, mapTo: FactResponse.self) { (result) in
            switch result {
            case .error(let error):
                XCTFail(error.localizedDescription)
            case .success(let value):
                if let factResponse = value as? FactResponse {
                    print(factResponse.title)
                    expectation.fulfill()
                } else {
                    XCTFail("Facts response is not a valid")
                }
            }
        }
        wait(for: [expectation], timeout: 30)
    }

}

extension APIRestClientTests: APIRestClient {}

//
//  Fact.swift
//  InfosysAssignment
//
//  Created by Jayachandra on 12/13/19.
//  Copyright © 2019 BlueRose Technologies Pvt Ltd. All rights reserved.
//

import Foundation

/// `FactResponse` will be used to map the facts api response
struct FactResponse: Codable {
    let title: String
    let rows: [Fact]
}

struct Fact: Codable {
    let title: String?
    let description: String?
    let imageHref: String?
}

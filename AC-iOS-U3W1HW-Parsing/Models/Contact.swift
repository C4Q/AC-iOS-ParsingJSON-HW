//
//  File.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Contact: Codable {
    let results: [Results]
}

struct Results: Codable {
    let name: Name
    let location: Location
    let email: String
    let phone: String
    let picture: Picture
}

struct Name: Codable {
    let first: String
    let last: String
}

struct Location: Codable {
    let city: String
    let state: String
}

struct Picture: Codable {
    let large: String
}

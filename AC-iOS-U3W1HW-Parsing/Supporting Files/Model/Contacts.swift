//
//  Contacts.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct ContactInfo: Codable {
    var results: [Contacts]
}

struct Contacts: Codable {
    var name: Name
    var location: Location
    var email: String
    var picture: Picture
}
struct Name: Codable{
    var first: String
    var last: String
}

struct Location: Codable {
    var city: String
    var state: String
}

struct Picture: Codable {
    var medium: URL
}

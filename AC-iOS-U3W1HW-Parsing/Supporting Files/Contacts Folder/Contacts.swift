//
//  Contacts.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Ashlee Krammer on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Contacts: Codable {
    var results: [Person]
}


struct Person: Codable {
    var name: NameWrapper
    var location: locationWrapper
    var phone: String?
    var cell: String?
    var email: String?
    var picture: PictureWrapper

}

struct NameWrapper: Codable {
    var title: String
    var first: String
    var last: String
}

struct locationWrapper: Codable {
    var street: String
    var city: String
    var state: String
    var postcode: String
}

struct PictureWrapper: Codable {
    var large: String
}

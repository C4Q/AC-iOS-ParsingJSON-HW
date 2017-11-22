//
//  ContactList.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct ContactInfo: Codable {
    let results : [ResultsWrapper]
}

struct ResultsWrapper : Codable{
    let name: NameWrapper
    let location: Locations
    let picture: PictureWrapper
    let email: String
}

struct NameWrapper: Codable {
    var first: String
    var last: String
    var fullName: String {
        return "\(first.capitalized) \(last.capitalized)"
    }
}

struct PictureWrapper: Codable {
    let large: String
    let thumbnail: String
}

struct Locations: Codable {
    let city: String
}



//
//  User.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Lisa J on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct UserInfo: Codable {
    let results : [ResultsWrapper]
}

struct ResultsWrapper : Codable{
    let name: NameWrapper
    let location: Locations
    let picture: PictureWrapper
    let email: String
}
struct NameWrapper: Codable {
    var title: String
    var first: String
    var last: String
    var fullName: String {
        return first.capitalized + " " + last.capitalized
    }
}

struct Locations: Codable {
    let street: String
    let city: String
    let state:String
    let postcode: String
}
struct PictureWrapper: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}


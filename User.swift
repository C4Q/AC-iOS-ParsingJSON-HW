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
    let email: String
}
struct NameWrapper: Codable {
    var title: String
    var first: String
    var last: String
}

struct Locations: Codable {
    let street: String
    let city: String
    let state:String
    let postcode: String
}



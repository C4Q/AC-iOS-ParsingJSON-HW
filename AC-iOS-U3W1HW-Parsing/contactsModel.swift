//
//  contactsModel.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Richard Crichlow on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct contactTop: Codable {
    var results: [Person]
}

struct Person: Codable {
    var name: NameWrapper
    var location: LocationInfo
    let picture: PictureWrapper
    let email: String
    let phone: String
    let cell: String
}

struct NameWrapper: Codable {
    var title: String
    var first: String
    var last: String
}

struct LocationInfo: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
}

struct PictureWrapper: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}


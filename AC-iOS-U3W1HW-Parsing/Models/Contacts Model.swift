//
//  Contacts Model.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Maryann Yin on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct PersonResults: Codable {
    let results: [Person]
}

struct Person: Codable {
    let name: NameWrapper
    let location: LocationWrapper
    let picture: PictureWrapper
    let email: String
}

struct NameWrapper: Codable {
    let title: String
    let first: String
    let last: String
}

struct LocationWrapper: Codable {
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

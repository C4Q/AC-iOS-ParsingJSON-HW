//
//  Person.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct ResultsWrapper: Codable {
    let results: [Person]
}

struct Person: Codable {
    let name: Name
    let location: Location
    let email: String
    let dob: String
    let phone: String
    let cell: String
    let picture: Picture
}

struct Name: Codable {
    let first: String
    let last: String
}

struct Location: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
}

struct Picture: Codable {
    let large: String
    let medium: String
}


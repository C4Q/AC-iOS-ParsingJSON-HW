//
//  Contacts.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Clint Mejia on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct ContactInfo: Codable {
    let results: [Contact]
}

struct Contact: Codable {
    let name: FullName
    let location: Address
    let email: String
    let picture: ProfilePhoto
    let cell: String
    let dob: String
}

struct FullName: Codable {
    let first: String
    let last: String
}

struct Address: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
}

struct ProfilePhoto: Codable {
    let large: String
}





//
//  contactInfo.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct UserInfo: Codable {
    let results: [User]
}
struct User: Codable {
    let name: NameInfo
    let location: LocationInfo
    let email: String
    let dob: String
    let phone: String
    let cell: String
    let picture: ImageWraper
}
struct NameInfo: Codable {
    let first: String
    let last: String
}
struct LocationInfo: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
}
struct ImageWraper: Codable {
    let large: String?
    let medium: String?
}


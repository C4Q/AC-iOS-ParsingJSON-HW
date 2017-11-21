//
//  Contact.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Contact: Codable {
    let results: [resultsUnwrapped]
    let info: infoUnwrapped
}

struct resultsUnwrapped: Codable {
    let gender: String
    let name: nameUnwrapped
    let location: locationUnwrapped
    let email: String
    let login: loginUnwrapped
    let dob: String
    let registered: String
    let phone: String
    let cell: String
    let id: idUnwrapped
    let picture: pictureUnwrapped
    let nat: String
}

struct nameUnwrapped: Codable {
    let title: String
    let first: String
    let last: String
    var fullName: String {
        return ("\(first.capitalized) \(last.capitalized)")
    }
}

struct locationUnwrapped: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
}

struct loginUnwrapped: Codable {
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

struct idUnwrapped: Codable {
    let name: String
    let value: String?
}

struct pictureUnwrapped: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

struct infoUnwrapped: Codable {
    let seed: String
    let results: Int
    let page: Int
    let version: String
}

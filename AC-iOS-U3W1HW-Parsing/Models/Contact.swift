//
//  Contact.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Luis Calle on 11/15/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct ContactList: Codable {
    let results: [Contact]
}

struct Contact: Codable {
    let gender: String
    let name: NameWrapper
    let location: LocationWrapper
    let email: String
    let login: LoginWrapper
    let dob: String
    let registered: String
    let phone: String
    let cell: String
    let id: IDWrapper
    let picture: PictureWrapper
    let nat: String
    
    static func sortContacts(contactsArray: [Contact]) -> [Contact] {
        return contactsArray.sorted{$0.name.first < $1.name.first}
    }
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

struct LoginWrapper: Codable {
    let username: String
    let password: String
    let salt: String
    let md5: String
    let sha1: String
    let sha256: String
}

struct IDWrapper: Codable {
    let name: String
    let value: String
}

struct PictureWrapper: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

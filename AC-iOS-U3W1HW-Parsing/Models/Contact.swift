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
    let name: NameWrapper
    let location: LocationWrapper
    let email: String
    let cell: String
    let picture: PictureWrapper
    
    static func sortContacts(contactsArray: [Contact]) -> [Contact] {
        return contactsArray.sorted{$0.name.first < $1.name.first}
    }
}

struct NameWrapper: Codable {
    let first: String
    let last: String
}

struct LocationWrapper: Codable {
    let city: String
}

struct PictureWrapper: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

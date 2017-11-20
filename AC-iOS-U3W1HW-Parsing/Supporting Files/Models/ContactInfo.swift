//
//  ContactsInfo.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
///Codable

struct ContactInfo: Codable{
    let results: [Person]
}

struct Person: Codable{
    let name: NameWrapper
    let location: LocationWrapper
    let email: String
}

struct NameWrapper: Codable{
    let first: String
    let last: String
}

struct LocationWrapper: Codable{
    let city: String
    let state: String
}

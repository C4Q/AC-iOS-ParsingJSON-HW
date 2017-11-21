//
//  contactEntry.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation



struct ContactEntry: Codable{
    let results: [Person]
}

struct Person: Codable {
    let name: NameWrapper
    let location: LocationWrapper
    let email: String
    let dob: String
    let cell: String
    let picture: PictureWrapper
    
}

struct NameWrapper: Codable{
    let title: String
    let first: String
    let last: String
}

struct LocationWrapper: Codable{
    let street: String
    let city: String
    let state: String
    let postcode: String
}

struct PictureWrapper: Codable{
    let large: String
}

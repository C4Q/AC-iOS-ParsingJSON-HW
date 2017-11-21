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
    private let dob: String
    var birthday: String {
        enum Month: Int {
            case January = 01, February, March, April, May, June, July, August, September, October, November, December
        }
        let monthIndexSet: IndexSet = [5, 6]
        let dayIndexSet: IndexSet = [8, 9]
        let day = String(dayIndexSet.map { Array(dob)[$0] })
        let month = String(monthIndexSet.map { Array(dob)[$0] })
        return "\(Month.init(rawValue: Int(month)!)!) \(day)"
    }
}

struct FullName: Codable {
    private let first: String
    private let last: String
    var firstNameFormatted: String {
        return first.capitalized
    }
    var lastNameFormatted: String {
        return last.capitalized
    }
    var fullName: String {
        return firstNameFormatted + " " + lastNameFormatted
    }
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





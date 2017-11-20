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
        let monthIndexSet: IndexSet = [5, 6]
        let dayIndexSet: IndexSet = [8, 9]
        let day = String(dayIndexSet.map { Array(dob)[$0] })
        var month = String(monthIndexSet.map { Array(dob)[$0] })
        switch month {
        case "01":
            month = "January"
        case "02":
            month = "Febuary"
        case "03":
            month = "March"
        case "04":
            month = "April"
        case "05":
            month = "May"
        case "06":
            month = "June"
        case "07":
            month = "July"
        case "08":
            month = "August"
        case "09":
            month = "September"
        case "10":
            month = "October"
        case "11":
            month = "November"
        case "12":
            month = "December"
        default:
            break
        }
        return "\(month) \(day)"
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





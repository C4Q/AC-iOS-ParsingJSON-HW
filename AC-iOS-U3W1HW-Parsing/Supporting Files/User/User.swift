//
//  User.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Masai Young on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

struct UserAPIResponse: Codable {
    let info: Info
    let results: [User]
}

struct User: Codable {
    let cell: String
    let dob: String
    let email: String
    let gender: String
    let id: Id
    let location: Location
    let login: Login
    let name: Name
    let nat: String
    let phone: String
    let picture: Picture
    let registered: String
    
    var fullName: String {
        return name.first.capitalized + " " + name.last.capitalized
    }
    
    
    static func fetchUsers() -> UserAPIResponse? {
        
        var users: UserAPIResponse?
        
        guard let filePath = Bundle.main.path(forResource: "userinfo", ofType: "json") else { return nil }
        let myUrl = URL(fileURLWithPath: filePath)
        if let data = try? Data(contentsOf: myUrl) {
            do {
                users = try JSONDecoder().decode(UserAPIResponse.self, from: data)
            } catch {
                print(error)
            }
        }
        return users
    }
}

struct Picture: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

struct Name: Codable {
    let first: String
    let last: String
    let title: String
}

struct Login: Codable {
    let md5: String
    let password: String
    let salt: String
    let sha1: String
    let sha256: String
    let username: String
}

struct Location: Codable {
    let city: String
    let postcode: String
    let state: String
    let street: String
}

struct Id: Codable {
    let name: String
    let value: String
}

struct Info: Codable {
    let page: Int
    let results: Int
    let seed: String
    let version: String
}

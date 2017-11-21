//
//  ContactsData.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Reiaz Gafar on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Contact: Codable {
    
    var results: [Result]?
    
    
    
    static func populateContacts() -> Contact {
        var myContacts = Contact()
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                
                do {
                    myContacts = try myDecoder.decode(Contact.self, from: data)
                    
                } catch let error {
                    print(error)
                }
                
            }
        }
        return myContacts
    }
    
    
}

struct Result: Codable {
    var name: Name
    var location: Location
    var picture: Picture
    var email: String
}

struct Name: Codable {
    var first: String
    var last: String
}

struct Location: Codable {
    var city: String
}

struct Picture: Codable {
    var large: String
}

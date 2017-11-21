//
//  FormattedContact.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class FormattedContact {
    let fullName: String
//    let thumbnailUrlString: String
//    let largeUrlString: String
    let addressString: String
    let emailString: String
    let cellNumberString: String
    let homeNumberString: String
    let picture: Picture
    
    var firstLetter: String {
        let first = fullName.first ?? " "
        return String(first).uppercased()
    }
    
    init(fullName: String,
//         thumbnailUrlString: String,
//         largeUrlString: String,
         addressString: String,
         emailString: String,
         cellNumberString: String,
         homeNumberString: String,
         picture: Picture) {
        self.fullName = fullName
//        self.thumbnailUrlString = thumbnailUrlString
//        self.largeUrlString = largeUrlString
        self.addressString = addressString
        self.emailString = emailString
        self.cellNumberString = cellNumberString
        self.homeNumberString = homeNumberString
        self.picture = picture
    }
    
    convenience init(contact: Contact) {
        let fullName = contact.name.first.capitalized + " " + contact.name.last.capitalized
        let addressString = contact.location.street.capitalized + " " + contact.location.city.capitalized + " " + contact.location.state.capitalized + " " + contact.location.postcode
//        let thumbnailUrlString = picture.thumbnail
//        let largeUrlString = contact.picture.large
        let emailString = contact.email
        let cellNumberString = contact.cell
        let homeNumberString = contact.phone
        let pictureObject = contact.picture
        
        self.init(fullName: fullName,
//                  thumbnailUrlString: thumbnailUrlString,
//                  largeUrlString: largeUrlString,
                  addressString: addressString,
                  emailString: emailString,
                  cellNumberString: cellNumberString,
                  homeNumberString: homeNumberString,
                  picture: pictureObject)
    }
}


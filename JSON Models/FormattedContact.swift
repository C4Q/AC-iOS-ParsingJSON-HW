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
    let thumbnailUrlString: String
    let addressString: String
    
    init(fullName: String, thumbnailUrlString: String, addressString: String) {
        self.fullName = fullName
        self.thumbnailUrlString = thumbnailUrlString
        self.addressString = addressString
    }
    
    convenience init(contact: Contact) {
        let fullName = /* contact.name.title.capitalized + " " + */ contact.name.first.capitalized + " " + contact.name.last.capitalized
        
        let addressString = contact.location.street.capitalized + " " + contact.location.city.capitalized + " " + contact.location.state.capitalized + " " + contact.location.postcode
        
        self.init(fullName: fullName, thumbnailUrlString: contact.picture.thumbnail, addressString: addressString)
    }
}


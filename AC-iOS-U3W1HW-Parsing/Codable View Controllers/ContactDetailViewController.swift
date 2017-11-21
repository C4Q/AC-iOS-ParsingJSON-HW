//
//  ContactDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    
    var contact: Results? = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let contact = contact else {
            return
        }
        nameLabel.text = "\(contact.name.first.capitalized) \(contact.name.last.capitalized)"
        contactImage.image = #imageLiteral(resourceName: "profileImage")
        phoneLabel.text = "Phone: " + contact.phone
        locationLabel.text = "Location: \(contact.location.city.capitalized), \(contact.location.state.capitalized)"
        emailLabel.text = "Email: " + contact.email
    }
}

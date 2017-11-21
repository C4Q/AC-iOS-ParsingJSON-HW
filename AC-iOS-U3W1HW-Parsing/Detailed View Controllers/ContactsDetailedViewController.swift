//
//  ContactsDetailedViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Luis Calle on 11/15/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsDetailedViewController: UIViewController {

    var contact: Contact?
    
    @IBOutlet weak var contactProfilePicture: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactCellphoneLabel: UILabel!
    @IBOutlet weak var contactLocationLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let contact = contact else { return }
        guard let url = URL(string: contact.picture.large) else { return }
        do {
            let data = try Data(contentsOf: url)
            contactProfilePicture.image = UIImage(data: data)
        } catch let error {
            print(error)
        }
        contactNameLabel.text = "\(contact.name.first) \(contact.name.last)".capitalized
        contactCellphoneLabel.text = "Cellphone #: \(contact.cell)"
        contactLocationLabel.text = "Location: \(contact.location.city.capitalized)"
        contactEmailLabel.text = "e-mail: \(contact.email)"
    }
    
}

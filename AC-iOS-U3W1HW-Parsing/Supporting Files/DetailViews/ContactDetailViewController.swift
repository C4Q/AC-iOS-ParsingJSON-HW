//
//  ContactDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    var selectedContact: Contact?
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    func updateData() {
        if let contact = selectedContact {
            nameLabel.text = "\(contact.name.first.capitalized) \(contact.name.last.capitalized)"
            emailLabel.text = contact.email
            locationLabel.text = "\(contact.location.city.capitalized), \(contact.location.state.capitalized)"
            if let pictureURL = URL(string: contact.picture.medium) {
                DispatchQueue.global().sync {
                    if let data = try? Data.init(contentsOf: pictureURL) {
                        DispatchQueue.main.async {
                            self.contactImage.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
    
}

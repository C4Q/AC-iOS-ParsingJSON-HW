//
//  ContactsDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsDetailViewController: UIViewController {
    
    var selectedContact: Contacts!
    
    @IBOutlet weak var ContactImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var location: UILabel!
    override func viewDidLoad() {
        updateDetail()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func updateDetail() {
        guard let selectedContact = selectedContact else {
            return
        }
        if let pictureURL = URL(string: selectedContact.picture.medium) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: pictureURL) {
                    DispatchQueue.main.async {
                        self.ContactImage.image = UIImage(data: data)
                    }
                }
            }
        }
//        ContactImage.image = #imageLiteral(resourceName: "profileImage")
        nameLabel.text = selectedContact.name.first + " " + selectedContact.name.last
        email.text = selectedContact.email
        location.text = selectedContact.location.city
    
}
    
}

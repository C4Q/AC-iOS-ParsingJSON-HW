//
//  UserDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    var myContacts: ResultsWrapper!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        nameLabel.text = "Full name: \(myContacts.name.fullName)"
        locationLabel.text = "Location: \(myContacts.location.city.capitalized)"
        emailLabel.text = "E-mail: \(myContacts.email.capitalized)"
    
        if let url = URL(string: myContacts.picture.large) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.profileImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}


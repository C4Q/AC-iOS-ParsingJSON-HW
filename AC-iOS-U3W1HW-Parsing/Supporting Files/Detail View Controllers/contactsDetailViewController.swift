//
//  contactsDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class contactsDetailViewController: UIViewController {

    @IBOutlet weak var contactImage: UIImageView!
    var contact: Person?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fullName = (contact?.name.title.capitalized)! + " " + (contact?.name.first.capitalized)! + " " + (contact?.name.last.capitalized)!
        nameLabel.text = fullName
        phoneLabel.text = "Cellphone: " + (contact?.cell)!
        emailLabel.text = "Email: " + (contact?.email)!
        dobLabel.text = "D.O.B: " + (contact?.dob)!
        
        if let pictureURL = URL(string: (contact?.picture.large)!) {
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

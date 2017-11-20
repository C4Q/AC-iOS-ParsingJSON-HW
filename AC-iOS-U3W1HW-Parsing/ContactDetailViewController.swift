//
//  ContactDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    var myContact: Person?
    

    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    func loadDetailData() {
        if let pictureURL = URL(string: myContact!.picture.large) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: pictureURL) {
                    DispatchQueue.main.async {
                        self.contactImage.image = UIImage(data: data)
                    }
                }
            }
        }
        guard let myContact = myContact else {
            return
        }
        nameLabel.text = myContact.name.first.capitalized + " " + myContact.name.last.capitalized
        emailLabel.text = myContact.email
        locationLabel.text = myContact.location.city
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetailData()

        // Do any additional setup after loading the view.
    }


}

//
//  ContactsDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Maryann Yin on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsDetailViewController: UIViewController {
    
    var peopleContact: Person?
    
    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet weak var contactNames: UILabel!
    
    @IBOutlet weak var contactEmail: UILabel!
    
    @IBOutlet weak var contactLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pictureURL = URL(string: peopleContact!.picture.large) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: pictureURL) {
                    DispatchQueue.main.async {
                        self.contactImage.image = UIImage(data: data)
                    }
                }
            }
        }
        contactNames.text = peopleContact!.name.first.capitalized + " " + peopleContact!.name.last.capitalized
        contactEmail.text = peopleContact!.email
        contactLocation.text = peopleContact!.location.city.capitalized
    }
    
}

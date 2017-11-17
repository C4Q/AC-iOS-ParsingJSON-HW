//  ContactsDVC.swift
//  sU3W1HW-Parsing
//  Created by Winston Maragh on 11/16/17.
//  Copyright © 2017 Winston Maragh. All rights reserved.

import UIKit

class ContactsDVC: UIViewController {

	@IBOutlet weak var fullnameLabel: UILabel!
	@IBOutlet weak var addressLabel: UILabel!
	@IBOutlet weak var cityStateLabel: UILabel!
	@IBOutlet weak var phoneNumberLabel: UILabel!
	@IBOutlet weak var emailLabel: UILabel!
	@IBOutlet weak var personImageView: UIImageView!
	
	var contact: Contact!

    override func viewDidLoad() {
		super.viewDidLoad()
		loadData()
    }

	func loadData() {
		fullnameLabel.text = "\(contact.name.first) \(contact.name.last)"
		addressLabel.text =  contact.location.street
		cityStateLabel.text = "\(contact.location.city) \(contact.location.state)"
		phoneNumberLabel.text = contact.phone
		emailLabel.text = contact.email
		
		//set image
		if let url = URL(string: contact.picture.large) {
			personImageView.contentMode = .scaleAspectFit
			//doing work on a background thread - to avoid crashing the phone
			DispatchQueue.global().sync {
				if let data = try? Data.init(contentsOf: url) {
					//go back to main thread to update UI
					DispatchQueue.main.async {
						self.personImageView.image = UIImage(data: data)
					}
				}
			}
		}
	}

}

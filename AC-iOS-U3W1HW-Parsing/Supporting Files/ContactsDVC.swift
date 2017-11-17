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
//		personImageView.downloadedFrom(link: contact.picture.large)
//		personImageView.image
//		imageView.downloadedFrom(link: contact.picture.large)
		/*
		if let url = URL(string: contact.picture.large) {
			personImageView.contentMode = .scaleAspectFit
			downloadImage(url: url)
		}
		*/

	}


}

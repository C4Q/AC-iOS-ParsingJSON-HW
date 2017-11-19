//
//  contactDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Clint Mejia on 11/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class contactDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet var contactLabels: [UILabel]!
    
    var selectedContact: Contact? = nil
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()

    }
    
    // MARK: - Functions
    func setupInitialView() {
        guard let selectedContact = selectedContact else { return }
        if let url = URL(string: selectedContact.picture.large) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.contactImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        for label in contactLabels {
            switch label.tag {
            case 0:
                label.text = "First: \(selectedContact.name.firstNameFormatted)"
            case 1:
                label.text = "Last: \(selectedContact.name.lastNameFormatted)"
            case 2:
                label.text = "Cell: \(selectedContact.cell)"
            case 3:
                label.text = "E-mail: \(selectedContact.email)"
            case 4:
                label.text = "Birthday: \(selectedContact.birthday)"
            case 5:
                label.text = "Street: \(selectedContact.location.street)"
            case 6:
                label.text = "City: \(selectedContact.location.city)"
            case 7:
                label.text = "State: \(selectedContact.location.state)"
            case 8:
                label.text = "Postcode: \(selectedContact.location.postcode)"
            default:
                break
            }
        }
    }

}




/*
struct Contact: Codable {
    let name: FullName
    let location: Address
    let email: String
    let picture: ProfilePhoto
    let cell: String
    let dob: String
}

struct FullName: Codable {
    let first: String
    let last: String
}

struct Address: Codable {
    let street: String
    let city: String
    let state: String
    let postcode: String
}

struct ProfilePhoto: Codable {
    let medium: String
}
*/

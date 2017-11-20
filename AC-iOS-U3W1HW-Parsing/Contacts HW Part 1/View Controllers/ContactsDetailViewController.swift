//
//  ContactsDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsDetailViewController: UIViewController {

    @IBOutlet weak var nameNavigationItem: UINavigationItem!
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        nameNavigationItem.title = (person.name.first + " " + person.name.last).capitalized
        let address = [person.location.street, person.location.city, person.location.state, person.location.postcode]
        addressLabel.text = address.joined(separator: ", ").capitalized
        phoneLabel.text = person.phone
        cellLabel.text = person.cell
        let dob = person.dob.components(separatedBy: " ")[0]
        let birthday = dob.components(separatedBy: "-")[1...2].joined(separator: "-")
        birthdayLabel.text = birthday
        emailLabel.text = person.email
        
        setupImages()
    }
    
    func setupImages() {
        let apiManager = APIManager()
        let imageEndpoint = person.picture.large
        
        //placeholder until data loads
        contactImageView.image = #imageLiteral(resourceName: "profileImage")
        
        apiManager.getData(endpoint: imageEndpoint) { (data: Data?) in
            guard let data = data else {
                print("Error: couldn't load data")
                return
            }
            
            guard let image = UIImage(data: data) else {
                print("Error: couldn't make image from data")
                return
            }
            
            DispatchQueue.main.async {
                self.contactImageView.image = image
            }
        }
    }
}

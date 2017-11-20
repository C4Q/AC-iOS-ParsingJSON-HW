//
//  DetailContactsViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailContactsViewController: UIViewController {
    //set-up outlets
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    //set instance of the model
    var contacts: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpUI()
    }

    func setUpUI(){
        //make sure there is a contact available
        guard let contacts = contacts else {return}
        navigationItem.title = "\(contacts.name.first.capitalized + " " + contacts.name.last.capitalized)"
        nameLabel.text = "Name: \(contacts.name.first.capitalized + " " + contacts.name.last.capitalized)"
        emailLabel.text = "E-mail: \(contacts.email)"
        locationLabel.text = "City: \(contacts.location.city.capitalized)"
        phoneLabel.text = "Cell: \(contacts.cell)"
        
        //setting up image from the internet
        if let pictureURL = URL(string: contacts.picture.large){
            DispatchQueue.global().sync{
                if let data = try? Data.init(contentsOf: pictureURL)  {
                    DispatchQueue.main.async {
                        self.personImageView?.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}

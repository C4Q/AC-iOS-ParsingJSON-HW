//
//  ContactDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {

    var contact: resultsUnwrapped!
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var lblEMail: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContactData()
        
    }
    
    func loadContactData() {
        lblFullName.text = contact.name.fullName
        lblEMail.text = contact.email
        lblCity.text = contact.location.city
        getImage()
    }
    
    func getImage(){
        let apiManager = APIManager()
        apiManager.getData(endpoint: contact.picture.medium) { (data: Data?) in
            if let myData = data{
                DispatchQueue.main.async {
                    self.imgPicture.image = UIImage(data: myData)
                }
            }
        }
    }

    
}

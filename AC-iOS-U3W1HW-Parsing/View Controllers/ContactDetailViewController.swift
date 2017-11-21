//
//  ContactDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Reiaz Gafar on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    //var contact = Result.init(name: Name.init(first: "", last: ""), location: Location.init(city: ""), picture: Picture.init(large: ""), email: "")
    
    var contact: Result?
    
    
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    @IBOutlet weak var contactLocationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let contact = contact else { return }

        contactImageView.image = #imageLiteral(resourceName: "profileImage")
        contactNameLabel.text = contact.name.first.capitalized + " " + contact.name.last.capitalized
        contactEmailLabel.text = contact.email
        contactLocationLabel.text = contact.location.city.capitalized

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

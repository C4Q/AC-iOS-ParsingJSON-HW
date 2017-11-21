//
//  DetailContactViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailContactViewController: UIViewController {
    var user: User?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let theUser = user {
            self.nameLabel.text = theUser.name.first.capitalized + " " + theUser.name.last.capitalized
            self.emailLabel.text = theUser.email
            self.cellLabel.text = theUser.cell
            let location = theUser.location
            self.addressLabel.text = location.street + " " + location.city + " " + location.state + ", " + location.postcode
            
            guard let theImage = theUser.picture.large else {self.imageView.image = #imageLiteral(resourceName: "profileImage")
                return
            }
            
        if let imageUrl = URL(string: theImage ) {
            if let imageData = try? Data(contentsOf: imageUrl) {
//        DispatchQueue.global().async {
            self.imageView.image = UIImage(data: imageData)
//        }
        }
            }
        // Do any additional setup after loading the view.
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}

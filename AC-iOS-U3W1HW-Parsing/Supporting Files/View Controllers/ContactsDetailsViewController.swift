//
//  ContactsDetailsViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/15/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cellNumberLabel: UILabel!
    @IBOutlet weak var houseNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

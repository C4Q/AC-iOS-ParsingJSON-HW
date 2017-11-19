//
//  ContactsDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsDetailViewController: UIViewController {
    
    var selectedContact: Contacts!
    
    @IBOutlet weak var ContactImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var location: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func setUpUI() {
//        navigationItem.title =
//        
//  
//}
    
}

//
//  UserDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Masai Young on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

class UserDetailViewController: UIViewController {
    
    var singleUser: User?
    var userImage: UIImage?
    
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var DOBLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels(with: singleUser)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureLabels(with: User?) {
        guard let singleUser = singleUser else { return }
        nameLabel.text = singleUser.fullName
        userProfileImage.image = userImage
//        DOBLabel.text = singleUser.dob
//        usernameLabel.text = singleUser.login.username
        emailLabel.text = singleUser.email
        cellLabel.text = singleUser.cell
        locationLabel.text = singleUser.location.street

    }
}

//
//  UserDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Lisa J on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    var userDetail: ResultsWrapper!
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        nameLabel.text = userDetail?.name.fullName
        locationLabel.text = "\(userDetail.location.city.capitalized)"
        emailLabel.text = "\(userDetail.email.capitalized)"
        //gets picture
        if let url = URL(string: userDetail.picture.large) {
            DispatchQueue.global().sync {
                //loading async
                if let data = try? Data.init(contentsOf: url) {
                    //updates UI on main thread
                    DispatchQueue.main.async {
                        self.pictureView.image = UIImage(data: data)
                    }
                    
                }
            }
        }
    }
}



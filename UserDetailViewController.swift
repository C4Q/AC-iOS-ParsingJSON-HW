//
//  UserDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Lisa J on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    var userDetail: ResultsWrapper?
   
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
    func setupUI() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    //outerwrapper
                    let userDetail = try myDecoder.decode(ResultsWrapper.self, from: data)
                    //inner wrapper
                    nameLabel.text = "\(userDetail.name.first.capitalized) \(userDetail.name.last.capitalized)"
                } catch {
                    print(error)
                }
            }
        }
    }
}



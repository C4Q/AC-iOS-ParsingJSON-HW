//
//  DetailedContactsViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Richard Crichlow on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailedContactsViewController: UIViewController {

    var aContact: Person?
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var labelOne: UILabel!
    
    @IBOutlet weak var labelTwo: UILabel!
    
    @IBOutlet weak var labelThree: UILabel!
    
    @IBOutlet weak var labelFour: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetailData()
        
        // Do any additional setup after loading the view.
    }
    
    func loadDetailData() {
        if let pictureURL = URL(string: aContact!.picture.large) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: pictureURL) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
        guard let aContact = aContact else {
            return
        }
        labelOne.text = aContact.name.first.capitalized + " " + aContact.name.last.capitalized
        labelTwo.text = aContact.email
        labelThree.text = aContact.location.city
        labelFour.text = "Phone: \(aContact.phone) - Cell: \(aContact.cell)"
    }
    

    

}

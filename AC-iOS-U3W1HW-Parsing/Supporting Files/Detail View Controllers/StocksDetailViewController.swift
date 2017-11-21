//
//  StocksDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksDetailViewController: UIViewController {

    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    var stock: Stock?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = stock?.date
        openLabel.text = "Open: $" + (stock?.open.description)!
        closeLabel.text = "Close: $" + (stock?.close.description)!
        
        if (stock?.close)! > (stock?.open)!{
            view.backgroundColor = UIColor.green
            stockImage.image =  #imageLiteral(resourceName: "thumbsUp")
        }else{
            view.backgroundColor = UIColor.red
            stockImage.image = #imageLiteral(resourceName: "thumbsDown")
        }
    }

    
    
    
    
}

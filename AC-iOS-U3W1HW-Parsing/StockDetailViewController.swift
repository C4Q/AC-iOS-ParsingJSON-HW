//
//  StockDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {

    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var openLabel: UILabel!
    
    @IBOutlet weak var closeLabel: UILabel!
    
    @IBOutlet weak var stockImage: UIImageView!
    
    var todaysStock: Stock?
    func setImageAndBackground() {
        guard let todaysStock = todaysStock else {
            return
        }
        if todaysStock.close > todaysStock.open {
            stockImage.image = #imageLiteral(resourceName: "thumbsUp")
            view.backgroundColor = UIColor.green
        }
        else if todaysStock.close < todaysStock.open {
            stockImage.image = #imageLiteral(resourceName: "thumbsDown")
            view.backgroundColor = UIColor.red
        }
        dateLabel.text = todaysStock.date
        openLabel.text = "open:" + " " + todaysStock.open.description
        closeLabel.text = "close:" + " " + todaysStock.close.description
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageAndBackground()
        

        // Do any additional setup after loading the view.
    }

}


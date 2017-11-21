//
//  DetailedStockViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Richard Crichlow on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailedStockViewController: UIViewController {

    @IBOutlet weak var labelOne: UILabel!
    
    @IBOutlet weak var labelTwo: UILabel!
    
    @IBOutlet weak var labelThree: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var stock: Stock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let stock = stock else {
            return
        }
        
        labelOne.text = stock.date
        labelTwo.text = "Opening: \(stock.open)"
        labelThree.text = "Closing: \(stock.close)"
        
        if stock.change > 0 {
            imageView.image = #imageLiteral(resourceName: "thumbsUp")
            view.backgroundColor = UIColor.green
        } else {
            imageView.image = #imageLiteral(resourceName: "thumbsDown")
            view.backgroundColor = UIColor.red
        }

        
    }

    

}

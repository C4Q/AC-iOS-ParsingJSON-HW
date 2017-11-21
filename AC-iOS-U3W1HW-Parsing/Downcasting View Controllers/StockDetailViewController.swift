//
//  StockDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var stockImage: UIImageView!
    
    @IBOutlet weak var openLabel: UILabel!
    
    @IBOutlet weak var closeLabel: UILabel!
    
    
    
    var stock: Stock? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let stock = stock else {
            return
        }
        dateLabel.text = stock.date
        openLabel.text = "Open: $\((describing: stock.open!))"
        closeLabel.text = "Close: $\((describing: stock.close!))"
        if stock.close! < stock.open! {
            stockImage.image = #imageLiteral(resourceName: "thumbsDown")
            view.backgroundColor = UIColor.red
        }
        if stock.close! > stock.open! {
            stockImage.image = #imageLiteral(resourceName: "thumbsUp")
            view.backgroundColor = UIColor.green
        }
        
    }



}

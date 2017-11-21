//
//  ApplStockDetailedViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Luis Calle on 11/15/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ApplStockDetailedViewController: UIViewController {
    
    var stock: ApplStock?
    @IBOutlet weak var stockDateLabel: UILabel!
    @IBOutlet weak var stockResultImage: UIImageView!
    @IBOutlet weak var stockOpenValueLabel: UILabel!
    @IBOutlet weak var stockCloseValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let stock = stock else {
            return
        }
        stockDateLabel.text = "\(stock.date)"
        if stock.open < stock.close {
            self.view.backgroundColor = UIColor.green
            stockResultImage.image = UIImage(named: "thumbsUp")
        } else {
            self.view.backgroundColor = UIColor.red
            stockResultImage.image = UIImage(named: "thumbsDown")
        }
        stockOpenValueLabel.text = "Open: $\(stock.open)"
        stockCloseValueLabel.text = "Close: $\(stock.close)"
    }

}

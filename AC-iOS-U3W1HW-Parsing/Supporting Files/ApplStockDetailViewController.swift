//
//  ApplStockDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ApplStockDetailViewController: UIViewController {
    
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var myStocks: APPLStockInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        navigationItem.title = myStocks.date
        openLabel.text = "Open: $\((myStocks.open))"
        closeLabel.text = "Close: $\((myStocks.close))"

        if myStocks.close > myStocks.open {
            imageView.image = UIImage(named: "thumbsUp")
            //thumbs up image
            self.view.backgroundColor = UIColor.green
        }
        if myStocks.close < myStocks.open {
            imageView.image = UIImage(named: "thumbsDown")
            //thumbs down image
            self.view.backgroundColor = UIColor.red
        }
    }
}


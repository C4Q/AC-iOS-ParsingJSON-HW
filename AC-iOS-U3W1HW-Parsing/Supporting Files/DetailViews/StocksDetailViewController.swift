//
//  StocksDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksDetailViewController: UIViewController {

    var selectedStock: Stocks?
    
    @IBOutlet weak var stockImage: UIImageView!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }

    func updateData() {
        guard let stock = selectedStock else {
            return
        }
        openLabel.text = "\(stock.open)"
        closeLabel.text = "\(stock.close)"
        dateLabel.text = "\(stock.date)"
        if stock.close > stock.open {
            stockImage.image = #imageLiteral(resourceName: "thumbsUp")
            self.view.backgroundColor = .green
        } else {
            stockImage.image = #imageLiteral(resourceName: "thumbsDown")
            self.view.backgroundColor = .red
        }
    }
}

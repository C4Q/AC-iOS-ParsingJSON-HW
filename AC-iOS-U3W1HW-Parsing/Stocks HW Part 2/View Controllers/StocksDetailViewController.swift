//
//  StocksDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksDetailViewController: UIViewController {

    @IBOutlet weak var dateNavigationItem: UINavigationItem!
    @IBOutlet weak var stockImageView: UIImageView!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    
    var stock: Stock!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        dateNavigationItem.title = stock.date
        
        let gain = stock.change > 0
        
        if gain {
            self.view.backgroundColor = UIColor.green
            stockImageView.image = #imageLiteral(resourceName: "thumbsUp")
        } else {
            self.view.backgroundColor = UIColor.red
            stockImageView.image = #imageLiteral(resourceName: "thumbsDown")
        }
        
        openLabel.text = stock.open.description
        closeLabel.text = stock.close.description
    }

}

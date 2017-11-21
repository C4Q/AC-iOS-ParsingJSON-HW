//
//  StocksDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Maryann Yin on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksDetailViewController: UIViewController {
    
    var stockNums: StockInfo!
    
    @IBOutlet weak var thumbsUpOrDownImage: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var openLabel: UILabel!
    
    @IBOutlet weak var closeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
    }

}

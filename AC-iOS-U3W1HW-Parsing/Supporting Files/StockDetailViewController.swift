//
//  StockDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Lisa J on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    var stockDetail: Stock!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }

    func setupUI() {
        openLabel.text = "\(stockDetail?.open ?? 0)"
        print(openLabel.text)
    }
}

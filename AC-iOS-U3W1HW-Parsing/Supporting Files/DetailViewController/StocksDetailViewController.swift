//
//  StocksDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksDetailViewController: UIViewController {
    
    var stocks: Stock?
    
    @IBOutlet weak var close: UILabel!
    
    @IBOutlet weak var open: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var date: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDetail()
        
    }
    
    func updateDetail() {
        guard let stocks = stocks else {
            return
        }
        date.text = stocks.date
       open.text = stocks.open.description
        close.text = stocks.close.description
        if stocks.open < stocks.close {
            image.image = #imageLiteral(resourceName: "thumbsUp")
            view.backgroundColor = .green
        }
        else {
            image.image = #imageLiteral(resourceName: "thumbsDown")
            view.backgroundColor = .red
    
    }
    
}
}

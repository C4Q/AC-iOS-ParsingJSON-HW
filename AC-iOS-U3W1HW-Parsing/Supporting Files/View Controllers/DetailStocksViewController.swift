//
//  DetailStocksViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailStocksViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
    
    var stocks: StockInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI(){
        guard let stocks = stocks else {return}
        navigationItem.title = "Daily Stock Profile"
        dateLabel.text = "Date: \(String(describing: stocks.date!))"
        openLabel.text = "Opening: $\(String(describing: stocks.openingAmount))"
        closeLabel.text = "Closing: $\(String(describing: stocks.closingAmount))"
        
        //check if closing is less than or greater than opening value
        if stocks.closingAmount > stocks.openingAmount {
            view.backgroundColor = UIColor.green
            resultImageView.image = UIImage(imageLiteralResourceName: "thumbsUp")
            
        } else {
            view.backgroundColor = UIColor.red
            resultImageView.image = UIImage(imageLiteralResourceName: "thumbsDown")
        }
        
    }
}

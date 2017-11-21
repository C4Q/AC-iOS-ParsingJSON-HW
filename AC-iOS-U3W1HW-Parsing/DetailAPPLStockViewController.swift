//
//  DetailAPPLStockViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailAPPLStockViewController: UIViewController {
    var stock: AppleStockInfo?
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let theStock = stock else {return}
        self.dateLabel.text = "Date: \(theStock.date)"
        self.openLabel.text = "Open: \(theStock.open.description)"
        self.closeLabel.text = "Close: \(theStock.close.description)"
        if theStock.close > theStock.open {
            imageView.image = #imageLiteral(resourceName: "thumbsUp")
            self.view.backgroundColor = .green
        } else {
            imageView.image = #imageLiteral(resourceName: "thumbsDown")
            self.view.backgroundColor = .red
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}

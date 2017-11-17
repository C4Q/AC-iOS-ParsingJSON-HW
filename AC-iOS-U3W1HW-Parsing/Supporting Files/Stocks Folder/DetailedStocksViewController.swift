//
//  DetailedStocksViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Ashlee Krammer on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailedStocksViewController: UIViewController {

    var stocks: Stocks?
    
    //Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadData()
        loadImage()
        
    }

    
    
    
    func uploadData() {
        dateLabel.text = "Date: " + (stocks?.date)!
        openLabel.text = "Open: $" + (stocks?.open.description)!
        closeLabel.text = "Close: $" + (stocks?.close.description)!
    }
    
    func loadImage(){

        let close = Double((stocks?.close)!)
        let open = Double((stocks?.open)!)

        if close > open {
            image.image = #imageLiteral(resourceName: "up")
        } else {
            image.image = #imageLiteral(resourceName: "down")
        }
    }

}


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
    
    var atClosing = ""
    var difference = 0.0
    var alertMessage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadData()
        loadImage()
        popUp()
    
    }

    
    
    
    func uploadData() {
        dateLabel.text = "Date: " + (stocks?.date)!
        openLabel.text = "Open: $" + (stocks?.open.description)!
        closeLabel.text = "Close: $" + (stocks?.close.description)!
        alertMessage = "Date: " + (stocks?.date)!
    }
    
    

    
    func loadImage(){

        let close = Double((stocks?.close)!)

        
        let open = Double((stocks?.open)!)

        
        if close > open {
            image.image = #imageLiteral(resourceName: "up")
            atClosing = "increased"
            difference = close - open
            closeLabel.textColor = .green
            
        } else {
            image.image = #imageLiteral(resourceName: "down")
            atClosing = "decreased"
            difference = open - close
            closeLabel.textColor = .red
        }
    }

    
    func popUp() {
        let message = "Stock \(atClosing) by $\(difference)"
        let alert: UIAlertController = UIAlertController(title: alertMessage, message: message, preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "View Stock", style: .cancel, handler: {action in

        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}


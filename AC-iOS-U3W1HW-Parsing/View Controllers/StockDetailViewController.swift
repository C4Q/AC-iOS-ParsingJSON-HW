//
//  StockDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {

    var stockDetail: Stock!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgPicture: UIImageView!
    @IBOutlet weak var lblOpen: UILabel!
    @IBOutlet weak var lblClose: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        loadLabels()
    }

    func loadLabels(){
        lblDate.text = stockDetail.date
        if stockDetail.isPriceWentUp {
            imgPicture.image = #imageLiteral(resourceName: "thumbsUp")
            self.view.backgroundColor = .green
        } else {
            imgPicture.image = #imageLiteral(resourceName: "thumbsDown")
            self.view.backgroundColor = .red
        }
        lblOpen.text = "Open: \(stockDetail.open)"
        lblClose.text = "Close: \(stockDetail.close)"
    }

}

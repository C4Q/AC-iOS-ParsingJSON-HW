//
//  DetailStockViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Masai Young on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

class DetailStockViewController: UIViewController {
    
    var singleStockStat: Stock?
    
    @IBOutlet weak var closingLabel: UILabel!
    @IBOutlet weak var openingLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stockImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels(with: singleStockStat)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureLabels(with: Stock?) {
        guard let singleStockStat = singleStockStat else { return }
        dateLabel.text = "\(singleStockStat.standaloneMonth) \(singleStockStat.ordinalNumber)"
        openingLabel.text = String(singleStockStat.open)
        closingLabel.text = String(singleStockStat.close)
        stockImageView.image = singleStockStat.mainImage()
    
    }
}


//
//  StocksViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {

    var stocks = [Stock]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStockData()
   
    }
    func loadStockData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let stocks = Stock.getStock(from: data)
                self.stocks = stocks
            }
        }
        for stock in stocks {
            print(stock.date)
        }
    }


}

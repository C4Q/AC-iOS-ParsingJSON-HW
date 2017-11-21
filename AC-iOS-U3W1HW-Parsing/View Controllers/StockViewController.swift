//
//  StockViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StockViewController: UIViewController {

    var stocks: [Stock] = []
    var handlingSection = [String]()
    
    @IBOutlet weak var stockTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stockTableView.delegate = self
        self.stockTableView.dataSource = self
        loadStockData()
    }

    func loadStockData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let stockData = try? Data(contentsOf: myURL) {
                self.stocks = Stock.getDataStock(from: stockData)!
            }
        }
        var index = 0
        for stock in self.stocks {
            let yearMonth = stock.dateFormat.yearMonth
            if !handlingSection.contains(yearMonth) {
                handlingSection.append(yearMonth)
                index += 1
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let stockDetail = stocks[stockTableView.indexPathForSelectedRow!.row]
        let stockVCD = segue.destination as? StockDetailViewController
        stockVCD?.stockDetail = stockDetail
    }
}



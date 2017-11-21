//
//  StocksViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Maryann Yin on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var stocks: [StockInfo] = []
    
    @IBOutlet weak var stocksTableView: UITableView!
    
    var sectionsByMonth: [(key: String, value: [StockInfo])] = []
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                self.stocks = StockInfo.getStocks(from: data)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stockNumbers = stocks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stocks Table", for: indexPath)
        cell.textLabel?.text = stockNumbers.date
        cell.detailTextLabel?.text = String(stockNumbers.open)
        return cell
    }
    
    func stocksInSection(_ section: Int) -> [(key: String, value: [StockInfo])] {
        let stockSectionDictArr: [(key: String, value: [StockInfo])] = Array(StockInfo.stockDict(allStocks: stocks))
        sectionsByMonth = stockSectionDictArr
        return sectionsByMonth
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsByMonth.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        stocksTableView.delegate = self
        stocksTableView.dataSource = self
        self.sectionsByMonth = StockInfo.stockDict(allStocks: stocks)
    }
}

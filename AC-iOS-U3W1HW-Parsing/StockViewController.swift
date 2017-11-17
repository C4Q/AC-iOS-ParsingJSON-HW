//
//  StockViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Richard Crichlow on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var stockArr: [Stock] = []
    
    var sectionNames = [String]()
    
    func stockThatMonth(_ section: Int) -> [Stock] {
        return stockArr.filter { $0.sectionNameNeedAverage == sectionNames[section]}
    }
    
    func getSectionNames() {
        for stocks in stockArr {
            if !sectionNames.contains(stocks.sectionNameNeedAverage) {
                sectionNames.append(stocks.sectionNameNeedAverage)
            }
        }
        print(sectionNames)
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadData()
        getSectionNames()
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                if let nonOptionalStock = Stock.getStock(from: data) {
                    self.stockArr = nonOptionalStock
                }
            }
        }
        else {return}
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let theNameOfThisSection = sectionNames[section]
        let stocksInThisSection = stockArr.filter {$0.sectionNameNeedAverage == theNameOfThisSection}
        var total = 0.0
        
        for stock in stocksInThisSection {
            total += stock.open
        }
        let average = total / Double(stocksInThisSection.count)
        
        return sectionNames[section] + " - Average Open: \(String(format:"%.2f", average))"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let theNameOfThisSection = sectionNames[section]
        let stocksInThisSection = stockArr.filter {$0.sectionNameNeedAverage == theNameOfThisSection}
        return stocksInThisSection.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)

        let theNameOfThisSection = sectionNames[indexPath.section]
        let stocksInThisSection = stockArr.filter {$0.sectionNameNeedAverage == theNameOfThisSection}
        
        let oneDayOfStock = stocksInThisSection[indexPath.row]
        
        cell.textLabel?.text = oneDayOfStock.date
        cell.detailTextLabel?.text = "Open: \(oneDayOfStock.open) - Change: \(oneDayOfStock.change)"
        
        return cell
    }
    
}

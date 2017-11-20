//
//  StockListViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Lisa J on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StockListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var stocks = [Stock]()
    //var sortedStocks: [Stock] {return stocks.sorted {$0.date < $1.date}}
    var sectionNamesArr = [String]()
    
    func stockThatMonth(_ section: Int) -> [Stock] {
        
        return stocks.filter { $0.sectionNames == sectionNamesArr[section]}
    }
    @IBOutlet weak var tableView: UITableView!
    
    
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                self.stocks = Stock.getStock(from: data)
            }
        }
    }
    func getSectionNames() {
        for stocks in stocks {
            if !sectionNamesArr.contains(stocks.sectionNames) {
                sectionNamesArr.append(stocks.sectionNames)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
        getSectionNames()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let thesectionNames = sectionNamesArr[section]
        let stockSections = stocks.filter{$0.sectionNames == thesectionNames}
        return stockSections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //displays sorted stocks in tableview^
        let thesectionNames = sectionNamesArr[indexPath.section]
        let stockSections = stocks.filter{$0.sectionNames == thesectionNames}
        let stock = stockSections[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stock cell", for: indexPath)
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = "\(stock.open)"
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNamesArr.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let thesectionNames = sectionNamesArr[section]
        let stockSections = stocks.filter{$0.sectionNames == thesectionNames}
        var total = 0.0
        for stock in stockSections {
            total += stock.open
        }
        let stockAvg = total/Double(stockSections.count)
        let roundedStockAvg = round((stockAvg * 100))/100
//        https://stackoverflow.com/questions/27338573/rounding-a-double-value-to-x-number-of-decimal-places-in-swift
        return sectionNamesArr[section] + " Average : \(roundedStockAvg)"
        
    }
    
 
}

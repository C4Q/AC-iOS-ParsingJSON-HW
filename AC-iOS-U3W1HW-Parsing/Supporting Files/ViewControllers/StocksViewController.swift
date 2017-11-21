//
//  StocksViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
//   var stocksDictionary = [String: [Stock]]()
    var stockArray: [Stock] = []
    var sectionArray = [String]()
    var sectionName: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        loadData()
        getSectionNames()
    }
    
    func getSectionNames() {
        for stock in stockArray {
            if !sectionName.contains(stock.sectionNameNeedAverage) {
                sectionName.append(stock.sectionNameNeedAverage)
            }
        }
    }
    func stocksInSection(_ section: Int) -> [Stock] {
        return stockArray.filter{$0.sectionNameNeedAverage == sectionName[section]}
    }
//    func getStockDate() {
//        for stock in stocks {
//            if !dates.contains(stock.sectionNameNeedAverage) {
//            dates.append(stock.sectionNameNeedAverage)
//        }
//    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                self.stockArray = Stock.getStocks(from: data)
               
            }

        }
    }
}

extension StocksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionName.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  stocksInSection(section).count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
        let stocksInThisSection = stocksInSection(indexPath.section)
        let thisStock = stocksInThisSection[indexPath.row]
        cell.textLabel?.text = thisStock.date
        cell.detailTextLabel?.text = thisStock.open.description
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let average = Stock.averageOfMonth(stockArr: stocksInSection(section))
        return "\(sectionName[section]): Average: $\(String(format: "%.2f", average))"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StocksDetailViewController {
            let selectedRow = tableView.indexPathForSelectedRow!.row
            let selectedStock = stockArray[selectedRow]
            destination.stocks = selectedStock
        }
    }
        
    
    
}



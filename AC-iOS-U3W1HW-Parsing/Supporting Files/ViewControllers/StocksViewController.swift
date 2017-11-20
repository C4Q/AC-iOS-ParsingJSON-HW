//
//  StocksViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {

    var stocksArr = [Stocks]()
    var sectionNames: [String] = []
    
    func stocksInSection(_ section: Int) -> [Stocks] {
        return stocksArr.filter{$0.sectionName == sectionNames[section]}
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadData()
        getSectionNames()
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
            self.stocksArr = Stocks.getStocks(from: data)
            }
        }
    }
    func getSectionNames() {
        for stock in stocksArr {
            if !sectionNames.contains(stock.sectionName) {
                sectionNames.append(stock.sectionName)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detail = segue.destination as? StocksDetailViewController {
            let selectedRow = tableView.indexPathForSelectedRow!.row
            let selectedStock = stocksArr[selectedRow]
            detail.selectedStock = selectedStock
        }
    }
}

extension StocksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksInSection(section).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        let stocksInThisSection = stocksInSection(indexPath.section)
        
        let thisStock = stocksInThisSection[indexPath.row]
        cell.textLabel?.text = thisStock.date
        cell.detailTextLabel?.text = "\(thisStock.open)"
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let Average = Stocks.averageOfMonth(stockArr: stocksInSection(section))
        return "\(sectionNames[section]): Average: $\(String(format: "%.2f", Average)) "
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
}

//
//  StocksViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var stockTableView: UITableView!
    
    
    var stocks: [Stock] = []
    
    var sectionNames = [String]()
    
    func stockBySection(_ section: Int) -> [Stock] {
        return stocks.filter({$0.sectionName == sectionNames[section]})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        getSectionNames()
        self.stockTableView.delegate = self
        self.stockTableView.dataSource = self 
        
        // Do any additional setup after loading the view.
    }
    func getSectionNames() {
        for stock in stocks {
            if !sectionNames.contains(stock.sectionName) {
                sectionNames.append(stock.sectionName)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
               let stockList = Stock.getStocks(from: data)
                self.stocks = stockList.sorted(by: { (a, b) -> Bool in
                    return a.date < b.date})
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockBySection(section).count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.stockTableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
        let stocksInThisSection = stockBySection(indexPath.section)
        let stock = stocksInThisSection[indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = String(format: "%.2f", stock.open)
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let thisSection = sectionNames[section]
        let stocksInSection = stocks.filter{$0.sectionName == thisSection}
        var sum = 0.0
        for stock in stocksInSection {
            sum += stock.open
        }
        let averageOpen = sum/Double(stocksInSection.count)
        return sectionNames[section] + " " + "Average: $\(String(format: "%.2f", averageOpen))"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     guard
        let stockDestinationVC = segue.destination as? StockDetailViewController,
        let stockCell = sender as? UITableViewCell,
        let thisIndexPath = stockTableView.indexPath(for: stockCell)
        else {
            return
        }
        let stocksInSection = self.stockBySection(thisIndexPath.section)
        let thisStock = stocksInSection[thisIndexPath.row]
        let previousStock = stocksInSection[thisIndexPath.row - 1]
        if thisIndexPath.row == 0 {
            stockDestinationVC.todaysStock = thisStock
            
        }
        else {
            stockDestinationVC.todaysStock = thisStock
            stockDestinationVC.yesterdaysStock = previousStock
        }
        
    }
    


}

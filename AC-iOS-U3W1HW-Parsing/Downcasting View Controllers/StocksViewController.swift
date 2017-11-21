//
//  StocksViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var stocksTableView: UITableView!
    
    var stocks = [Stock]()
    var monthlySections = [String]()



    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stocksTableView.dataSource = self
        loadStockData()
        getHeaders()
    }
    
    func loadStockData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let stocks = Stock.getStock(from: data)
                self.stocks = stocks
            }
        }
    }
    
    func getHeaders() {
        for stock in stocks {
            if !monthlySections.contains(stock.headerDate) {
                monthlySections.append(stock.headerDate)
            }
        }
        print(monthlySections)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return monthlySections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let thisHeader = monthlySections[section]
        let theseStocks = sortedStocks.filter {$0.headerDate == thisHeader}
        return theseStocks.count
    }
    
    var sortedStocks: [Stock] {
        return stocks.sorted(){ $0.date < $1.date }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let thisHeader = monthlySections[indexPath.section]
        let theseStocks = sortedStocks.filter {$0.headerDate == thisHeader}
        
        
        let stock = theseStocks[indexPath.row]
        
        
        let cell = self.stocksTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = "Opening Price: $\(String(describing: stock.open!))"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let thisHeader = monthlySections[section]
        let theseStocks = sortedStocks.filter {$0.headerDate == thisHeader}
        var sumOfOpeningPrices: Double = 0.0
        var averageOpeningPrice: Double
        
        for stock in theseStocks {
            sumOfOpeningPrices += stock.open!
        }
        averageOpeningPrice = sumOfOpeningPrices / Double(theseStocks.count)
        let header = monthlySections[section] + ": Average Open: $" + String(format: "%.2f", averageOpeningPrice)
        return header
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StockDetailViewController {
            let index = self.stocksTableView.indexPathForSelectedRow!.row
            let selectedStock = self.stocks[index]
            destination.stock = selectedStock
        }
    }
    
    
    
    
    
}

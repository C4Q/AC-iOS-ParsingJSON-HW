//
//  StocksTableViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Reiaz Gafar on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var stocks = [Stock]()
    var appleStocks = [[Stock]]()
    var monthlyAverages = [String : Double]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        stocks = Stock.populateStockData()
        appleStocks = Stock.stocksByMonth(stocks: stocks)
        monthlyAverages = Stock.getMonthlyAverages(stocks: stocks)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? StockDetailViewController else { return }
        let selectedSection = tableView.indexPathForSelectedRow?.section
        let selectedRow = tableView.indexPathForSelectedRow?.row
        let selectedStock = appleStocks[selectedSection!][selectedRow!]
        destination.stock = selectedStock
        
    }

}


extension StocksTableViewController: UITableViewDelegate, UITableViewDataSource {
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return appleStocks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateArray = appleStocks[section][0].date.components(separatedBy: "-")
        let month = dateArray[0] + dateArray[1]
        let year = dateArray[0]
        let monthString = appleStocks[section][0].label.components(separatedBy: " ")[0]
        let average = String(format: "%.2f", monthlyAverages[month]!)
        return "\(monthString) \(year): \(average)"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appleStocks[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)
        let selectedStock = appleStocks[indexPath.section][indexPath.row]
        cell.textLabel?.text = selectedStock.date
        cell.detailTextLabel?.text = selectedStock.open.description
        return cell
    }
    
}

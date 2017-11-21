//
//  ApplStockViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Luis Calle on 11/15/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ApplStockViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var applStocksTableView: UITableView!
    var allApplStocks = [ApplStock]()
    var stocksByMonth = [(key: String, value: [ApplStock])]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applStocksTableView.delegate = self
        self.applStocksTableView.dataSource = self
        loadAllApplStocks()
        self.stocksByMonth = ApplStock.makeStockTupleByMonth(stocks: allApplStocks)
    }
    
    func loadAllApplStocks() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let theURL = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: theURL)
                self.allApplStocks = ApplStock.getApplStocks(from: data)
            }
            catch let error {
                print(error)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ApplStockDetailedViewController {
            guard let selectedPath = applStocksTableView.indexPathForSelectedRow else { return }
            let selectedRow = selectedPath.row
            let selectedStock = self.allApplStocks[selectedRow]
            destination.stock = selectedStock
        }
    }

}

extension ApplStockViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksByMonth[section].value.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateAsString = stocksByMonth[section].key
        guard let dateMonthYearTuple = ApplStock.dateConversion(dateStr: dateAsString) else { return nil }
        let arrayOfStocksOfMonth = stocksByMonth[section].value
        let averageOfMonth = ApplStock.findMonthAverage(stockArr: arrayOfStocksOfMonth)
        return dateMonthYearTuple.month + " - " + dateMonthYearTuple.Year + ": Average: " + String(format: "$%.02f", averageOfMonth)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stocksByMonth.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stockCell = tableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
        let section = indexPath.section
        let row = indexPath.row
        let currentStock: ApplStock = stocksByMonth[section].value[row]
        guard let stockTextLabel = stockCell.textLabel, let stockDetailTextLabel = stockCell.detailTextLabel else {
            return stockCell
        }
        stockTextLabel.text = currentStock.date
        stockDetailTextLabel.text = currentStock.open.description
        return stockCell
    }
    
}

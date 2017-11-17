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
    var applStocksByMonthDict = [String: [ApplStock]]()
    var stocksByMonthSorted = [(key: String, value: [ApplStock])]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applStocksTableView.delegate = self
        self.applStocksTableView.dataSource = self
        loadAllApplStocks()
        self.applStocksByMonthDict = ApplStock.makeStockDictByMonth(stocks: allApplStocks)
        stocksByMonthSorted = self.applStocksByMonthDict.sorted{ $0.key < $1.key }
    }
    
    func loadAllApplStocks() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let theURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: theURL) {
                self.allApplStocks = ApplStock.getApplStocks(from: data)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ApplStockViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksByMonthSorted[section].value.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dateAsString = stocksByMonthSorted[section].key
        let dateMonthYearTuple = ApplStock.dateConversion(dateStr: dateAsString)
        let arrayOfStocksOfMonth = stocksByMonthSorted[section].value
        let averageOfMonth = ApplStock.findMonthAverage(stockArr: arrayOfStocksOfMonth)
        return dateMonthYearTuple.month + " - " + dateMonthYearTuple.Year + ": Average: " + String(format: "$%.02f", averageOfMonth)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stocksByMonthSorted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stockCell = tableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
        let sec = indexPath.section
        let row = indexPath.row
        let currentStock: ApplStock = stocksByMonthSorted[sec].value[row]
        stockCell.textLabel?.text = currentStock.date
        stockCell.detailTextLabel?.text = currentStock.open.description
        return stockCell
    }
    
}

//
//  ApplStockViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Clint Mejia on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ApplStockViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var stockTableView: UITableView!
    
    // MARK: - Variables
    var stocks = [ApplStock]()
    var stocksAsDictionary = [(key: String, value: [ApplStock])]()
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.dataSource = self
        stockTableView.delegate = self
        loadStocks()
    }
    
    // MARK: - Functions
    func loadStocks() {
        guard let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else { return }
        let myURL = URL(fileURLWithPath: path)
        if let data = try? Data(contentsOf: myURL) {
            self.stocks = ApplStock.getApplStock(from: data)
        }
        stocksAsDictionary = ApplStock.createDictionary(for: stocks)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ApplDetailViewController {
            guard let selectedRow = stockTableView.indexPathForSelectedRow?.row else { return }
            guard let selectedSection = stockTableView.indexPathForSelectedRow?.section else { return }
            let selectedStock = self.stocksAsDictionary[selectedSection].value[selectedRow]
            destination.selectedStock = selectedStock
        }
    }
}

//MARK: tableView - data source methods
extension ApplStockViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocksAsDictionary[section].value.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return stocksAsDictionary.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let stocksInSection = stocksAsDictionary[section].value
        let currentDatedSection = stocksAsDictionary[section].key
        return ApplStock.monthAsTextAndYearAsNumber(from: currentDatedSection) + ": Average: " + String(format: "$%.02f", ApplStock.monthlyOpeningAverageCalculated(for: stocksInSection))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appleStockCell", for: indexPath)
        let cellRow = indexPath.row
        let stockSection = indexPath.section
        let currentStock = stocksAsDictionary[stockSection].value[cellRow]
        cell.textLabel?.text = currentStock.date
        cell.detailTextLabel?.text = currentStock.open.description
        return cell
    }
    
}



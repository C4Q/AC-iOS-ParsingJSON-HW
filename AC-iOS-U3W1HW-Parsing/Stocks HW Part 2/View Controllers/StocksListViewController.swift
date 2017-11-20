//
//  StocksListViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksListViewController: UIViewController {

    @IBOutlet weak var stocksTableView: UITableView!
    
    var stocks: [Stock] = []
    var sectionNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        getSectionNames()
        stocksTableView.delegate = self
        stocksTableView.dataSource = self
    }
    
    func getData() {
        guard let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
            print("Error: could not get json path")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        guard let data = try? Data(contentsOf: url) else {
            print("Error: could not get data from url")
            return
        }
        
        //setting up data - from https://stackoverflow.com/questions/38168594/sort-objects-in-array-by-date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        stocks = Stock.getStocks(from: data).sorted { (currentStock, nextStock) -> Bool in
            guard
                let currentStockDate = dateFormatter.date(from: currentStock.date),
                let nextStockDate = dateFormatter.date(from: nextStock.date)
            else {
                return false
            }
            
            return currentStockDate.compare(nextStockDate) == .orderedAscending
        }
    }
    
    func getSectionNames() {
        for stock in stocks {
            if !sectionNames.contains(stock.sectionName) {
                sectionNames.append(stock.sectionName)
            }
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectedCell = sender as? UITableViewCell, let selectedIndexPath = stocksTableView.indexPath(for: selectedCell), let destinationVC = segue.destination as? StocksDetailViewController {
            let currentRowsInSection = stocks.filter{$0.sectionName == sectionNames[selectedIndexPath.section]}
            
            destinationVC.stock = currentRowsInSection[selectedIndexPath.row]
        }
    }
}

//MARK: - Table View Methods
extension StocksListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Table View Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        
        performSegue(withIdentifier: "detailedSegue", sender: selectedCell)
    }
    
    //Table View Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentRowsInSection = stocks.filter{$0.sectionName == sectionNames[section]}
        
        return currentRowsInSection.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let currentStocksInRow = stocks.filter{$0.sectionName == sectionNames[section]}
        
        let average = currentStocksInRow.reduce(0) { (sum, nextStock) -> Double in
            sum + nextStock.close
        } / Double(currentStocksInRow.count)
        
        let averageTruncated = floor(average * 100) / 100
        
        return "\(sectionNames[section]) - Average: $\(averageTruncated)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let currentStocksInSection = stocks.filter{$0.sectionName == sectionNames[indexPath.section]}
        let currentStock = currentStocksInSection[indexPath.row]
        
        cell.textLabel?.text = currentStock.date.description
        cell.detailTextLabel?.text = currentStock.close.description
        
        return cell
    }
}

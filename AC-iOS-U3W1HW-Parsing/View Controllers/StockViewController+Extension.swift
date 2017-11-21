//
//  StockViewController+Extension.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

extension StockViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: TableView Datasource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return handlingSection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let numberOfStocks = stocks.filter{$0.dateFormat.yearMonth == handlingSection[section]}
        let myAverage = String(format: "%.2f", (numberOfStocks.reduce(0){(a, b) in return a + b.open} / Double(numberOfStocks.count)))
        return numberOfStocks.first!.dateFormat.yearMonthformatted + ": Average: $\(myAverage)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mySectionRows = stocks.filter{$0.dateFormat.yearMonth == handlingSection[section]}
        
        return mySectionRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = stocks.filter{$0.dateFormat.yearMonth == handlingSection[indexPath.section]}[indexPath.row]
        let stockCell = stockTableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
        stockCell.textLabel?.text = "\(stock.date)"
        stockCell.detailTextLabel?.text = "\(stock.open)"
        return stockCell
    }
}

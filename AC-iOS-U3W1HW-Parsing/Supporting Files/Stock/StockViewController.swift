//
//  StockViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Masai Young on 11/15/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

class StockViewController: UIViewController {
    
    var statsGroupedByDate = [[Stock]]()
    
    @IBOutlet weak var stockTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1. We need to check what our sender is. Afterall, there might be multiple segues set up...
        // 2. check for the right storyboard segue
        // 3. Get the destination VC
        
        guard let destination = segue.destination as? DetailStockViewController else {
            return
        }
        
        if let activatedCell = sender as? UITableViewCell, segue.identifier == "StockDetailSegue" {
            // 4. Getting the movie at the tapped cell
            let cellIndex = stockTableView.indexPath(for: activatedCell)!
            destination.singleStockStat = statsGroupedByDate[cellIndex.section][cellIndex.row]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stockTableView.dataSource = self
        statsGroupedByDate = Stock.groupByDate(list: Stock.fetchStocks()!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: Table View Data Source
extension StockViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return statsGroupedByDate.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return Stock.monthAndYear(section, statsGroupedByDate) + "  ||  " + Stock.averageOpeningPrice(section, statsGroupedByDate)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statsGroupedByDate[section].count
    }
    
    // MARK: - Cell Rendering
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
        let currentStock = statsGroupedByDate[indexPath.section][indexPath.row]
        cell.textLabel?.text = currentStock.standaloneMonth + " " + currentStock.ordinalNumber
        cell.detailTextLabel?.text = String(currentStock.open)
        cell.textLabel?.textColor = currentStock.color()
        cell.imageView?.image = UIImage(named: currentStock.thumbnail())
        return cell
    }
    
}


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
    }
}

//MARK: tableView - data source methods
extension ApplStockViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "appleStockCell", for: indexPath)
        let stock = stocks[indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = stock.open.description
        return cell
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ApplDetailViewController {
            destination.selectedStock = stocks[stockTableView.indexPathForSelectedRow!.row]
        }
    }
}





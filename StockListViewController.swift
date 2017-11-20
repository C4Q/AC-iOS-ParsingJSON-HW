//
//  StockListViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Lisa J on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StockListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var stocks = [Stock]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            print("path works")
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                self.stocks = Stock.getStock(from: data)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let stock = stocks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stock cell", for: indexPath)
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = "\(stock.open)"
        return cell
    }
    sec
    
    
}

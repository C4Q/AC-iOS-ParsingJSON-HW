//
//  StocksViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class stocksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
 
    @IBOutlet weak var tableView: UITableView!
    var stocks = [Stock]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadData()
    }
    
    func loadData(){
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json"){
            let myUrl = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myUrl){
                self.stocks = Stock.getStocks(from: data)
                
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
       let stock = stocks[indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = stock.open.description
        return cell
    }
    
}

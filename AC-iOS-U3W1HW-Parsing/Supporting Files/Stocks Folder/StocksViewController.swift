//
//  StocksViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Ashlee Krammer on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var stocks = [Stocks]()
    
    
    //Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadData()
    }
    
    func loadData(){
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL){
                self.stocks = Stocks.getStocks(from: data)
            }
        }
        
    }
    
    
    //Sections
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    //Cells
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aStock = stocks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stocks Cell", for: indexPath)
        cell.textLabel?.text = aStock.date
        cell.detailTextLabel?.text = "$" + aStock.open.description
        return cell
    }
    
    
    
    //Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedStocksViewController {
            let selectedRow = tableView.indexPathForSelectedRow?.row
            let selectedStock = stocks[selectedRow!]
            destination.stocks = selectedStock
        }
    }
    
    
    //Sections
    
    var sectionNames = ""
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

//
//  StocksTableViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksTableViewController: UIViewController {
    var stockInfo = [StockInfo]()
    
    @IBOutlet weak var stocksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stocksTableView.dataSource = self
        getStockData()
    }
    
    func getStockData(){
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json"){
            let myUrl = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myUrl){
                let stocks = StockInfo.createArrayOfStock(from: data)
                self.stockInfo = stocks!
            }
        }
        for stock in stockInfo{
            print(stock.date ?? "no date available", stock.openingAmount, stock.closingAmount)
        }
    }
}// end of class


extension StocksTableViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
        
        let stockProfile = stockInfo[indexPath.row]
        cell.textLabel?.text = stockProfile.date
        cell.detailTextLabel?.text = String("Open: \(stockProfile.openingAmount)")
        
        return cell
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailStocksViewController {
            //set up properties to send over
            //sending over information from the row of the tableview that was selected by the user
            destination.stocks = stockInfo[stocksTableView.indexPathForSelectedRow!.row]
        }
    }
}




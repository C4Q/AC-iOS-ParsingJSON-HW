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
    var sectionNames = [String]()
    
    func stockFromThatMonth(_ section: Int) -> [StockInfo] {
        return stockInfo.filter {$0.theSectionNames == sectionNames[section]}
    }

    func getSectionNames(){
        for stocks in stockInfo {
            if !sectionNames.contains(stocks.theSectionNames){
                sectionNames.append(stocks.theSectionNames)
            }
        }
        print(sectionNames)
    }
    
    
    @IBOutlet weak var stocksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stocksTableView.dataSource = self
        getStockData()
        getSectionNames()
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
        return sectionNames.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let theNameOfThisSection = sectionNames[section]
        let stocksInThisSection = stockInfo.filter {$0.theSectionNames == theNameOfThisSection}
        return stocksInThisSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
        
        let theNameOfThisSection = sectionNames[indexPath.section]
        let stocksInThisSection = stockInfo.filter {$0.theSectionNames == theNameOfThisSection}
        
        let stockProfile = stocksInThisSection[indexPath.row]
        cell.textLabel?.text = stockProfile.date
        cell.detailTextLabel?.text = String("Open: \(stockProfile.openingAmount)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let theNameOfThisSection = sectionNames[section]
        let stocksInThisSection = stockInfo.filter {$0.theSectionNames == theNameOfThisSection}
        var total = 0.0
        
        for stock in stocksInThisSection {
            total += stock.openingAmount
        }
        let average = total / Double(stocksInThisSection.count)
        
        return sectionNames[section] + " - Average Open: \(String(format:"%.2f", average))"
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let theNameOfThisSection = sectionNames[stocksTableView.indexPathForSelectedRow!.row]
        let stocksInThisSection = stockInfo.filter {$0.theSectionNames == theNameOfThisSection}
        
        
        if let destination = segue.destination as? DetailStocksViewController {
            let selectedRow = stocksTableView.indexPathForSelectedRow!.row
            let selectedStock = stocksInThisSection[selectedRow]
            //set up properties to send over
            //sending over information from the row of the tableview that was selected by the user
            destination.stocks = selectedStock//stockInfo[stocksTableView.indexPathForSelectedRow!.row]
        }
    }
}




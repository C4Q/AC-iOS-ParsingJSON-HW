//
//  StockPriceViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StockPriceViewController: UIViewController {
    var stocks = [APPLStockInfo]()
    var sectionArr = [String]()
    
    @IBOutlet weak var stockPriceTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockPriceTableView.dataSource = self
        stockPriceTableView.delegate = self
        getData()
        getSectionNames()
    }
}

extension StockPriceViewController: UITableViewDelegate, UITableViewDataSource {
    
    //GET DATA
    func getData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let stock = APPLStockInfo.createArrayOfStocks(from: data)
                self.stocks = stock!
            }
        }
        for stock in stocks {
            print(stock.date)
        }
    }
    
    //SECTIONS
    func getSectionNames() {
        for stock in stocks {
            if !sectionArr.contains(stock.sectionNames) {
                sectionArr.append(stock.sectionNames)
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArr.count
    }
    
 
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let theSectionNames = sectionArr[section]
        let stockSections = stocks.filter{$0.sectionNames == theSectionNames}
        var total: Double = 0
        for stock in stockSections {
            total += stock.close
        }
        let formattedAvg = String(format: "$%.02f", total/Double(stockSections.count))
        return sectionArr[section] + " Average : \(formattedAvg)"
    }
    
    /*
    MARK: - REQUIRED TABLEVIEW METHODS
    ****************************************
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let theSectionNames = sectionArr[section]
        let stockSections = stocks.filter{$0.sectionNames == theSectionNames}
        return stockSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockPriceTableView.dequeueReusableCell(withIdentifier: "applStocks", for: indexPath)
        let sectionText = sectionArr[indexPath.section]
        let stockSections = stocks.filter{$0.sectionNames == sectionText}
        let stock = stockSections[indexPath.row]
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = "\(stock.open)"
        return cell
    }
    
    //PREPARE FOR SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StockDetailSegue" {
            if let destination = segue.destination as? ApplStockDetailViewController {
                let row = stockPriceTableView.indexPathForSelectedRow!.row
                destination.myStocks = self.stocks[row]
            }
        }
    }
}



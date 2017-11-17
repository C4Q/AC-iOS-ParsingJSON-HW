//
//  StockViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Richard Crichlow on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var stockArr = [Stock]()
    let years = ["2015", "2016", "2017"]
    let months = ["January": "01", "February": "02", "March": "03", "April": "04", "May": "05", "June": "06", "July": "07", "August": "08", "September": "09", "October": "10", "November": "11", "December": "12"]
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadData()
        splitDate()
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let optionalStock = Stock.getStock(from: data)
//                guard let nonOptional3 = Stock.getStock(from: data) else { print("nils"); return}
                let nonOptionalStock2 = Stock.getStock(from: data)!
                if let nonOptionalStock = Stock.getStock(from: data) {
                    self.stockArr = nonOptionalStock
                }
                
                
            }
        }
        else {return}
        
    }
    
    
    func splitDate() {
        
        for num in 0..<stockArr.count {
            let stock = stockArr[num]
            let arrOfDate = stock.date.split(separator: "-")
            print("YEAR: \(arrOfDate[0]), MONTH: \(arrOfDate[1]) ")
            
            print(arrOfDate[0])
//            if !years.contains("\(arrOfDate[0])") {
//
//            }
            
        }
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch years[section] {
        case "2015":
            return "2015"
        case "2016":
            return "2016"
        case "2017":
            return "2017"
        default:
            print("YOu messed up on your title for section headers")
        }
        return "Nothing"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return years.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch years[section]{
        case "2015": //2015
        
            let yearOfStock = stockArr.filter { $0.date.split(separator: "-")[0] == "2015"  }
            return yearOfStock.count
        case "2016": //2016
            let yearOfStock = stockArr.filter { $0.date.split(separator: "-")[0] == "2016" }
            return yearOfStock.count
        case "2017": //2017
            let yearOfStock = stockArr.filter { $0.date.split(separator: "-")[0] != "2017" }
            return yearOfStock.count
        default:
            return 0
        }
        
        
        //let theSeasons = episodes.filter { String($0.season) == sectionHeader[section] }
        //return theSeasons.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        
//        let theSeasons = episodes.filter {String($0.season) == sectionHeader[indexPath.section]}
//        let anEpisode = theSeasons[indexPath.row]
        let aYearOfStock = stockArr.filter { $0.date.split(separator: "-")[0] == years[indexPath.section] }
        //filter months from HERE!!!!!
        let oneDayOfStock = aYearOfStock[indexPath.row]
        let date = oneDayOfStock.date.split(separator: "-")
        
        
        
        cell.textLabel?.text = oneDayOfStock.date
        cell.detailTextLabel?.text = "Open: \(oneDayOfStock.open) - Change: \(oneDayOfStock.change)"
        
        return cell
    }
    
}

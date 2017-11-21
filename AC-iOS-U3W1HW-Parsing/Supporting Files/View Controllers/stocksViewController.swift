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
    var sortedStocks = [[Stock]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadData()
        
        
        
        var stockSection: Set<String> = []
       
        for stocks in stocks{
            let date = stocks.date
            var dateCheck = ""
            var counter = 0
            
            for char in date{
                dateCheck = dateCheck + char.description
                counter += 1
                if counter == 7{
                    break
                }
            }
            stockSection.insert(dateCheck)
        }
        
        var dateArr = [String]()
        
        dateArr.append(contentsOf: stockSection)
        dateArr.sort()
        
        for date in dateArr{
        sortedStocks.append(stocks.filter{$0.date.contains(date)})
        }
    }
    
    func loadData(){
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json"){
            let myUrl = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myUrl){
                self.stocks = Stock.getStocks(from: data)
                
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedStocks.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       var stockDateArr = sortedStocks[section]
        let stockDate = stockDateArr[0].date
        var stockYear = ""
        var stockMonth = ""
        var counter = 0
        for char in stockDate{
            
            switch counter{
            case _ where counter == 7:
                break
            case _ where counter < 4:
                stockYear = stockYear + char.description
                counter += 1
            case _ where counter > 4:
                stockMonth = stockMonth + char.description
                counter += 1
            default:
               counter += 1
               continue
            }
        }
       
        
        switch stockMonth{
        case "01":
            stockMonth = "January"
        case "02":
            stockMonth = "February"
        case "03":
            stockMonth = "March"
        case "04":
            stockMonth = "April"
        case "05":
            stockMonth = "May"
        case "06":
            stockMonth = "June"
            
        case "07":
            stockMonth = "July"
            
        case "08":
            stockMonth = "August"
        case "09":
            stockMonth = "September"
        case "10":
            stockMonth = "October"
        case "11":
            stockMonth = "November"
        case "12":
            stockMonth = "December"
        default:
            print("error with the month")
        }
        
        
        
        
        
        
        
        var sum = 0.0
        for stocks in stockDateArr{
            sum += stocks.open
        }
        
      
        let average = round(100.0 * (sum / Double(stockDateArr.count))) / 100.0
        
        
        return stockMonth + " " + stockYear + "     " + "Average: $" + average.description
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedStocks[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
       let stockDate = sortedStocks[indexPath.section]
        let stock = stockDate[indexPath.row]
       
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = stock.open.description
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StocksDetailViewController{
            let selectedDate = sortedStocks[(tableView.indexPathForSelectedRow?.section)!]
            let selectedStock = selectedDate[(tableView.indexPathForSelectedRow?.row)!]
            destination.stock = selectedStock
            
        }
    }
    
}

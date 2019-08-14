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
    
    var sortedStocks = [[Stocks]]()
    
    //Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadData()
        
        
        
        var sortedDates: Set<String> = []
        
        
        for dates in stocks {
            var dateString = ""
            var counter = 0
            let date = dates.date
            
            for char in date {
                dateString = dateString + char.description
                counter += 1
                
                if counter == 7 {
                    break
                }
            }
            
            
            
            sortedDates.insert(dateString)
            
        }
        
        
        var sortedDateArr = [String]()
        
        sortedDateArr.append(contentsOf: sortedDates)
        sortedDateArr.sort()
        
        
        for dates in sortedDateArr {
            sortedStocks.append(stocks.filter{$0.date.contains(dates)})
        }
        
    }
    
    func loadData(){
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL){
                self.stocks = Stocks.getStocks(from: data)
            }
        }
        
    }
    
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedStocks.count
    }
    
    
    
    //Sections
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedStocks[section].count
    }
    
    //Cells
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let setupSection = sortedStocks[indexPath.section]
        let aStock = setupSection[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stocks Cell", for: indexPath)
        cell.textLabel?.text = aStock.date
        cell.detailTextLabel?.text = "$" + aStock.open.description
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var dateTitle = ""
        var counter = 0
        let stockDateArray = sortedStocks[section]
        let modelDate = stockDateArray.first?.date
        var averageOpens = 0.0
        
        for opens in stockDateArray {
            averageOpens += opens.open
        }
        averageOpens = averageOpens / Double(stockDateArray.count)

        
        //Date Producer
        for date in modelDate! {
            dateTitle = dateTitle + date.description
            counter += 1
            
            if counter == 7 {
                break
            }
        }
        
        //Month Producer
        
        var monthCounter = 0
        var monthName = ""
        var monthforHeader = ""
        
        for month in dateTitle{
            monthCounter += 1
            
            if monthCounter >= 6  && monthCounter <= 8{
                monthforHeader = monthforHeader + month.description
            }
            
            switch monthforHeader {
            case "01":
                monthName = "January"
            case "02":
                monthName = "February"
            case "03":
                monthName = "March"
            case "04":
                monthName = "April"
            case "05":
                monthName = "May"
            case "06":
                monthName = "June"
            case "07":
                monthName = "July"
            case "08":
                monthName = "August"
            case "09":
                monthName = "September"
            case "10":
                monthName = "October"
            case "11":
                monthName = "November"
            case "12":
                monthName = "September"
            default:
                monthName = monthforHeader
            }
        }
        
        //Year Producer
        var yearForHeader = ""
        var yearCounter = 0
        for year in dateTitle {
            yearCounter += 1
            
            if yearCounter <= 4 {
                yearForHeader = yearForHeader + year.description
            }
        }
        
        
        
        
        
        return "\(monthName), \(yearForHeader)  Average: \(String(format:"%.2f", averageOpens)) "
    }
    
    
    
    
    
    
    //Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedStocksViewController {
            let selectedRow = tableView.indexPathForSelectedRow?.row
            let selectedSection = tableView.indexPathForSelectedRow?.section
            let day = sortedStocks[selectedSection!]
            let selectedStock = day[selectedRow!]
            destination.stocks = selectedStock
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

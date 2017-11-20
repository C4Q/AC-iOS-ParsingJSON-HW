//
//  Stock.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Stock {
    let date: String
    let open: Double
    let close: Double
    let change: Double
    var sectionName: String {
        let date = self.date.components(separatedBy: "-")
        let year = date[0]
        let month = date[1]
        
        let monthDict: [String : String] = ["01" : "January",
                                            "02" : "February",
                                            "03" : "March",
                                            "04" : "April",
                                            "05" : "May",
                                            "06" : "June",
                                            "07" : "July",
                                            "08" : "August",
                                            "09" : "September",
                                            "10" : "November",
                                            "11" : "November",
                                            "12" : "December"]
        
        switch monthDict[month] {
        case (let month) where month != nil:
            return month!.capitalized + " " + year
        default:
            return "No month available"
        }
    }
    
    init(date: String, open: Double, close: Double, change: Double) {
        self.date = date
        self.open = open
        self.close = close
        self.change = change
    }
    
    convenience init?(from stockDict: [String : Any]) {
        guard let date = stockDict["date"] as? String else {
            print("Error: could not get date")
            return nil
        }
        
        guard let open = stockDict["open"] as? Double else {
            print("Error: could not get open")
            return nil
        }
        
        guard let close = stockDict["close"] as? Double else {
            print("Error: could not get close")
            return nil
        }
        
        guard let change = stockDict["change"] as? Double else {
            print("Error: could not get change")
            return nil
        }
        
        self.init(date: date, open: open, close: close, change: change)
    }
    
    static func getStocks(from data: Data) -> [Stock] {
        var stocks: [Stock] = []
        do {
            guard let stockDictArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] else {
                print("Error: Could not cast json as array of dictionaries. Please check format.")
                return []
            }
            
            for stockDict in stockDictArray {
                if let stock = Stock(from: stockDict) {
                    stocks.append(stock)
                }
            }
            
        } catch let error {
            print("Error: json serialization failed. Please check the format. \(error.localizedDescription)")
        }
        
        return stocks
    }
    
}

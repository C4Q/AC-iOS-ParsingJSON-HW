//
//  Stocks.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
class Stock {
    var date: String
    var open: Double
    var close: Double
    
    var sectionName: String {
        var dateArray = date.split(separator: "-")
        let year = dateArray[0]
        let month = String(dateArray[1])
        return "\(months[month]!) \(year)"
    }

     let months = ["01": "January", "02": "February", "03": "March", "04": "April", "05": "May", "06": "June", "07": "July", "08": "August", "09": "September", "10": "October", "11": "November", "12": "December"]
    
    init(date:String, open: Double, close: Double) {
        self.date = date
        self.open = open
        self.close = close
    }
    convenience init?(dict: [String:Any]) {
        guard let date = dict["date"] as? String else {return nil}
        guard let open = dict["open"] as? Double else {return nil}
        guard let close = dict["close"] as? Double else {return nil}
        self.init(date: date, open: open, close: close)
    }
    static func getStocks(from data: Data) -> [Stock] {
        var stocks = [Stock]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonArr = json as? [[String:Any]] else {return []}
            for stockDict in jsonArr {
                if let stock = Stock(dict: stockDict) {
                    stocks.append(stock)
                }
            }
        }
        catch {
            print("error")
        }
        return stocks
    }
    
    
 
    
}

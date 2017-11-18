//
//  stockModel.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Richard Crichlow on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Stock {
    var date: String
    var open: Double
    var close: Double
    var change: Double
    
    var sectionNameNeedAverage: String {
        var dateAsArr = date.split(separator: "-")
        let year = dateAsArr[0]
        let month = String(dateAsArr[1])
        return "\(months[month]!)-\(year)"
    }
    
    let months = ["01": "January", "02": "February", "03": "March", "04": "April", "05": "May", "06": "June", "07": "July", "08": "August", "09": "September", "10": "October", "11": "November", "12": "December"]
    
    init(date: String, open: Double, close: Double,change: Double) {
        self.date = date
        self.open = open
        self.close = close
        self.change = change
    }
    
    convenience init?(withDict dict: [String:Any]) {
        
        if let date = dict["date"] as? String,
            let open = dict["open"] as? Double,
            let close = dict["close"] as? Double,
            let change = dict["change"] as? Double {
            self.init(date: date, open: open, close: close, change: change)
        } else {
            print("There were nils in your Stock JSON")
            return nil
        }
    }
    static func getStock(from data: Data) -> [Stock]? {
        var stockInfo = [Stock]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonDict = json as? [[String:Any]] else {return nil}
            for stock in jsonDict {
                if let stockReport =  Stock(withDict: stock) {
                    stockInfo.append(stockReport)
                }
            }
            return stockInfo
        }
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
}


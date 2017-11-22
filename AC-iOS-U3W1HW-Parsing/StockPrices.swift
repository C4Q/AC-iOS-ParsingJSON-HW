//
//  StockPrices.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class APPLStockInfo {
    let date: String
    let open: Double
    let close: Double
    var sectionNames: String {
        
        var dateArr = date.split(separator: "-")
        let year = dateArr[0]
        var month = String(dateArr[1])
        
        switch month {
        case "01":
            month = "January"
        case "02":
            month = "February"
        case "03":
            month = "March"
        case "04":
            month = "April"
        case "05":
            month = "May"
        case "06":
            month = "June"
        case "07":
            month = "July"
        case "08":
            month = "August"
        case "09":
            month = "September"
        case "10":
            month = "October"
        case "11":
            month = "November"
        case "12":
            month = "December"
        default:
            print("N/A")
        }
        return "\(month) - \(year)"
    }
    
    init(date: String, open: Double, close: Double) {
        self.date = date
        self.open = open
        self.close = close
    }
    
    convenience init?(from dict: [String: Any]) {
        guard
            let date = dict["date"] as? String,
            let open = dict["open"] as? Double,
            let close = dict["close"] as? Double
            else {
                return nil
        }
        self.init(date: date, open: open, close: close)
    }
    
    static func createArrayOfStocks(from data: Data) -> [APPLStockInfo]? {
        var stocksList: [APPLStockInfo] = []
        do {
            guard let stockJSONArr = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                else { return nil }

            for stockDict in stockJSONArr {
                if let thisStock = APPLStockInfo(from: stockDict) {
                    stocksList.append(thisStock)
                }
            }
        } catch let error {
            print(error)
        }
        return stocksList
    }
}
















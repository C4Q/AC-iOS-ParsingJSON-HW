//
//  Stocks.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Stocks {
    
    let date: String
    let open: Double
    let close: Double
    
    var sectionName: String {
        var dateArray = date.split(separator: "-")
        let year = dateArray[0]
        let month = String(dateArray[1])
        return "\(monthsDict[month]!) \(year)"
    }
    let monthsDict = ["01": "January", "02": "February", "03": "March", "04": "April", "05": "May", "06": "June", "07": "July", "08": "August", "09": "September", "10": "October", "11": "November", "12": "December"]
    
    init(date: String, open: Double, close: Double) {
        self.date = date
        self.open = open
        self.close = close
    }
    convenience init?(from dict: [String:Any]) {
        guard let date = dict["date"] as? String,
            let open = dict["open"] as? Double,
            let close = dict["close"] as? Double else { return nil }
        self.init(date: date, open: open, close:close)
    }
    static func getStocks(from data: Data) -> [Stocks] {
        var stocks = [Stocks]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let stockDictArray = json as? [[String:Any]] else { return [] }
                for stockDict in stockDictArray {
                    if let newStock = Stocks(from: stockDict) {
                        stocks.append(newStock)
                    }
                }
        } catch let error {
            print(error)
        }
        return stocks
    }
    
    static func averageOfMonth(stockArr: [Stocks]) -> Double {
        return (stockArr.reduce(0.0){$0 + $1.open}) / Double(stockArr.count)
    }
}

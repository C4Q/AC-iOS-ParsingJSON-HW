//
//  Stock.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

//enum Month: Int {
//    case january = 1
//    case february = 2
//    case march = 3
//    case april = 4
//    case may = 5
//    case june = 6
//    case july = 7
//    case august = 8
//    case september = 9
//    case octuber = 10
//    case november = 11
//    case december = 12
//}

class Stock {
    let date: String
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    let volume: Int
    let unadjustedVolume: Int
    let change: Double
    let changePercent: Double
    let vwap: Double
    let label: String
    let changeOverTime: Double
    var isPriceWentUp: Bool {
        return close > open
    }
    var dateFormat: (yearMonthformatted: String, monthId: Int, yearMonth: String) {
        var dictMonths = [1: "January", 2: "February", 3: "March",
                          4: "April", 5: "May", 6: "June",
                          7: "July", 8: "August", 9: "September",
                          10: "October", 11: "November", 12: "December"]
        let year = Int(String(self.date.split(separator: "-")[0])) ?? 0
        let monthId = Int(String(self.date.split(separator: "-")[1])) ?? 0
        let month = dictMonths[Int(String(self.date.split(separator: "-")[1]))!] ?? "Not Found"
        let yearMonth = String(self.date.split(separator: "-")[0...1].joined())
        return ("\(month) - \(year)", monthId, yearMonth)
    }

    
    init(date: String, open: Double,high: Double, low: Double, close: Double, volume: Int, unadjustedVolume: Int, change: Double, changePercent: Double, vwap: Double, label: String, changeOverTime: Double){
        self.date = date
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.volume = volume
        self.unadjustedVolume = unadjustedVolume
        self.change = change
        self.changePercent = changePercent
        self.vwap = vwap
        self.label = label
        self.changeOverTime = changeOverTime
    }
    
    convenience init?(from stockDict: [String: Any]) {
        guard let date = stockDict["date"] as? String else {return nil}
        let open = stockDict["open"] as? Double ?? 0.0
        let high = stockDict["high"] as? Double ?? 0.0
        let low = stockDict["low"] as? Double ?? 0.0
        let close = stockDict["close"] as? Double ?? 0.0
        let volume = stockDict["volume"] as? Int ?? 0
        let unadjustedVolume = stockDict["unadjustedVolume"] as? Int ?? 0
        let change = stockDict["change"] as? Double ?? 0.0
        let changePercent = stockDict["changePercent"] as? Double ?? 0.0
        let vwap = stockDict["vwap"] as? Double ?? 0.0
        let label = stockDict["label"] as? String ?? "Not found"
        let changeOverTime = stockDict["changeOverTime"] as? Double ?? 0.0
        
        self.init(date: date, open: open, high: high, low: low, close: close, volume: volume, unadjustedVolume: unadjustedVolume, change: change, changePercent: changePercent, vwap: vwap, label: label, changeOverTime: changeOverTime)
    }
    
    static func getDataStock(from data: Data) -> [Stock]? {
        var stockArr = [Stock]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let stockData = json as? [[String: Any]] {
                for stockDict in stockData {
                    if let stock = Stock(from: stockDict) {
                        stockArr.append(stock)
                    }
                }
            }
        } catch let myError {
            print("Unexpected error:", myError)
        }
        return stockArr
    }
}

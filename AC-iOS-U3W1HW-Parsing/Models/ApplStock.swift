//
//  ApplStock.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Luis Calle on 11/15/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class ApplStock {

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
    
    init(date: String, open: Double, high: Double, low: Double, close: Double, volume: Int, unadjustedVolume: Int, change: Double, changePercent: Double, vwap: Double, label: String, changeOverTime: Double) {
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
    convenience init?(from dict: [String: Any]) {
        let date = dict["date"] as? String ?? "Unknown date"
        let open = dict["open"] as? Double ?? 0
        let high = dict["high"] as? Double ?? 0
        let low = dict["low"] as? Double ?? 0
        let close = dict["close"] as? Double ?? 0
        let volume = dict["volume"] as? Int ?? 0
        let unadjustedVolume = dict["unadjustedVolume"] as? Int ?? 0
        let change = dict["change"] as? Double ?? 0
        let changePercent = dict["changePercent"] as? Double ?? 0
        let vwap = dict["vwap"] as? Double ?? 0
        let label = dict["label"] as? String ?? "Unknown label"
        let changeOverTime = dict["changeOverTime"] as? Double ?? 0
        
        self.init(date: date, open: open, high: high, low: low, close: close, volume: volume, unadjustedVolume: unadjustedVolume, change: change, changePercent: changePercent, vwap: vwap, label: label, changeOverTime: changeOverTime)
    }
    
    static func getApplStocks(from data: Data) -> [ApplStock] {
        var stocks = [ApplStock]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let stocksDictArray = json as? [[String: Any]] else { return [] }
            for stockDict in stocksDictArray {
                if let newStock = ApplStock(from: stockDict) {
                    stocks.append(newStock)
                }
            }
        }
        catch {
            print("Error")
        }
        return stocks
    }
    
    static func makeStockDictByMonth(stocks: [ApplStock]) -> [String : [ApplStock]] {
        var stocksByMonth = [String: [ApplStock]]()
        let allStocks = stocks
        for stock in allStocks {
            let date = stock.date
            var arrDate = date.components(separatedBy: "-")
            arrDate.removeLast()
            let dateKey = arrDate.joined(separator: "-")
            if let stocksSoFar = stocksByMonth[dateKey] {
                var toAddNewStock: [ApplStock] = stocksSoFar
                toAddNewStock.append(stock)
                stocksByMonth.updateValue(toAddNewStock, forKey: dateKey)
            } else {
                stocksByMonth[dateKey] = [stock]
            }
        }
        return stocksByMonth
    }
    
    static func dateConversion(dateStr: String) -> (month: String, Year: String) {
        let arrDate = dateStr.components(separatedBy: "-")
        var month: String
        let year: String = arrDate.first!
        switch Int(arrDate.last!)! {
        case 1:
            month = "January"
        case 2:
            month = "February"
        case 3:
            month = "March"
        case 4:
            month = "April"
        case 5:
            month = "May"
        case 6:
            month = "June"
        case 7:
            month = "July"
        case 8:
            month = "August"
        case 9:
            month = "September"
        case 10:
            month = "October"
        case 11:
            month = "November"
        case 12:
            month = "December"
        default:
            month = "Unknown month"
        }
        return (month, year)
    }
    
    static func findMonthAverage(stockArr: [ApplStock]) -> Double {
        return (stockArr.reduce(0.0){$0 + $1.open}) / Double(stockArr.count)
    }
    
}

//
//  Stocks Model.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Maryann Yin on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class StockInfo {
    var date: String
    var open: Double
    var close: Double
    var dateKey: String
    init(date: String, open: Double, close: Double) {
        self.date = date
        self.open = open
        self.close = close
        var dateKeyItemsArr = date.components(separatedBy: "-")
        dateKeyItemsArr.removeLast()
        self.dateKey = dateKeyItemsArr.joined(separator: "")
    }
    
    static func stockDict(allStocks: [StockInfo]) -> [(key: String, value: [StockInfo])] {
        var stockInfoDict: [String:[StockInfo]] = [:]
        for stock in allStocks {
            var currentStocksArr: [StockInfo] = stockInfoDict[stock.dateKey] ?? [stock]
            currentStocksArr.append(stock)
            stockInfoDict.updateValue(currentStocksArr, forKey: stock.dateKey)
        }
        return stockInfoDict.sorted{ $0.key < $1.key }
    }

    convenience init?(dict: [String:Any]) {
        guard let date = dict["date"] as? String else {return nil}
        guard let open = dict["open"] as? Double else {return nil}
        guard let close = dict["close"] as? Double else {return nil}
        self.init(date: date, open: open, close: close)
    }
    
    static func getStocks(from data: Data) -> [StockInfo] {
        var stocks = [StockInfo]()
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let jsonArr = json as? [[String:Any]] else {return []}
            for stockDict in jsonArr {
                if let stock = StockInfo(dict: stockDict) {
                    stocks.append(stock)
                    }
                }
            }
            catch {
                print(error)}
            return stocks
    }

}

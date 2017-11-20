//
//  Stock.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Clint Mejia on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class ApplStock {
    let date: String
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    let change: Double

    var image: String {
        let thumbState = (open > close) ? "thumbsdown" : "thumbsup"
        let randomNumber = arc4random_uniform(UInt32(6))
        return "\(thumbState)\(randomNumber)"
    }
    
    var monthAndYear: String {
        enum Month: Int {
            case January = 01, February, March, April, May, June, July, August, September, October, November, December
        }
        let dateAsArray = date.components(separatedBy: "-")
        let month = Int(dateAsArray[1])
        let year = dateAsArray.first
        return "\(Month.init(rawValue: month!)!) \(year!)"
    }
    
    
    init(date: String, open: Double, high: Double, low: Double, close: Double, change: Double) {
        self.date = date
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.change = change
    }
    
    convenience init?(from jsonDict: [String: Any]) {
        guard
        let date = jsonDict["date"] as? String,
        let open = jsonDict["open"] as? Double,
        let high = jsonDict["high"] as? Double,
        let low = jsonDict["low"] as? Double,
        let close = jsonDict["close"] as? Double,
        let change = jsonDict["change"] as? Double
        else {
            return nil
        }
        self.init(date: date, open: open, high: high, low: low, close: close, change: change)
    }
    
    static func getApplStock(from data: Data) -> [ApplStock] {
        var stock = [ApplStock]()
        do {
            guard let applStocksJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] else { return [] }
            for applStockDict in applStocksJSON {
                if let applStock = ApplStock(from: applStockDict) {
                    stock.append(applStock)
                }
            }
        }
        catch {
            print("Error converting data to JSON")
        }
        return stock
    }
}

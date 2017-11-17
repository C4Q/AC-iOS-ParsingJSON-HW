//
//  stockModel.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
class Stock {
    let date: String
    let open: Double
    let close: Double
    init(date: String, open: Double, close: Double) {
    self.date = date
    self.open = open
    self.close = close
    }
    convenience init?(from jsonDict: [String:Any]) {
        guard let date = jsonDict["date"] as? String else {return nil}
        let open = jsonDict["open"] as? Double
        let close = jsonDict["close"] as? Double
        self.init(date: date, open: open!, close: close!)
    }
    static func getStocks(from data: Data) -> [Stock] {
        var stocks = [Stock]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonDictArr = json as? [[String: Any]] else {return []}
            for jsonDict in jsonDictArr {
                if let newStock = Stock.init(from: jsonDict) {
                    stocks.append(newStock)
                }
            }
        }
        catch {
            print("error")
        }
        return stocks
    }
}

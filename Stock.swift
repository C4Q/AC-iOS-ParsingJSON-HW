//
//  Stock.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Lisa J on 11/19/17.
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
    convenience init?(from dict: [String : Any]) {
        if let date = dict["date"] as? String,
        let open = dict["open"] as? Double,
        let close = dict["close"] as? Double {
        self.init(date: date, open: open, close: close)
    } else {
    print("nils found")
            return nil
    }
}

static func getStock(from data: Data) -> [Stock] {
    var stocks = [Stock]()
    do{
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        //cast jsonDict as dictionary format & append to stocks object
        guard let jsonDict = json as? [[String:Any]] else {return []}
        for dict in jsonDict {
            if let stock = Stock.init(from: dict) {
                stocks.append(stock)
            }
        }
        return stocks
    } catch {
        print("\(error)")
    }
    return []
    }
}


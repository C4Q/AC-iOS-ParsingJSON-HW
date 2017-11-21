//
//  applStockInfo.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class AppleStockInfo {
    let date: String
    let open: Double
    let close: Double
    var session: String {
        let dateAsArr = date.split(separator: "-")
       return dateAsArr[0...1].joined(separator: "-")
    }
    init(date: String, open: Double, close: Double) {
        self.date = date
        self.open = open
        self.close = close
        
    }
    convenience init?(dict:[String: Any]) {
        guard let date = dict["date"] as? String,
        let open = dict["open"] as? Double,
            let close = dict["close"] as? Double else {return nil}
        self.init(date: date, open: open, close: close)
    }
    static func getData(from data: Data) -> [AppleStockInfo] {
        var appleStockArr = [AppleStockInfo]()
        do {
         let json = try JSONSerialization.jsonObject(with: data, options: [])
        if let appleStocks = json as? [[String: Any]] {
            for item in appleStocks {
                if let appleStock = AppleStockInfo(dict: item) {
                appleStockArr.append(appleStock)
                }
            }
            }
        
        } catch {
            print(error)
        }
         return appleStockArr
    }
}

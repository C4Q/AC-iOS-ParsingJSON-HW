//
//  Stock.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Stock {
    let date: String
    let open: Double?
    let close: Double?
    init(date: String, open: Double, close: Double) {
        self.date = date
        self.open = open
        self.close = close
    }
    var headerDate: String {
        let dateArray = date.components(separatedBy: "-")
        let year = dateArray[0]
        let month = dateArray[1]
        let monthCode: [String:String] = ["01":"January", "02":"February", "03":"March", "04":"April", "05":"May", "06":"June", "07":"July", "08":"August", "09":"September", "10":"October", "11":"November", "12":"December"]
        return "\(monthCode[month]!) - \(year)"
    }
    
    
    convenience init?(from jsonDict: [String:Any]) {
        guard let date = jsonDict["date"] as? String else {return nil}
        let open = jsonDict["open"] as? Double
        let close = jsonDict["close"] as? Double
        self.init(date: date, open: open!, close: close!)
    }
    static func getStock(from data: Data) -> [Stock] {
        var stocks = [Stock]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let stockArray = json as? [[String: Any]] {
                for stockDict in stockArray {
                    if let stock = Stock(from: stockDict) {
                        stocks.append(stock)
                    }
                }
            }
        }
        catch {
            print("Error converting data to JSON")
        }
        return stocks
    }        
}

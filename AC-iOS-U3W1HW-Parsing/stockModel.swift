//
//  stockModel.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Richard Crichlow on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Stock {
    var date: String
    var open: Double
    var change: Double
    
    init(date: String, open: Double, change: Double) {
        self.date = date
        self.open = open
        self.change = change
    }
    
    
    convenience init?(withDict dict: [String:Any]) {
        
        if let date = dict["date"] as? String,
            let open = dict["open"] as? Double,
            let change = dict["change"] as? Double {
            self.init(date: date, open: open, change: change)
        } else {
            print("There were nils in your Stock JSON")
            return nil
        }
    }
    static func getStock(from data: Data) -> [Stock]? {
        var stockInfo = [Stock]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonDict = json as? [[String:Any]] else {return nil}
            for stock in jsonDict {
                if let stockReport =  Stock(withDict: stock) {
                    stockInfo.append(stockReport)
                }
            }
            return stockInfo
        }
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
/*
 
 
 for elements in weatherArr {
 if let weatherReport = Weather(from: elements) {
 weather.append(weatherReport)
 }
 }
 } catch {
 print("error: \(error.localizedDescription)")
 }
 return weather
 }
 */

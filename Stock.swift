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
    
    var sectionNames: String {
        var dateArr = date.split(separator: "-")
        let year = dateArr[0]
        var month = String(dateArr[1])
        switch month {
        case "01":
            month = "January"
        case "02":
            month = "February"
        case "03":
            month = "March"
        case "04":
            month = "April"
        case "05":
            month = "May"
        case "06":
            month = "June"
        case "07":
            month = "July"
        case "08":
            month = "August"
        case "09":
            month = "September"
        case "10":
            month = "October"
        case "11":
            month = "November"
        case "12":
            month = "December"
        
        default:
            print("n/a")
            
            
        }


        return "\(month) - \(year)"
    }
    
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


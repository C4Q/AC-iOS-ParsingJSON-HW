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
    var sectionNameNeedAverage: String {
        var dateAsArr = date.split(separator: "-")
        let year = dateAsArr[0]
        let month = String(dateAsArr[1])
        return "\(months[month]!)-\(year)"
   
      
    }
    let months = ["01": "January", "02": "February", "03": "March", "04": "April", "05": "May", "06": "June", "07": "July", "08": "August", "09": "September", "10": "October", "11": "November", "12": "December"]
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
    
//    static func getStocks(from data: Data) -> ([String], [String: [Stock]]){
//        var stocksDictionary = [String: [Stock]]()
//        var sectionArray = [String]()
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: [])
//            guard let jsonDictArr = json as? [[String: Any]] else {return (sectionArray, stocksDictionary)}
//            for jsonDict in jsonDictArr {
//                if let newStock = Stock.init(from: jsonDict) {
//                    if stocksDictionary[newStock.sectionNameNeedAverage] == nil {
//                        stocksDictionary[newStock.sectionNameNeedAverage] = []
//                        sectionArray.append(newStock.sectionNameNeedAverage)
//                        var average = [Double]()
//                        for (stock, value) in stocksDictionary {
//                            var counter = 0
//                            for open in value {
//                                counter += 1
//                                var addingValues: Double = 0.0
//                                addingValues += open.open
//                                (addingValues)/(Double(counter))
//
//                            }
    //                    stocksDictionary[newStock.sectionNameNeedAverage]?.append(newStock)
//
//
//                        }
    static func getStocks(from data: Data) -> [Stock] {
        var stocks = [Stock]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let stockDictArray = json as? [[String:Any]] else {return []}
            for stockDict in stockDictArray {
                if let newStock = Stock(from: stockDict) {
                    stocks.append(newStock)
                }
            }
        }
        catch {
            print("error")
        }
        return stocks
    }
    static func averageOfMonth(stockArr: [Stock]) -> Double {
        return(stockArr.reduce(0.0){$0 + $1.open})/Double(stockArr.count)
    }
}

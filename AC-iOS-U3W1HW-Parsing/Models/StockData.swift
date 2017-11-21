//
//  StockData.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Reiaz Gafar on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Stock: Codable {
    var date: String
    var open: Double
    var close: Double
    var label: String
    
    init?(from dict: [String : Any]) {
        guard let date = dict["date"] as? String else { return nil }
        guard let open = dict["open"] as? Double else { return nil }
        guard let close = dict["close"] as? Double else { return nil }
        guard let label = dict["label"] as? String else { return nil }
        self.date = date
        self.open = open
        self.close = close
        self.label = label
    }
    
    
    static func populateStockData() -> [Stock] {
        var appleStocks = [Stock]()
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let stockArray = json as? [[String : Any]] {
                        for stock in stockArray {
                            if let stock = Stock(from: stock) {
                                appleStocks.append(stock)
                            }
                        }
                    }
                } catch {
                    print("Error converting json")
                }
            }
        }
        return appleStocks
    }
    
    static func stocksByMonth(stocks: [Stock]) -> [[Stock]] {
        var stockMatrix = [[Stock]]()
        
        var newMonthCheck = ""
        var indexCounter = 0
        for stock in stocks {
            let dateArray = stock.date.components(separatedBy: "-")
            if dateArray[1] != newMonthCheck {
                indexCounter += 1
                newMonthCheck = dateArray[1]
                stockMatrix.append([Stock]())
            }
                stockMatrix[indexCounter - 1].append(stock)
            
        }
        return stockMatrix
    }
    
    static func getMonthlyAverages(stocks: [Stock]) -> [String : Double] {
        var monthlyAverage = [String : Double]()
        var sum: Double = 0
        var counter: Double = 0
        var newMonthCheck = ""
        for stock in stocks {
            let dateArray = stock.date.components(separatedBy: "-")
            
            if dateArray[0] + dateArray[1] != newMonthCheck {
                newMonthCheck = dateArray[0] + dateArray[1]
                sum = 0
                counter = 0
            }
            counter += 1
            sum += stock.open
            
            monthlyAverage[dateArray[0] + dateArray[1]] = sum / counter
        }
        return monthlyAverage
    }
    
}


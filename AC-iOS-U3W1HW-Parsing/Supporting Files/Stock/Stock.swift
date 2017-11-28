//
//  Stock.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Masai Young on 11/15/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

struct Stock {
    let change: Double
    let close: Double
    let date: String
    let open: Double
    
    var dateComponents: DateComponents {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:self.date)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return components
    }
    
    var formattedDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:self.date)!
        return date
    }
    
    var standaloneMonth: String {
        let formatter = DateFormatter()
        let monthComponents = formatter.standaloneMonthSymbols
        return monthComponents![self.dateComponents.month! - 1]
    }
    
    var ordinalNumber: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        let number = formatter.string(from: NSNumber(value: self.dateComponents.day!))
        return number!
    }
    
    var dateHash: String {
        return String(self.dateComponents.year!) + "." + String(self.dateComponents.month!)
    }
    
    init(stats: [String: Any]) {
        change = stats["change"] as? Double ?? 0.0
        close = stats["close"] as? Double ?? 0.0
        date = stats["date"] as? String ?? "No date"
        open = stats["open"] as? Double ?? 0.0
    }
    
    func color() -> UIColor {
        return self.change < 0 ? UIColor(red:0.73, green:0.07, blue:0.11, alpha:1.00) : UIColor(red:0.16, green:0.63, blue:0.31, alpha:1.00)
    }
    
    func thumbnail() -> String {
        return self.change < 0 ? "downarrow" : "uparrow"
    }
    
    func mainImage() -> UIImage {
        return self.change < 0 ? #imageLiteral(resourceName: "stockDown") : #imageLiteral(resourceName: "stockUp")
    }
    
    static func averageOpeningPrice(_ section: Int, _ data: [[Stock]]) -> String {
        let prices = data[section]
        let sum = prices.reduce(0.0, {$0 + $1.open})
        let average = sum / Double(prices.count)
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = 3
        let result = formatter.string(from: NSNumber(value: average))
        return result!
    }
    
    static func monthAndYear(_ section: Int, _ data: [[Stock]]) -> String {
        let formatter = DateFormatter()
        let monthComponents = formatter.standaloneMonthSymbols
        let currentMonth = monthComponents![(data[section].first?.dateComponents.month)! - 1]
        let currentYear = data[section].first!.dateComponents.year!
        return currentMonth + " \(currentYear)"
    }
    
    static func groupByDate(list: [Stock]) -> [[Stock]] {
        var organizedStocks = [String: [Stock]]()
        for stock in list {
            let noEntryOfThisDate = organizedStocks[stock.dateHash] == nil
            if noEntryOfThisDate {
                organizedStocks[stock.dateHash] = [stock]
            } else {
                organizedStocks[stock.dateHash]?.append(stock)
            }
        }
        
        var sortedOrganizedStock = [[Stock]]()
        for stockArray in organizedStocks.values {
            sortedOrganizedStock.append(stockArray)
        }
        
        return sortedOrganizedStock.sorted{($0.first?.formattedDate)! < ($1.first?.formattedDate)!}
    }
    
    static func fetchStocks() -> [Stock]? {
        var statArr = [Stock]()
        guard let filepath = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
            fatalError()
        }
        
        let url = URL(fileURLWithPath: filepath)
        if let data = try? Data(contentsOf: url) {
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                guard let listOfStats = json as? [[String: Any]] else { return nil }
                
                for stat in listOfStats {
                    statArr.append(Stock(stats: stat))
                }
                
            } catch {
                print(error)
            }
        }
        return statArr
    }
}

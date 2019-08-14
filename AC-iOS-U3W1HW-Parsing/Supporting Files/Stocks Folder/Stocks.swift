//
//  Stocks.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Ashlee Krammer on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Stocks {
    var date: String
    var open: Double
    var close: Double
    
    init(date: String, open: Double, close: Double) {
        self.date = date
        self.close = close
        self.open = open
    }
    
    
    convenience init?(from dict: [String:Any]) {
        let date = dict["date"] as? String
        let open = dict["open"] as? Double
        let close = dict["close"] as? Double
        
        self.init(date: date!, open: open!, close: close!)
        
    }
    
    static func getStocks(from data: Data) -> [Stocks]{
        var stocks = [Stocks]()
        
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let jsonDictArr = json as? [[String:Any]] else {return []}
            
            for jsonDict in jsonDictArr {
                if let newStock = Stocks.init(from: jsonDict){
                    stocks.append(newStock)
                }
            }
            
        }catch {
            print(error)
        }
     return stocks
    }
}







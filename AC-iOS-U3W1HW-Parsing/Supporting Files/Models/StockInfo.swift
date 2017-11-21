//
//  StockInfo.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
///Downcasting

class StockInfo {
    //what properties do we want to include
    let date: String?
    let openingAmount: Double
    let closingAmount: Double
    
    var theSectionNames: String {
        var dateAsArr = date?.split(separator: "-")
        let year = dateAsArr![0]
        let month = String(dateAsArr![1])
        return "\(months[month]!)-\(year)"
    }
    
    let months = ["01": "January", "02": "February", "03": "March", "04": "April", "05": "May", "06": "June", "07": "July", "08": "August", "09": "September", "10": "October", "11": "November", "12": "December"]
    
    
    init(date: String?, openingAmount: Double, closingAmount: Double) {
        self.date = date
        self.openingAmount = openingAmount
        self.closingAmount = closingAmount
    }
    
    //failable convenience initialzer
    //how to make a stock profile from a JSON Dictionary mapping [String: Any]
    convenience init?(from jsonDict: [String:Any]){
        //my decision: if we don't have an openingAmount or closingAmount then do not make the stock profile at all
        //name in jsonDict must match the name of the key in the json file
        guard
            let openingAmount = jsonDict["open"] as? Double,
            let closingAmount = jsonDict["close"] as? Double
            else{
                return nil
        }
        let date = jsonDict["date"] as? String
        
        //go deeper and get any other information if needed
        
        self.init(date: date, openingAmount: openingAmount, closingAmount: closingAmount)
    }
    
    //Parsing how to turn data into an array of stock profiles
    static func createArrayOfStock(from data: Data) -> [StockInfo]? { //possibility of not finding an [StockInfo]
        var stockProfile: [StockInfo] = []
        //serialize buy converting json into foundation
        //put in a do catch
        ///what is this saying!!!!?!?!?!?!
        do {
            // do make sure that stockJSONArray tries to serailize the json with data as an array of dictionaries mapping String: Any. If not, return nil
            guard let stockJSONArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] else {return nil}
            //turning into object: iterate through array and append stock info into stock profile
            for stockDict in stockJSONArray{
                if let thisStock = StockInfo(from: stockDict){
                    stockProfile.append(thisStock)
                }
            }
        } catch {
            print("Error converting data to JSON")
        }
        return stockProfile
    }
}

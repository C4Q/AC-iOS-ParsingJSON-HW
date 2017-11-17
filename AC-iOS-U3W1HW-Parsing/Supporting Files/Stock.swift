//  Stock.swift
//  AC-iOS-U3W1HW-Parsing
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.

import Foundation

class Stock {
	let date: String //"2015-11-11"
	let open: Double //116.37,
	let close: Double //116.11
	let change: Double //-0.66

	init(date: String, open: Double, close: Double, change: Double) {
		self.date = date
		self.open = open
		self.close = close
		self.change = change
	}
	
	convenience init?(from jsonDict: [String: Any]) {
		guard let date = jsonDict["date"] as? String else { return nil }
		guard let open = jsonDict["open"] as? Double else { return nil }
		guard let close = jsonDict["close"] as? Double else { return nil }
		guard let change = jsonDict["change"] as? Double else { return nil }
		self.init(date: date, open: open, close: close, change: change)
	} //end of Convenience init
	
	static func getStocks(from data: Data) -> [Stock] {
		var stocks = [Stock]()
		do {
			let json = try JSONSerialization.jsonObject(with: data, options: []) //json is now an arra of dictionary
			if let stockDictArray = json as? [[String:Any]] {
				for stockDict in stockDictArray {
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


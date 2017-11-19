//  Stock.swift
//  AC-iOS-U3W1HW-Parsing
//  Created by Winston Maragh on 11/16/17.
//  Copyright © 2017 Winston Maragh. All rights reserved.

import Foundation

class Stock {
	let date: String
	let open: Float
	let close:Float
	let low: Float
	let high: Float
	let volume: Int
	
	var sectionHeader: String { return monthYear }
	
	var monthYear: String {
		enum Month: Int {
			case January = 01, February, March, April, May, June, July, August, September, October, November, December
		}
		let year: String = String(date[date.index(date.startIndex, offsetBy: 0)..<date.index(date.endIndex, offsetBy: -6)])
		let month = Int((date[date.index(date.startIndex, offsetBy: 5)..<date.index(date.endIndex, offsetBy: -3)]))
		return "\(Month.init(rawValue: month!)!) \(year)"
	}
	
	/*
	var monthYear: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "YYYY-MM-DD"
		let inputDate = dateFormatter.date(from: date)
		dateFormatter.dateFormat = "MMMM, YYYY"
		let monthYear = dateFormatter.string(from: inputDate!)
		return monthYear
	}

	var shortDate: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "YYYY-MM-DD"
		let inputDate = dateFormatter.date(from: date)
		dateFormatter.dateFormat = "MMM dd, YYYY"
		let shortDate = dateFormatter.string(from: inputDate!)
		return shortDate
	}
	
	var longDate: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "YYYY-MM-DD"
		let inputDate = dateFormatter.date(from: date)
		dateFormatter.dateFormat = "MMM dd, YYYY"
		let longDate = dateFormatter.string(from: inputDate!)
		return longDate
	}
	*/
	
	init(date: String, open: Float, close: Float, low: Float, high: Float, volume: Int) {
		self.date = date
		self.open = open
		self.close = close
		self.low = low
		self.high = high
		self.volume = volume
	}
	
	convenience init?(from jsonDict: [String: Any]) {
		guard
			let date = jsonDict["date"] as? String,
			let open = jsonDict["open"] as? Float,
			let close = jsonDict["close"] as? Float,
			let low = jsonDict["low"] as? Float,
			let high = jsonDict["high"] as? Float,
			let volume = jsonDict["volume"] as? Int
		else {
			return nil
		}
		self.init(date: date, open: open, close: close, low: low, high: high, volume: volume)
	}
	
	static func getStocks(from data: Data) -> [Stock] {
		var stocks = [Stock]()
		do {
			guard let stocksJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] else {return []}
			for stockDict in stocksJSON {
				if let stock = Stock(from: stockDict) {
					stocks.append(stock)
				}
			}
		}
		catch {
			print(error)
		}
		return stocks
	}
}

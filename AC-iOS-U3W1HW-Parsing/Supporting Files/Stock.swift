//  Stock.swift
//  AC-iOS-U3W1HW-Parsing
//  Created by Winston Maragh on 11/16/17.
//  Copyright © 2017 Winston Maragh. All rights reserved.

import Foundation

class Stock {
	let date: String //2015-11-31
	let open: Float
	let close:Float
	let low: Float
	let high: Float
	let volume: Int
	let monthYearDate: String
	let shortDate: String
	let longDate: String
	var sectionHeader: String { return monthYearDate }
	
	//UPDATE: use built-in DateFormatter to create custom Date formats
	static func buildDateFormatter(dateFormat: String) -> DateFormatter {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = dateFormat
		return dateFormatter
	}
	static let inputDateFormatter = buildDateFormatter(dateFormat: "yyyy-MM-dd")
	static let monthYearDateFormatter = buildDateFormatter(dateFormat: "MMMM, yyyy") //November 2015
	static let shortDateFormatter = buildDateFormatter(dateFormat: "MMM dd, YYYY")//Nov 13, 2015
	static let longDateFormatter = buildDateFormatter(dateFormat: "MMMM dd, yyyy") //November 13, 2015
	
	init(date: String, open: Float, close: Float, low: Float, high: Float, volume: Int) {
		self.date = date
		self.open = open
		self.close = close
		self.low = low
		self.high = high
		self.volume = volume
		
		if let inputDate = Stock.inputDateFormatter.date(from: self.date) {
			self.monthYearDate = Stock.monthYearDateFormatter.string(from: inputDate)
			self.shortDate = Stock.shortDateFormatter.string(from: inputDate)
			self.longDate = Stock.longDateFormatter.string(from: inputDate)
		} else {
			self.monthYearDate = "invalid date"
			self.shortDate = "invalid date"
			self.longDate = "invalid date"
		}
		return
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

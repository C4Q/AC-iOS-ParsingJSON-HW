//  AppleVC.swift
//  AC-iOS-U3W1HW-Parsing
//  Created by Winston Maragh on 11/16/17.
//  Copyright © 2017 Winston Maragh. All rights reserved.

import UIKit

class StocksVC: UIViewController, UITableViewDelegate {
	
	//MARK: - Outlets
	@IBOutlet weak var stockTableView: UITableView!
	
	//MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		stockTableView.dataSource = self
		getStockData()
	}
	
	//MARK: - Variables/Constants
	var stocks = [Stock]()
	var stocksSectionHeaders: [String] = []
	var avgOpenStr = ""
	
	//MARK: - Functions
	func getStockData() {
		if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
			let url = URL(fileURLWithPath: path)
			if let data = try? Data(contentsOf: url) {
				let stocks = Stock.getStocks(from: data).sorted { $0.date > $1.date }
				self.stocks = stocks
				self.getStocksSectionHeaders()
						DispatchQueue.main.async {
							self.stockTableView.reloadData()
						}
			}
		}
	}
	
}

//MARK: - Section Headers
extension StocksVC {
	func getStocksSectionHeaders() {
		for currentStock in stocks {
			if !stocksSectionHeaders.contains(currentStock.sectionHeader){
				stocksSectionHeaders.append(currentStock.sectionHeader)
			}
		}
	}
	
	func stocksSection(_ section: Int) -> [Stock] {
		return stocks.filter { $0.sectionHeader == stocksSectionHeaders[section] }
	}
}

//MARK: - stocksTableView - DataSource Methods
extension StocksVC: UITableViewDataSource {
	func numberOfSections(in stockTableView: UITableView) -> Int {
		return stocksSectionHeaders.count //25
	}
	
	func tableView(_ stockTableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		var prices = [Float]()
		//use a dictionary to cut down time - only need to create  the dictionary once, then just call the key here
		let sectionStocks = stocks.filter { $0.sectionHeader == stocksSectionHeaders[section] }
		sectionStocks.forEach {prices.append($0.open)} //append each value to an array
		avgOpenStr = String(format:"Avg: $%.2f", (prices.reduce(0, +) / Float(prices.count)))
		return ("\(stocksSectionHeaders[section]) - \(avgOpenStr)")
		
		/* -- if I use dictionary to model
		var myOpenDict = [String: [Float]]() //creating a dictionary with String key, and array of open price values
		
		//adding to the dictionary
		myOpenDict = ["January 2015" : [20.5, 40.5, 30.6, 60.6], "February 2015" : [20.5, 40.5, 30.6, 60.6], "March 2015" : [20.5, 40.5, 30.6, 60.6]]
		
		var sectionHeader = "January 2015"
		var avgOfNumsInSection = myOpenDict[sectionHeader]!.reduce(0, +) / Float(myOpenDict[sectionHeader]!.count)
		print(avgOfNumsInSection)
		*/
		
	}
	
	func tableView(_ stockTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return stocksSection(section).count
	}
	
	func tableView(_ stockTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = stockTableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
		let currentSection = stocksSection(indexPath.section)
		let currentStock = currentSection[indexPath.row]
		cell.textLabel?.text = currentStock.shortDate
		cell.detailTextLabel?.text = String(format:"Open: $%.2f", currentStock.open)
		return cell
	}
}

//MARK: - Navigation - Segue
extension StocksVC {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard
			let destinationDVC = segue.destination as? StocksDVC,
			let stockCell = sender as? UITableViewCell,
			let currentIndexPath = stockTableView.indexPath(for: stockCell)
			else {return}
		let stocksSection = self.stocksSection(currentIndexPath.section)
		let currentStock = stocksSection[currentIndexPath.row]
		destinationDVC.stock = currentStock
	}
}

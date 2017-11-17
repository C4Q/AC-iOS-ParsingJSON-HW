//  AppleVC.swift
//  AC-iOS-U3W1HW-Parsing
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.

import UIKit

class StocksVC: UIViewController, UITableViewDelegate {
	
	//MARK: - Outlets
	@IBOutlet weak var stockTableView: UITableView!
	
	//MARK: - Variables/Constants
	var stocks = [Stock]()

	//MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		stockTableView.dataSource = self
		stockTableView.delegate = self
		loadStockData()
	}
	
	//MARK: - Functions
	func loadStockData() {
		if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
			let myURL = URL(fileURLWithPath: path)
			if let data = try? Data(contentsOf: myURL) {				
				let stocks = Stock.getStocks(from: data).sorted { $0.date > $1.date }
				self.stocks = stocks
			}
		}
	}
	
	//MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? StocksDVC {
			let row = stockTableView.indexPathForSelectedRow!.row
			destination.stock = stocks[row]
		}
	}
}

//MARK: - tableView - Data Source Methods
extension StocksVC: UITableViewDataSource {

	
	/*
	func numberOfSections(in tableView: UITableView) -> Int {
			return months.count
	}
	*/
	
	/*
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
	
	}
	*/
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return stocks.count //
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let stock = stocks[indexPath.row]
		let cell = self.stockTableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
		cell.textLabel?.text = stock.date
		cell.detailTextLabel?.text = String(stock.close)
		return cell
	}
	
}


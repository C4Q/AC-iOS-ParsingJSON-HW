//  AppleVC.swift
//  AC-iOS-U3W1HW-Parsing
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.

import UIKit

class StocksVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
	
	@IBOutlet weak var stockTableView: UITableView!
	
	var stocks = [Stock]()

	
	override func viewDidLoad() {
		super.viewDidLoad()
		stockTableView.dataSource = self
		stockTableView.delegate = self
		loadStockData()
	}
	
	func loadStockData() {
		if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
			let myURL = URL(fileURLWithPath: path)
			if let data = try? Data(contentsOf: myURL) {
				do {
					let results = try [JSONDecoder().decode(Stock.self, from: data)]
					self.stocks = results
				}
				catch {
					print(error)
				}
			}
		}
	}
	
	//MARK: - Data Source Methods
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
	
	//MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? StocksDVC {
			let row = stockTableView.indexPathForSelectedRow!.row
			destination.stock = stocks[row]
		}
	}
}










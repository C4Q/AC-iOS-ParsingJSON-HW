//
//  StocksViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var stockTableView: UITableView!
    
    
    var stocks = [Stock]()
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                self.stocks = Stock.getStocks(from: data)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let stock = stocks[indexPath.row]
        let cell = self.stockTableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = stock.open.description
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.stockTableView.delegate = self
        self.stockTableView.dataSource = self 

        // Do any additional setup after loading the view.
    }


}

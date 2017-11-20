//
//  StocksListViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksListViewController: UIViewController {

    @IBOutlet weak var stocksTableView: UITableView!
    
    var stocks: [Stock] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        stocksTableView.delegate = self
        stocksTableView.dataSource = self
    }
    
    func getData() {
        guard let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") else {
            print("Error: could not get json path")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        guard let data = try? Data(contentsOf: url) else {
            print("Error: could not get data from url")
            return
        }
        
        stocks = Stock.getStocks(from: data)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //to do
    }
    
}

//MARK: - Table View Methods
extension StocksListViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Table View Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        
        performSegue(withIdentifier: "detailedSegue", sender: selectedCell)
    }
    
    //Table View Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        
        //to do
        
        return cell
    }
}

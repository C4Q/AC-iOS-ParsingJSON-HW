//
//  StocksViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
   var stocksDictionary = [String: [Stock]]()
    var dates: [Stock] = []
    var sectionArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        loadData()
        //  func getSectionNames() {
//        for beer in beerList {
//            if !sectionNames.contains(beer.sectionName) {
//                sectionNames.append(beer.sectionName)
//            }
//        }
//    }
      
//            gotSeasons.append(GOTEpisode.allEpisodes.filter{$0.season == season})     // this is  magic that will filter items if the season is the same as the season we are searching, spits out an array of these items and then you append this array into our array of arrays
//        }
        // Do any additional setup after loading the view.
    }
//    func getStockDate() {
//        for stock in stocks {
//            if !dates.contains(stock.sectionNameNeedAverage) {
//            dates.append(stock.sectionNameNeedAverage)
//        }
//    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let args = Stock.getStocks(from: data)
                self.stocksDictionary = args.1
                self.sectionArray = args.0
            }

        }
    }
}

extension StocksViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return stocksDictionary.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  stocksDictionary[sectionArray[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Stock Cell", for: indexPath)
        let selectedRow = indexPath.row
        let selectedSection = indexPath.section
        let selectedStock = stocksDictionary[sectionArray[selectedSection]]![selectedRow]
        print(selectedStock)
        cell.textLabel?.text = selectedStock.date
        cell.detailTextLabel?.text = selectedStock.close.description
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(self.sectionArray[section])"
    }
    
}



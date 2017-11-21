//
//  APPLStockViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class APPLStockViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
  var appleStockArr = [AppleStockInfo]()
    var sectionNames = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     loadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
  
    func loadData() {
        if let path = Bundle.main.path(forResource: "applstockinfo", ofType: "json") {
            let myUrl = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myUrl) {
                let array = AppleStockInfo.getData(from: data)
                self.appleStockArr = array.sorted(by: {$0.date.split(separator: "-").joined(separator: "") < $1.date.split(separator: "-").joined(separator: "")})
                
            }
        }
        for item in appleStockArr {
            if !sectionNames.contains(item.session) {
                sectionNames.append(item.session)
            }
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sumOfOpen: Double = 0
       let dictInSection = appleStockArr.filter({$0.session == sectionNames[section]})
        for item in dictInSection {
        sumOfOpen += item.open
        }
        let roundedNumber = String(format: "%.2f", sumOfOpen / Double(dictInSection.count))
        return "\(sectionNames[section])    Average Open: \(roundedNumber)"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return appleStockArr.filter({$0.session == sectionNames[section]}).count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stock cell", for: indexPath)
       // cell.textLabel.text = appleStockArr
        let dictInsecton = appleStockArr.filter({$0.session == sectionNames[indexPath.section]})
        let itemInRow = dictInsecton[indexPath.row]
        cell.textLabel?.text = itemInRow.date
        cell.detailTextLabel?.text = itemInRow.open.description
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailAPPLStockViewController {
            let selectedIndex = tableView.indexPathForSelectedRow!
            let selectedStock = appleStockArr.filter({$0.session == sectionNames[selectedIndex.section]})[selectedIndex.row]
            destination.stock = selectedStock
        }
    }


}

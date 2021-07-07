//  StockDVC.swift
//  AC-iOS-U3W1HW-Parsing
//  Created by Winston Maragh on 11/16/17.
//  Copyright © 2017 Winston Maragh. All rights reserved.

import UIKit

class StocksDVC: UIViewController {

	//Outlets
	@IBOutlet weak var stockDate: UILabel!
	@IBOutlet weak var stockOpen: UILabel!
	@IBOutlet weak var stockClose: UILabel!
	@IBOutlet weak var thumbsImage: UIImageView!
	@IBOutlet weak var stockRange: UILabel!
	@IBOutlet weak var stockVolume: UILabel!
	
	//Variables/Constants
	var stock: Stock!
	
	//Mark: - Overrides
    override func viewDidLoad() {
		super.viewDidLoad()
		loadData()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		loadData()
	}
	
	func loadData() {
		stockDate.text = stock.longDate
		stockOpen.text = String(format:"Open: $%.2f", stock.open)
		stockClose.text = String(format:"Close: $%.2f", stock.close)
		stockVolume.text = "Volume: \(stock.volume)"
		stockRange.text = String(format:"Range: $%.2f - $%.2f", stock.low, stock.high)
		if (stock!.close) - (stock.open) > 0.0 {
			view.backgroundColor = UIColor.green
			thumbsImage.image = #imageLiteral(resourceName: "thumbsUp")
		} else {
			view.backgroundColor = UIColor.red
			thumbsImage.image = #imageLiteral(resourceName: "thumbsDown")
		}
	}
	
}

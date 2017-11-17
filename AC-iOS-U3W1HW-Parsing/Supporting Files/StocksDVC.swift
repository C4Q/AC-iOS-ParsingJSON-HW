//
//  StockDVC.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StocksDVC: UIViewController {

	//Outlets
	@IBOutlet weak var stockDate: UILabel!
	@IBOutlet weak var stockOpen: UILabel!
	@IBOutlet weak var stockClose: UILabel!
	@IBOutlet weak var thumbsImage: UIImageView!
	
	//Variables/Constants
	var stock: Stock?
	
	//Mark: - Override
    override func viewDidLoad() {
		super.viewDidLoad()
		loadData()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		loadData()
	}
	
	//Actions
	func loadData() {
		//set labels - date, open, close, image, background color (view.backgroundColor)
		view.backgroundColor = UIColor.green
	}
	
}




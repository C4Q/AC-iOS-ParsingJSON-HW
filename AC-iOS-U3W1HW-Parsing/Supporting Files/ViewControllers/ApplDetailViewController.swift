//
//  ApplDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Clint Mejia on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ApplDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var stockImageView: UIImageView!
    @IBOutlet var stockLabels: [UILabel]!
    
    // MARK: - Variables
    var selectedStock: ApplStock? = nil
    
    // MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
    }
    
    // MARK: - Functions
    func setupInitialView() {
        guard let selectedStock = selectedStock else { return }
        self.stockImageView.image = UIImage(named: selectedStock.image)
        view.backgroundColor = (selectedStock.image.contains("up")) ? UIColor.green : UIColor.red
        for label in stockLabels {
            switch label.tag {
            case 0:
                label.text = "\(selectedStock.date)"
            case 1:
                label.text = String(format: "Open:  $%.02f", selectedStock.open)
            case 2:
                label.text = String(format: "Close:  $%.02f", selectedStock.close)
            case 3:
                label.text = String(format: "Low:  $%.02f", selectedStock.low)
            case 4:
                label.text = String(format: "High:  $%.02f", selectedStock.high)
            case 5:
                label.text = String(format: "Change:  %.02f", selectedStock.change)
            default:
                break
            }
        }
    }
}


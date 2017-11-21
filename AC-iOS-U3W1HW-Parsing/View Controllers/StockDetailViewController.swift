//
//  StockDetailViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Reiaz Gafar on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {
    
    @IBOutlet weak var stockImageView: UIImageView!
    @IBOutlet weak var stockDateLabel: UILabel!
    @IBOutlet weak var stockOpenAmountLabel: UILabel!
    @IBOutlet weak var stockCloseAmountLabel: UILabel!
    
    var stock: Stock?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let stock = stock else { return }
        
        stockDateLabel.text = stock.date
        stockOpenAmountLabel.text = stock.open.description
        stockCloseAmountLabel.text = stock.close.description
        
        if stock.open < stock.close {
            stockImageView.image = #imageLiteral(resourceName: "thumbsUp")
            self.view.backgroundColor = .green
        } else {
            stockImageView.image = #imageLiteral(resourceName: "thumbsDown")
            self.view.backgroundColor = .red
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

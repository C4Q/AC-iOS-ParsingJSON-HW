//
//  DetailedContactsViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Ashlee Krammer on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class DetailedContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var person: Person!
    
    //Outlets
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        if let pictureURL = URL(string: person.picture.large) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: pictureURL) {
                    DispatchQueue.main.async {
                        self.contactImage.image = UIImage(data: data)
                    }
                }
            }
        }
        
        loadData()
    }

    
    
    func loadData(){
        nameLabel.text = "\(person.name.first.capitalized) \(person.name.last.capitalized)"
    }
    

    
    //Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //Cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Info Cell", for: indexPath)
        cell.textLabel?.text = "Phone: " +
            person.phone!
        cell.detailTextLabel?.text = "Email: " + person.email!
        
        
        
        
        return cell
    }
    
    
    

}

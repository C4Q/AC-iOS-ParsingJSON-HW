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
    var personalInfo = [String]()

    
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
        
        let address = "\(person.location.street.capitalized), \(person.location.city.capitalized), \(person.location.street.capitalized), \(person.location.postcode))"
        let info = [person.phone?.description, person.cell?.description, person.email, address]
        
        for info in info {
            personalInfo.append(info!)
        }
            
            
            
            
        loadData()
    }

  
    
    
    func loadData(){
        nameLabel.text = "\(person.name.first.capitalized) \(person.name.last.capitalized)"
    }
    

    
    //Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personalInfo.count
    }
    
    //Cell
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Info Cell", for: indexPath)
        
        let setupInfo = personalInfo[indexPath.row]
        
    
        if setupInfo == personalInfo[0] {
            cell.textLabel?.text = "Phone: "
        } else if setupInfo == personalInfo[1] {
            cell.textLabel?.text = "Cell Phone: "
        } else if setupInfo == personalInfo[2] {
            cell.textLabel?.text = "Email: "
        } else if setupInfo == personalInfo[3] {
            cell.textLabel?.text = "Address: "
        }
        
        

        cell.detailTextLabel?.text = setupInfo
        

        
        
        return cell
    }
    
    
    

}

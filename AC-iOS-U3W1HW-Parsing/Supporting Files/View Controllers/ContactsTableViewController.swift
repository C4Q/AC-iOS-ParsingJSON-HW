//
//  ContactsTableViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

//searchbar


class ContactsTableViewController: UIViewController {
    
    var contacts = [Person]()
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.dataSource = self
        getContactsData()
    }
    
    func getContactsData() {
        if let path = Bundle.main.path(forResource: "ContactInfo", ofType: "json"){
            let myUrl = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myUrl){
                let myDecoder = JSONDecoder()
                do {
                    let allContacts = try myDecoder.decode(ContactInfo.self, from: data)
                    self.contacts = allContacts.results
                    
                } catch let error{
                    print(error)
                }
            }
        }
        for person in contacts {
            print(person.name, person.email, person.location)
        }
    }
}

extension ContactsTableViewController: UITableViewDataSource {
    //sorting names alphabetically
    //self.contacts.sort(){$0.name.first < $1.name.last}
    
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Person Cell", for: indexPath)
        let person = contacts[indexPath.row]
        
        cell.textLabel?.text = person.name.first.capitalized + " " + person.name.last.capitalized
        cell.detailTextLabel?.text = person.location.city
        
        //add thumbnail picture
        
        return cell
    }
    
    
    
}
    
    
    
    
    
    
    
    
    
    
    
    


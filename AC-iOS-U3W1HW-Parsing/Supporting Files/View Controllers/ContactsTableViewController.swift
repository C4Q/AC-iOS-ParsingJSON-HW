//
//  ContactsTableViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/15/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {

    //MARK: - Variables
    var formattedContactsArray = [FormattedContact]()
    
    @IBOutlet weak var contactSearchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }

    func loadData() {
        let jsonContacts = JSONHandler.getContacts()
        for contact in jsonContacts {
            let formattedContact = FormattedContact(contact: contact)
            formattedContactsArray.append(formattedContact)
            
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return formattedContactsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let currentContact = formattedContactsArray[indexPath.row]
        
        cell.textLabel?.text = currentContact.name
        let contactImage = UIImage(named: "profileImage")
        cell.imageView?.image = contactImage
        cell.detailTextLabel?.text = currentContact.addressString
        return cell
    }
 
}

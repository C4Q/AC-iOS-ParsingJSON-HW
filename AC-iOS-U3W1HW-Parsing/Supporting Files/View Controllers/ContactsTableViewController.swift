//
//  ContactsTableViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/15/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController, UISearchBarDelegate {

    //MARK: - Variables
    var formattedContactsArray = [FormattedContact]()
    
    @IBOutlet weak var contactSearchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactSearchBar.delegate = self
        loadData()
        
    }

    func loadData() {
        let jsonContacts = JSONHandler.getContacts()
        for contact in jsonContacts {
            let formattedContact = FormattedContact(contact: contact)
            formattedContactsArray.append(formattedContact)
            
        }
    }
    
    
    //searc
    

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
        
        cell.textLabel?.text = currentContact.fullName
        
        //cell.detailTextLabel?.text = currentContact.addressString
        
        if let thumbnail = currentContact.picture.thumbnailImage {
           cell.imageView?.image = thumbnail
        } else {
            //            let contactImage = UIImage(named: "profileImage")
            //            cell.imageView?.image = contactImage
            
            currentContact.picture.getThumbnail() {
                DispatchQueue.main.async {
                    if tableView.indexPathsForVisibleRows?.contains(indexPath) == true {
                        tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
//                    if let image = currentContact.picture.thumbnailImage {
//                        if indexPath == tableView.indexPath(for: cell) {
//                            cell.imageView?.image = image
//                            cell.setNeedsLayout()
//                        }
//                    }
                    
                }
            }
        }
        return cell
    }
 
}

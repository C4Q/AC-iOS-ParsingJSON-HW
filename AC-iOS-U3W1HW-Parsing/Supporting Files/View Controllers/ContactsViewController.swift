//
//  ContactsTableViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/15/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    //MARK: - Variables
    var formattedContactsArray = [FormattedContact]()
    
    var searchTerm: String? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var filteredBySearchTermContactsArray: [FormattedContact] {
        guard let searchTerm = searchTerm, !searchTerm.isEmpty else {
            return formattedContactsArray
        }
        return formattedContactsArray.filter { $0.fullName.lowercased().contains(searchTerm.lowercased()) }
    }
    
    var sectionNames: [String] {
        var sections = [String]()
        for contact in filteredBySearchTermContactsArray {
            if !sections.contains(contact.firstLetter) {
                sections.append(contact.firstLetter)
            }
        }
        return sections
    }
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contactSearchBar: UISearchBar!
    
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        contactSearchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
        
    }

    func loadData() {
        let jsonContacts = JSONHandler.getContacts()
        for contact in jsonContacts {
            let formattedContact = FormattedContact(contact: contact)
            formattedContactsArray.append(formattedContact)
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text
        contactSearchBar.resignFirstResponder()
    }
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        contactSearchBar.resignFirstResponder()
//    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchText
    }

    func createContactSections() {
        
    }
    
    // MARK: - Table view data source

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let sectionName = sectionNames[section]
        let contactsInThisSection = filteredBySearchTermContactsArray.filter { $0.firstLetter == sectionName}
        
        return contactsInThisSection.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let sectionName = sectionNames[indexPath.section]
        let contactsInThisSection = filteredBySearchTermContactsArray.filter { $0.firstLetter == sectionName}
        
        let currentContact = contactsInThisSection[indexPath.row]
        
        cell.textLabel?.text = currentContact.fullName
        cell.imageView?.image = #imageLiteral(resourceName: "profileImage")
        //cell.detailTextLabel?.text = currentContact.addressString
        
        if let thumbnail = currentContact.picture.thumbnailImage {
           cell.imageView?.image = thumbnail
        } else {
            //            let contactImage = UIImage(named: "profileImage")
            //            cell.imageView?.image = contactImage
            
            currentContact.picture.getThumbnail() {
                DispatchQueue.main.async {
//                    if tableView.indexPathsForVisibleRows?.contains(indexPath) == true {
//                        tableView.reloadRows(at: [indexPath], with: .automatic)
//                    }
                    if let image = currentContact.picture.thumbnailImage {
                        if indexPath == tableView.indexPath(for: cell) {
                            cell.imageView?.image = image
                            cell.setNeedsLayout()
                        }
                    }
                    
                }
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }
 
}

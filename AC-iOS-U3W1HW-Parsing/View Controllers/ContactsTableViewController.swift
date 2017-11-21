//
//  ContactsTableViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Reiaz Gafar on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsTableViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var contacts = Contact.populateContacts().results
    var filteredContacts = Contact.populateContacts().results
    
    var searchText = "" {
        didSet {
            if searchText == "" {
                filteredContacts = contacts
            } else {
            filteredContacts = contacts?.filter() { ($0.name.first.lowercased() + " " +  $0.name.last.lowercased()).contains(searchText.lowercased()) }
            }
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ContactDetailViewController {
            let selectedRow = tableView.indexPathForSelectedRow?.row
            let selectedContact = filteredContacts![selectedRow!]
            destination.contact = selectedContact
        }
    }
    
    
}

extension ContactsTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = searchBar.text!
        searchBar.resignFirstResponder()
    }
    
}

extension ContactsTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let selectedContact = filteredContacts![indexPath.row]
        cell.textLabel?.text = selectedContact.name.first.capitalized + " " + selectedContact.name.last.capitalized
        cell.detailTextLabel?.text = selectedContact.location.city.capitalized
        cell.imageView?.image = #imageLiteral(resourceName: "profileImage")
 
        return cell
    }
    
}



//
//  ContactsViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Clint Mejia on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    // MARK: - Variables
    let searchController = UISearchController(searchResultsController: nil)
    var contacts = [Contact]()
    
    var searchTerm: String? {
        didSet {
            self.contactsTableView.reloadData()
        }
    }

    var filterContacts: [Contact] {
        guard let searchTerm = searchTerm, searchTerm != "" else { return contacts }
        return contacts.filter {(contact) in
            contact.name.fullName.lowercased().contains(searchTerm.lowercased())
        }
    }
    
    // MARK: - outlets
    @IBOutlet weak var contactsTableView: UITableView!
    
    // MARK: viewDidLoad Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
        getContactData()
        setupNavBar()
    }
    
    // MARK: - functions
    func getContactData() {
        guard let path = Bundle.main.path(forResource: "userinfo", ofType: "json") else { return }
        let myURL = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: myURL) else { return }
        let myDecoder = JSONDecoder()
        do {
            let contacts = try myDecoder.decode(ContactInfo.self, from: data)
            self.contacts = contacts.results.sorted{ $0.name.firstNameFormatted < $1.name.firstNameFormatted }
        }
        catch {
            print(error)
        }
    }
}

//MARK: tableView - data source methods
extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let contact = filterContacts[indexPath.row]
        cell.textLabel?.text = "\(contact.name.fullName)"
        cell.detailTextLabel?.text = contact.location.city
        return cell
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? contactDetailViewController {
            destination.selectedContact = filterContacts[contactsTableView.indexPathForSelectedRow!.row]
        }
    }
}

// MARK: - UISearchResultsUpdating and UISearchBarDelegate
extension ContactsViewController: UISearchResultsUpdating, UISearchBarDelegate  {
    
    //MARK: - for ViewDidLoad override
    func setupNavBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "search contacts"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Search Results Updating methods
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            searchTerm = nil
            return
        }
        searchTerm = text
    }
    
}



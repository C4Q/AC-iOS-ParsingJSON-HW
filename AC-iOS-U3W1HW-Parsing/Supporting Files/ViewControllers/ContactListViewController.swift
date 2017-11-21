//
//  ContactListViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {

    var contactArr = [Contact]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    ///Search Bar Filtering
    var filteredContactArr: [Contact] {
        guard let searchTerm = searchTerm, searchTerm != "" else {
            return contactArr
        }
        guard let scopeTitles = self.searchController.searchBar.scopeButtonTitles else {
            return contactArr
        }
        let selectedIndex = self.searchController.searchBar.selectedScopeButtonIndex
        let filteringTitle = scopeTitles[selectedIndex]
        switch filteringTitle {
        case "First Name":
            return contactArr.filter{$0.name.first.contains(searchTerm.lowercased())}
        case "Last Name":
            return contactArr.filter{$0.name.last.contains(searchTerm.lowercased())}
        default:
            return contactArr
        }
    }
    var searchTerm: String? {
        didSet {
            self.tableView.reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        definesPresentationContext = true
        tableView.delegate = self
        tableView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Contact"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchBar.scopeButtonTitles = ["First Name", "Last Name"]
        searchController.searchBar.delegate = self
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json"){
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    let allContactsInfo = try myDecoder.decode(ContactInfo.self, from: data)
                    self.contactArr = allContactsInfo.results
                }
                catch let error {
                    print(error)
                }
            }
        }
    }
    
    ///Mark - SearchBar
    
    func updateSearchResults(for searchController: UISearchController) {
        self.searchTerm = searchController.searchBar.text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detail = segue.destination as? ContactDetailViewController {
            let selectedRow = tableView.indexPathForSelectedRow!.row
            let selectedContact = contactArr[selectedRow]
            detail.selectedContact = selectedContact
        }
    }
}

extension ContactListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContactArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        contactArr.sort{$0.name.first < $1.name.first}
        let contact = filteredContactArr[indexPath.row]
        let contactCell = tableView.dequeueReusableCell(withIdentifier: "Contact Cell", for: indexPath)
        contactCell.textLabel?.text = "\(contact.name.first.capitalized) \(contact.name.last.capitalized)"
        contactCell.detailTextLabel?.text = "\(contact.location.city.capitalized), \(contact.location.state.capitalized)"
        return contactCell
    }
}

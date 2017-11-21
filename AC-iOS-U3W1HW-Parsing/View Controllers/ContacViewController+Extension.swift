//
//  ContacViewController+Extension.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

extension ContactViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK: TableView Datasource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = allContacts[indexPath.row]
        let contactCell = contactTableView.dequeueReusableCell(withIdentifier: "Contact Cell", for: indexPath)
        contactCell.textLabel?.text = contact.name.fullName
        contactCell.detailTextLabel?.text = contact.location.city.capitalized
        return contactCell
    }
    
    
    //MARK: - SearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.contactFiltered = searchText
    }
}

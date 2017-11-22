//
//  ContactListViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController {

    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var contacts = [ResultsWrapper]()
    
    var sortedContacts: [ResultsWrapper] {
        return contacts.sorted {$0.name.fullName < $1.name.fullName}
    }
    
    var searchedText: String? {
        didSet {
            self.contactsTableView.reloadData()
        }
    }
    
    var filteredContacts: [ResultsWrapper] {
        guard let searchWords = searchedText, searchWords != "" else {
            return sortedContacts
        }
        return sortedContacts.filter{(contact) in
            contact.name.fullName.lowercased().contains(searchWords.lowercased())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        searchBar.delegate = self
        loadData()
    }
}

extension ContactListViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    let allContacts = try myDecoder.decode(ContactInfo.self, from: data)
                    self.contacts = allContacts.results
                }
                catch {
                    print("///////////////////////////")
                    print(error)
                    print("///////////////////////////")
                }
            }
        }
        for contact in filteredContacts {
            print(contact)
        }
    }
    
    /*
    MARK: - TABLEVIEW REQUIRED METHODS
    *******************************************
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = filteredContacts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactListCell", for: indexPath)
        cell.textLabel?.text = contact.name.fullName
        cell.detailTextLabel?.text = contact.location.city.capitalized
        
        if let contactImageURL = URL(string: contact.picture.thumbnail) {
            DispatchQueue.global().async {
                if let data = try? Data.init(contentsOf: contactImageURL) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
                    }
                }
            }
        }
        return cell
    }
    
    /*
    MARK: - SEARCH BAR DELEGATE METHODS
    *******************************************
    */
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchedText = searchBar.text
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchedText = searchText
    }
    
    //PREPARE FOR SEGUE
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContactDetailSegue" {
            if let destination = segue.destination as? ContactDetailViewController {
                let row = contactsTableView.indexPathForSelectedRow!.row
                destination.myContacts = self.sortedContacts[row]
            }
        }
    }
}

//
//  ContactsViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Luis Calle on 11/15/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate {
    
    var allContacts = [Contact]()
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var contactsSearchBar: UISearchBar!
    
    var searchTerm: String? {
        didSet {
            self.contactsTableView.reloadData()
        }
    }
    
    var filteredContactsArray: [Contact] {
        guard let searchTerm = searchTerm, searchTerm != "" else {
            return self.allContacts
        }
        return allContacts.filter{("\($0.name.first.lowercased()) \($0.name.last.lowercased())").contains(searchTerm.lowercased())}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactsTableView.delegate = self
        self.contactsTableView.dataSource = self
        self.contactsSearchBar.delegate = self
        loadData()
        self.allContacts = Contact.sortContacts(contactsArray: self.allContacts)
    }

    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: myURL)
                let myDecoder = JSONDecoder()
                let contactList = try myDecoder.decode(ContactList.self, from: data)
                self.allContacts = contactList.results
            }
            catch let error {
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ContactsDetailedViewController {
            guard let selectedPath = contactsTableView.indexPathForSelectedRow else {
                return
            }
            let selectedRow = selectedPath.row
            let selectedContact = self.filteredContactsArray[selectedRow]
            destination.contact = selectedContact
        }
    }

}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredContactsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell = tableView.dequeueReusableCell(withIdentifier: "Contact Cell", for: indexPath)
        let selectedContact = self.filteredContactsArray[indexPath.row]
        guard let contactTextLabel = contactCell.textLabel,
              let contactDetailedTextLabel = contactCell.detailTextLabel,
              let contactImageView = contactCell.imageView else {
            return contactCell
        }
        contactTextLabel.text = "\(selectedContact.name.first) \(selectedContact.name.last)".capitalized
        contactDetailedTextLabel.text = selectedContact.location.city.capitalized
        guard let imageURL = URL(string: selectedContact.picture.thumbnail) else { return contactCell }
        do {
            let data = try Data(contentsOf: imageURL)
            contactImageView.image = UIImage(data: data)
        }
        catch let error {
            print(error)
        }
        return contactCell
    }
}

extension ContactsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchText
    }
}


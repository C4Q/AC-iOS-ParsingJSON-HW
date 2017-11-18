//
//  ContactsViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var contactsSearchBar: UISearchBar!
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    
    /// add search bar delegates
    
    
    var contactArr = [Results]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactsTableView.dataSource = self
        self.contactsTableView.delegate = self
//        self.contactsSearchBar.delegate = self
        loadContactData()
    }
    
    func loadContactData() {
        /// create a file path to the saved .json file
        guard let path = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            return
        }
        let myUrl = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: myUrl) else { return }
        let myDecoder = JSONDecoder()
        /// parse the data here
        do {
            let contacts = try myDecoder.decode(Contact.self, from: data)
            self.contactArr = contacts.results
        }
        catch let error {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = self.contactArr[indexPath.row]
        let cell = self.contactsTableView.dequeueReusableCell(withIdentifier: "ContactsCell", for: indexPath)
        cell.textLabel?.text = "\(contact.name.first.capitalized) \(contact.name.last.capitalized)"
        cell.detailTextLabel?.text = "\(contact.location.city.capitalized), \(contact.location.state.capitalized)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ContactDetailViewController {
            let selectedRow = self.contactsTableView.indexPathForSelectedRow!.row
            let selectedContact = self.contactArr[selectedRow]
            destination.contact = selectedContact
        }
    }
    
    /// filter search bar contacts on first name
    var filteredContacts: [Results] {
        guard let searchTerm = searchTerm, searchTerm != "" else {
            return contactArr
        }
        return contactArr.filter{(contact) in
            contact.name.first.lowercased().contains(searchTerm.lowercased())
        }
    }
    
    var searchTerm: String? {
        didSet {
            self.contactsTableView.reloadData()
        }
    }
    
    
}


    
    /// list contacts alphabetically, with subtitle of Proper cased name and Location
    



    
    
    


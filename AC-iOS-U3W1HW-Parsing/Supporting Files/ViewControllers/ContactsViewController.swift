//
//  ContactsViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var contacts = [Contacts]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
    
        // Do any additional setup after loading the view.
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                
                do {
                    let allContactsInfo = try myDecoder.decode(ContactInfo.self, from: data)
                    self.contacts = allContactsInfo.results
                }
                catch let error {
                    print(error)
                }
            }
        }
        for contact in contacts {
           print(contact.name.first)
    }
}
    
    //Mark- dataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return filteredArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        contacts.sort(){$0.name.first < $1.name.first}
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contacts Cell", for: indexPath)
        let currentContact = filteredArr[indexPath.row]
        cell.textLabel?.text = currentContact.name.first.capitalized + " " + currentContact.name.last.capitalized
        cell.detailTextLabel?.text = currentContact.location.city 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    //Mark - SearchBar
    var searchTerm: String? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var filteredArr: [Contacts] {
        guard let searchTerm = searchTerm, searchTerm != "" else {
            return contacts
        }
        
        var finalArr: [Contacts] = []
        
        for contact in contacts{
            let name = contact.name.first + " " + contact.name.last
            if name.lowercased().contains(searchTerm.lowercased()) {
                
                finalArr.append(contact)
            }
            
        }
        return finalArr
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchText
        
    }
    
    //MARK - segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ContactsDetailViewController {
            let selectedRow = tableView.indexPathForSelectedRow!.row
            let selectedContact = filteredArr[selectedRow]
            destination.selectedContact = selectedContact
            
        }
    }
    
}

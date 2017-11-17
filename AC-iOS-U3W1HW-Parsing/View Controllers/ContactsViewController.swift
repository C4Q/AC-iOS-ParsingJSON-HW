//
//  ContactsViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    var contacts = [Person]()
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    let contacts = try myDecoder.decode(contactTop.self, from: data)
                    self.contacts = contacts.results
                }
                catch let error {
                    print(error)
                }
            }
        }
    }
    
    var searchWord: String? {
        didSet {
            self.contactsTableView.reloadData()
        }
    }
    
    var filteredContactArr: [Person] {
        guard let searchWord = searchWord, searchWord != "" else {
            return contacts
        }
        return contacts.filter({$0.name.first.lowercased().contains(searchWord.lowercased())
            || $0.name.last.lowercased().contains(searchWord.lowercased())})
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContactArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        contacts.sort(){$0.name.first < $1.name.first}
        let contact = filteredContactArr[indexPath.row]
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "Contact Cell", for: indexPath)
        cell.textLabel?.text = contact.name.first.capitalized + " " + contact.name.last.capitalized
        cell.detailTextLabel?.text = contact.location.city
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchWord = searchBar.text
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchWord = searchText
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationContact = segue.destination as? ContactDetailViewController {
            let selectedRow = contactsTableView.indexPathForSelectedRow?.row
            let selectedContact = filteredContactArr[selectedRow!]
            destinationContact.myContact = selectedContact
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.contactsTableView.delegate = self
        self.contactsTableView.dataSource = self
        self.searchBar.delegate = self

        // Do any additional setup after loading the view.
    }



}

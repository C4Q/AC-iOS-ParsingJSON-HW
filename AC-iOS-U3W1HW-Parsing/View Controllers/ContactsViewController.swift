//
//  ContactsViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Maryann Yin on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    @IBOutlet weak var contactsSearchBar: UISearchBar!
    
    var people: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsSearchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                do {
                    let results = try JSONDecoder().decode(PersonResults.self, from: data)
                    self.people = results.results
                }
                catch {
                    print("Error Decoding Data")
                }
            }
        }
    }
    
    var searchItem: String? {
        didSet{
            self.contactsTableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchItem = searchBar.text
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchItem = searchText
    }
    
    var filteredContactsArr: [Person] {
        guard let searchItem = searchItem, searchItem != "" else {
            return people
        }
        return people.filter({$0.name.first.lowercased().contains(searchItem.lowercased()) || $0.name.last.lowercased().contains(searchItem.lowercased())})
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        people.sort(){$0.name.first < $1.name.first}
        let personContact = self.filteredContactsArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactProperties", for: indexPath)
        cell.textLabel?.text = personContact.name.first.capitalized + " " + personContact.name.last.capitalized
        cell.detailTextLabel?.text = personContact.location.city.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContactsArr.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ContactsDetailViewController {
            let selectedContact = filteredContactsArr[contactsTableView.indexPathForSelectedRow!.row]
            destination.peopleContact = selectedContact
        }
    }
}

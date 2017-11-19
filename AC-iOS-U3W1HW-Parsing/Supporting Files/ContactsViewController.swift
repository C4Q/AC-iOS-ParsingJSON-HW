//
//  ContactsViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Clint Mejia on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    var contacts = [Contact]()
    
    // MARK: outlets
    @IBOutlet weak var contactsTableView: UITableView!
    
    // MARK: viewDidLoad Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.dataSource = self
        getContactData()
        setupNavBar()
    }
    
    // MARK: functions
    func setupNavBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        
    }
    
    func getContactData() {
        guard let path = Bundle.main.path(forResource: "userinfo", ofType: "json") else { return }
        let myURL = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: myURL) else { return }
        let myDecoder = JSONDecoder()
        do {
            let contacts = try myDecoder.decode(ContactInfo.self, from: data)
            self.contacts = contacts.results
        }
        catch {
            print(error)
        }
    }
    
}

//MARK: tableView - data source methods
extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = "\(contact.name.fullName)"
        cell.detailTextLabel?.text = contact.location.city
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? contactDetailViewController {
            destination.selectedContact = contacts[contactsTableView.indexPathForSelectedRow!.row]
        }
    }
}

extension ContactsViewController: UISearchBarDelegate {
    
}

//
//  ContactsViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Richard Crichlow on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var contacts = [Person]()
    var sectionNames: [Character] = []
    var filteringIsOn: Bool = false
    
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
            self.contacts = self.contacts.sorted{$0.name.first < $1.name.first}
        }
    }
    
    func getSectionNames() {
        for contact in contacts {
            if !sectionNames.contains(contact.name.first.first!) {
                sectionNames.append(contact.name.first.first!)
            }
        }
    }
    
    var searchWord: String? {//This is so the tableView reloads as the text changes
        didSet {
            self.contactsTableView.reloadData()
        }
    }
    
    var filteredContactArr: [Person] {//This is to check against nils and also to filter the tableview content based on the searchbar textfield
        guard let searchWord = searchWord, searchWord != "" else {
            filteringIsOn = false
            return contacts
        }
        filteringIsOn = true
        return contacts.filter({ ($0.name.first + " " + $0.name.last).lowercased().contains(searchWord.lowercased())})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactsTableView.delegate = self
        self.contactsTableView.dataSource = self
        self.searchBar.delegate = self
        loadData()
        getSectionNames()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if filteringIsOn {
            return 1
        } else {
            return sectionNames.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if filteringIsOn {
            return "All Contacts"
        } else {
            return String(sectionNames[section])
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filteringIsOn {
            return filteredContactArr.count
        } else {
            let rowsInSection = filteredContactArr.filter{$0.name.first.first == sectionNames[section]}
            return rowsInSection.count
        }
        
//        return filteredContactArr.count //The filteredContactsArr is a computed property that will show the full contacts array if the searchbar is not being used, or the filtered contacts if it is being used
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        contacts.sort(){($0.name.first+$0.name.last) < ($1.name.first+$1.name.last)} //To sort the contacts before the data is loaded into the tableview
        
        let currentRowsInCell = filteredContactArr.filter{$0.name.first.first == sectionNames[indexPath.section]}
        let contact = (filteringIsOn) ? filteredContactArr[indexPath.row] : currentRowsInCell[indexPath.row]
        
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        cell.textLabel?.text = contact.name.first.capitalized + " " + contact.name.last.capitalized
        cell.detailTextLabel?.text = contact.location.city
        
        if let pictureURL = URL(string: contact.picture.thumbnail) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: pictureURL) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
                        cell.setNeedsLayout()
                    }
                }
            }
        }
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchWord = searchBar.text
        searchBar.resignFirstResponder() //to make the keyboard go away when the user presses enter
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //to update the filter as the searchbar text changes
        self.searchWord = searchText
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        filteringIsOn = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedContactsViewController {
            let selectedRow = contactsTableView.indexPathForSelectedRow!.row
            if !filteringIsOn {
                let rowsInSection = filteredContactArr.filter{$0.name.first.first == sectionNames[contactsTableView.indexPathForSelectedRow!.section]}
                let selectedContact = rowsInSection[selectedRow]
                destination.aContact = selectedContact //destination.THISNAME HERE should always match the name of the variable on your detailed contacts view controller.
            } else {
                let selectedContact = filteredContactArr[selectedRow]
                destination.aContact = selectedContact //destination.THISNAME HERE should always match the name of the variable on your detailed contacts view controller.
            }
        }
    }
    
    
    
}

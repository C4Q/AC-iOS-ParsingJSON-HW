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
    
    var searchWord: String? {//This is so the tableView reloads as the text changes
        didSet {
            self.contactsTableView.reloadData()
        }
    }
    
    var filteredContactArr: [Person] {//This is to check against nils and also to filter the tableview content based on the searchbar textfield
        guard let searchWord = searchWord, searchWord != "" else {
            return contacts
        }
        return contacts.filter({ ($0.name.first + " " + $0.name.last).lowercased().contains(searchWord.lowercased())})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactsTableView.delegate = self
        self.contactsTableView.dataSource = self
        self.searchBar.delegate = self
        loadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContactArr.count //The filteredContactsArr is a computed property that will show the full contacts array if the searchbar is not being used, or the filtered contacts if it is being used
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        contacts.sort(){$0.name.first < $1.name.first} //To sort the contacts before the data is loaded into the tableview
        
        let contact = filteredContactArr[indexPath.row]
        
        let cell = contactsTableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        cell.textLabel?.text = contact.name.first.capitalized + " " + contact.name.last.capitalized
        cell.detailTextLabel?.text = contact.location.city
        
        if let pictureURL = URL(string: contact.picture.thumbnail) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: pictureURL) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedContactsViewController {
            let selectedRow = contactsTableView.indexPathForSelectedRow!.row
            let selectedContact = filteredContactArr[selectedRow]
            destination.aContact = selectedContact //destination.THISNAME HERE should always match the name of the variable on your detailed contacts view controller.
        }
    }
    
    
    
}

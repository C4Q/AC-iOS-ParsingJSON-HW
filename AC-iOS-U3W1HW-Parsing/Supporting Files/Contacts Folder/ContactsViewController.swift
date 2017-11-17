//
//  ContactsViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Ashlee Krammer on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //Accessing Person Model
    var contact = [Person]()
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
        loadData()
        
    }
    
    //loadData
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do{
                    let contacts = try myDecoder.decode(Contacts.self, from: data)
                    
                    for person in contacts.results {
                        contact.append(person)
                    }
                    
                } catch {
                    print(error)
                }
            }
        }
    }
    
    
    //Sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtersTerms.count
    }
    
    //Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        contact.sort(){ $0.name.first < $1.name.first}
        let aPerson = filtersTerms[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contacts Cell", for: indexPath)
        let name = "\(aPerson.name.title.capitalized). \(aPerson.name.first.capitalized) \(aPerson.name.last.capitalized)"
        let location = "\(aPerson.location.city.capitalized), \(aPerson.location.state.capitalized)"
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = location
        
        return cell
    }
    
    //Search Bar
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search Bar Clicked")
        tableView.resignFirstResponder()
    }
    
    //Search Term
    var searchTerm: String? {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    //Text Did Change
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchText
    }
    
    
    var filtersTerms: [Person] {
        guard let searchTerm = searchTerm, searchTerm != "" else {
            return contact
        }
        guard let scopeTitles = self.searchBar.scopeButtonTitles else {
            return contact
        }
        var filteredArr = [Person]()
        let selectedIndex = self.searchBar.selectedScopeButtonIndex
        
        let filteringCriteria = scopeTitles[selectedIndex]
        
        
        
        switch filteringCriteria {
        case "First Name":
            for person in contact {
                if person.name.first.lowercased().contains(searchTerm.lowercased()) {
                    filteredArr.append(person)
                }
            }
            return filteredArr
            
        case "Last Name":
            for person in contact {
                if person.name.last.lowercased().contains(searchTerm.lowercased()) {
                    filteredArr.append(person)
                }
            }
            return filteredArr
        case "City":
            for person in contact {
                if person.location.city.lowercased().contains(searchTerm.lowercased()) {
                    filteredArr.append(person)
                }
            }
            return filteredArr
        case "State":
            for person in contact {
                if person.location.state.lowercased().contains(searchTerm.lowercased()){
                    filteredArr.append(person)
                }
            }
            return filteredArr
        default:
            break
        }
        
        return filteredArr
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.resignFirstResponder()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.resignFirstResponder()
    }
    
    //Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedContactsViewController {
            let selectedRow = tableView.indexPathForSelectedRow?.row
            let selectedPerson = filtersTerms[selectedRow!]
            destination.person = selectedPerson
     
        }
    }
    
    
}

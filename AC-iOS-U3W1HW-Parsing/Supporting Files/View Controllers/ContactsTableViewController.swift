//
//  ContactsTableViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

//make network call
//get data
//turn data into what we want (swift types: Arrays, Dicts)
//set properties do we can manipulate as neeed
//breakpoints where things are being set ex) array.count

class ContactsTableViewController: UIViewController {
    
    //create instance of array
    var contacts = [Person]()
    
    ///Search Bar properties
    //This will reload tableview as text changes
    var searchTerm: String?{
        didSet{
            self.contactsTableView.reloadData()
        }
    }
    let searchController = UISearchController(searchResultsController: nil)
    
    //connect tableview to View Controller
    @IBOutlet weak var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup delegates
        contactsTableView.dataSource = self
        searchController.searchBar.delegate = self
        //call function to retrieve data
        loadContactsData()
        //setup for searchbar
        setUPSearchBarUI()
    }
    
    func setUPSearchBarUI(){
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.scopeButtonTitles = ["First Name", "Last Name", "City Location"]
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    /// MARK: - Create Function to Load Contacts Data
    func loadContactsData(){
        //unwrap and setup path
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            //setup url filepath with path
            let url = URL(fileURLWithPath: path)
            //unwrap and setup data with contents of url
            //turning json into data
            if let data = try? Data(contentsOf: url){
                //setup JSON Decoder
                let myDecoder = JSONDecoder()
                //set up do/catch clause
                do{
                    //use myDecoder to try and decode the data from the Contacts struct
                    let contactInfo = try myDecoder.decode(Contacts.self, from: data)
                    //set that to the contacts instance
                    //self.contacts refers to its instance of the ViewController
                    self.contacts = contactInfo.results
                    
                    //sorting contacts by full name
                    contacts.sort(){($0.name.first+$0.name.last) < ($1.name.first+$1.name.last)}
                    
                } catch let error {
                    print(error)
                }
            }
            //            for person in contacts{
            //                print(person.name, person.location.city, person.email)
            //            }
        }
    }
    
    /// MARK: - Filtering with SearchBar using computed Property
    //empty array for filtering
    var contactsArr: [Person] = []
    
    var filteredContactsArr: [Person] {
        //guard for searchterm and if not nil, return original array
        guard let searchTerm = searchTerm, searchTerm != "" else {
            return contacts
        }
        //make sure there are scope titles in the searchBar
        guard let scopeTitles = self.searchController.searchBar.scopeButtonTitles else{return contactsArr}
        let selectedIndexOfScopeTitles = self.searchController.searchBar.selectedScopeButtonIndex
        let filteringCriteriaForScopeButtons = scopeTitles[selectedIndexOfScopeTitles]
        switch filteringCriteriaForScopeButtons{
        case "First Name":
            return contacts.filter({ ($0.name.first).lowercased().contains(searchTerm.lowercased())})
        case "Last Name":
            return contacts.filter({ ($0.name.last).lowercased().contains(searchTerm.lowercased())})
        case "City Location":
            return contacts.filter({ ($0.location.city).lowercased().contains(searchTerm.lowercased())})
        default:
            return contactsArr
        }
        ///if not using scope buttons
        //  return contacts.filter({ ($0.name.first + " " + $0.name.last).lowercased().contains(searchTerm.lowercased())})
    }
    
    /// MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if let destination = segue.destination as? DetailContactsViewController{
            // Pass the selected object to the new view controller.
            // Make sure the instance is created in the detail VC first
            //sending over information from the row of the tableview that was selected by the user
            destination.contacts = contacts[contactsTableView.indexPathForSelectedRow!.row]
            
        }
    }
}

/// MARK: - Building Table View

extension ContactsTableViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContactsArr.count //contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Person Cell", for: indexPath)
        
        let person = filteredContactsArr[indexPath.row] //contacts[indexPath.row]
        
        cell.textLabel?.text = person.name.first.capitalized + " " + person.name.last.capitalized
        cell.detailTextLabel?.text = person.location.city
        
        //adding thumbnail image from the internet
        if let pictureURL = URL(string: person.picture.thumbnail){
            DispatchQueue.global().sync{
                if let data = try? Data.init(contentsOf: pictureURL)  {
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
                        
                        //refreshes the cell: look at documentation
                        cell.setNeedsLayout()
                    }
                }
            }
        }
        return cell
    }
}

/// MARK: - SearchBar Functionality

extension ContactsTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    ///computed properties set in main class
    
    //UISearchResultsUpdating: live editing
    func updateSearchResults(for searchController: UISearchController) {
        self.searchTerm = searchController.searchBar.text
        searchController.resignFirstResponder()
        //contactsTableView.reloadData()
    }
    //Whenever user clicks on scope button, reload data
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        contactsTableView.reloadData()
    }
}

/////////////////////////////////////////////////////////////////////////////////////

/// MARK: - Notes to set up searchbar Controller Programmatically
/*
 0.var searchTerm: String? {
 didSet{
 self.songsTableView.reloadData()
 }
 }
 1. add protocols: UISearchBarDelegate, UISearchResultsUpdating
 2. Instantiate UIController: let searchController = UISearchController(searchResultsController: nil)
 
 3. Inside viewDidLoad(): make a func first then call func in view did load
 searchController.searchBar.delegate = self
 searchController.obscuresBackgroundDuringPresentation = false
 searchController.hidesNavigationBarDuringPresentation = false
 searchController.searchBar.scopeButtonTitles = ["song", "artist"]
 searchController.searchResultsUpdater = self
 navigationItem.searchController = searchController
 definesPresentationContext = true
 
 4. Use searchBar Methods: UISearchResultsUpdating
 
 func updateSearchResults(for searchController: UISearchController) {
 self.searchTerm = searchController.searchBar.text
 }
 Whenever user clicks on button, reload data
 func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
 songsTableView.reloadData()
 }
 */

































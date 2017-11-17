//
//  contactsViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class contactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var contactTableView: UITableView!
    var contacts = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
        self.searchBar.delegate = self
        loadData()
    }

    func loadData(){
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json"){
            let myUrl = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myUrl){
                let myDecoder = JSONDecoder()
                do{
                    let contacts = try myDecoder.decode(ContactEntry.self, from: data)
            
                    for element in contacts.results{
                        self.contacts.append(element)
                    }
                    
                }catch{
                    print(error)
                    
                }
            }
        }
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchText
    }
    
    
    
    
    var searchTerm: String? {
        didSet{
            self.contactTableView.reloadData()
        }
    }
    
    
    var filteredContacts: [Person]{
        guard let searchTerm = searchTerm, searchTerm != ""  else {
            return contacts
        }
        
        var filteredPeople = [Person]()
        for person in contacts{
        let fullName = person.name.first + " " + person.name.last
            
            if fullName.lowercased().contains(searchTerm.lowercased()){
                filteredPeople.append(person)
        }
    }
        return filteredPeople
    }
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        contacts.sort(){$0.name.first < $1.name.first}
        let contact = filteredContacts[indexPath.row]
        let fullName = contact.name.first.capitalized + " " + contact.name.last.capitalized
        
        let cell = contactTableView.dequeueReusableCell(withIdentifier: "Contact Cell", for: indexPath)
        cell.textLabel?.text = fullName
        cell.detailTextLabel?.text = contact.location.city.capitalized
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? contactsDetailViewController{
            let selectedRow = contactTableView.indexPathForSelectedRow?.row
            let selectedContact = filteredContacts[selectedRow!]
            destination.contact = selectedContact
            
        }
    }
    
}

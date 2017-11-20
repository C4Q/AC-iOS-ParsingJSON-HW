//
//  ContactsListViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsListViewController: UIViewController {

    @IBOutlet weak var contactsTableView: UITableView!
    
    //Table Data Source Variable
    var people: [Person] = []
    
    @IBOutlet weak var contactsSearchBar: UISearchBar!
    //Search Bar Variable
    var filteredPeople: [Person] = []
    var searchTerm: String? {
        didSet {
            
            guard let searchTerm = searchTerm, searchTerm != "" else {
                filteredPeople = people
                return
            }
            
            filteredPeople = people.filter {
                let fullName = $0.name.first + " " + $0.name.last
                
                return fullName.contains(searchTerm)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        filteredPeople = people
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contactsSearchBar.delegate = self
    }

    func getData() {
        guard let path = Bundle.main.path(forResource: "userinfo", ofType: "json") else {
            print("Error: couldn't find path")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        guard let data = try? Data(contentsOf: url) else {
            print("Error: could not initialize data")
            return
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            let people = try jsonDecoder.decode(ResultsWrapper.self, from: data)
            self.people = people.results.sorted { $0.name.first < $1.name.first }
        } catch let error {
            print(error)
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let cell = sender as? ContactsTableViewCell,
            let selectedIndexPath = contactsTableView.indexPath(for: cell),
            let destinationVC = segue.destination as? ContactsDetailViewController {
            let selectedPerson = filteredPeople[selectedIndexPath.row]
            destinationVC.person = selectedPerson
        }
    }
    
}

//MARK: - Table View Methods
extension ContactsListViewController: UITableViewDelegate, UITableViewDataSource {
    //Table View Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        
        performSegue(withIdentifier: "detailedSegue", sender: selectedCell)
    }
    
    //Table View Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPeople.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let currentContact = filteredPeople[indexPath.row]
        
        if let contactCell = cell as? ContactsTableViewCell {
            
            let fullName = currentContact.name.first + " " + currentContact.name.last
            
            contactCell.nameLabel.text = fullName.capitalized
            contactCell.locationLabel.text = currentContact.location.city.capitalized
            
            //set up images
            let apiManager = APIManager()
            
            //placeholder image
            contactCell.contactImageView.image = #imageLiteral(resourceName: "profileImage")
            
            apiManager.getData(endpoint: currentContact.picture.medium) { (data: Data?) in
                guard let data = data else {
                    print("Error: couldn't load data")
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    print("Error: couldn't load image")
                    return
                }
                
                DispatchQueue.main.async {
                    contactCell.contactImageView.image = image
                }
                
            }
            
            return contactCell
        }
        
        return cell
    }
    
}

//MARK: Search Bar Delegate Methods
extension ContactsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchBar.resignFirstResponder()
        }
        
        searchTerm = searchText
        
        contactsTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

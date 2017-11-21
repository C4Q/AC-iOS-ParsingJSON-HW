//
//  ContactViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var contacts = [User]()
    var searchTerm: String? {
        didSet {
            self.tableView.reloadData()
        }
    }
    var filteredContacts: [User] {
        guard searchTerm != nil, searchTerm != "" else {return self.contacts}
        return contacts.filter({$0.name.first.lowercased().contains(searchTerm!.lowercased()) || $0.name.last.lowercased().contains(searchTerm!.lowercased())})
    }
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
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
                let decoder = JSONDecoder()
                do {
               let userDict = try decoder.decode(UserInfo.self, from: data)
                    self.contacts = userDict.results.sorted(by: {$0.name.first < $1.name.first})
                } catch {
                    print(error)
                }
            }
        }
        
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user cell", for: indexPath)
        let wholeName = filteredContacts[indexPath.row].name
        cell.textLabel?.text = wholeName.first.capitalized + " " + wholeName.last.capitalized
        cell.detailTextLabel?.text = contacts[indexPath.row].location.city.capitalized
        guard let theImage = filteredContacts[indexPath.row].picture.medium else {cell.imageView?.image = #imageLiteral(resourceName: "profileImage")
            return cell
        }
        
        if let imageUrl = URL(string: theImage) {
            if let data = try? Data(contentsOf: imageUrl) {
               
            cell.imageView?.image = UIImage(data: data)

        }
        }
        
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailContactViewController {
            let selectedIndex = tableView.indexPathForSelectedRow!.row
            let selectedUser = filteredContacts[selectedIndex]
            destination.user = selectedUser
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm = searchBar.text
    }
   

}

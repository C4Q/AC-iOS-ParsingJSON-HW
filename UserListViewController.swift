//
//  UserListViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Lisa J on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    var users = [ResultsWrapper]()
    var sortedUsers : [ResultsWrapper] {return users.sorted {$0.name.fullName < $1.name.fullName}}
    //sorted by full name
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        loadData()
        
    }
    var searchWords: String? {
        didSet {
            self.tableView.reloadData()
        }
    }
func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                    //if let thisUserList = 
                do {
                    //outerwrapper
                    let users = try myDecoder.decode(UserInfo.self, from: data)
                    //inner wrapper
                    self.users = users.results
                    
                } catch {
                    print(error)
                }
            }
        }
    
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //row
        let user = filteredUsers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "User cell", for: indexPath)
        cell.textLabel?.text = user.name.fullName
        cell.detailTextLabel?.text = "\(user.location.city.capitalized)"
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "usersegue" { 
            if let destination = segue.destination as? UserDetailViewController {
                let row = tableView.indexPathForSelectedRow!.row
                destination.userDetail = self.sortedUsers[row]
            }
        }
    }
    //search bar
    var filteredUsers: [ResultsWrapper] {
        guard let searchWords = searchWords, searchWords != "" else {
            return sortedUsers
            //populates w sortedusers when blank search bar
        }
        return sortedUsers.filter{(user) in
            user.name.fullName.lowercased().contains(searchWords.lowercased())
            //filters after a search is entered
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchWords = searchBar.text
        searchBar.resignFirstResponder()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchWords = searchText
        //live search
    }
}
        


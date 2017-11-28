//
//  UserViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Masai Young on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

class UserViewController : UIViewController {
    
    var users: [User]?
    
    var filteredUsers: [User]? {
        guard let searchTerm = searchTerm, !searchTerm.isEmpty else { return users }
        return users!.filter{$0.fullName.lowercased().range(of: searchTerm , options: .caseInsensitive) != nil}
    }
    
    var searchTerm: String?
    
    @IBOutlet weak var userSearchBar: UISearchBar!
    @IBOutlet weak var userTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1. We need to check what our sender is. Afterall, there might be multiple segues set up...
        // 2. check for the right storyboard segue
        // 3. Get the destination VC

        guard let destination = segue.destination as? UserDetailViewController else {
            return
        }

        if let activatedCell = sender as? UITableViewCell, segue.identifier == "UserDetailSegue" {
            // 4. Getting the movie at the tapped cell
            let cellIndex = userTableView.indexPath(for: activatedCell)!
            destination.singleUser = users?[cellIndex.row]
            destination.userImage = (activatedCell.imageView?.image)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userTableView.dataSource = self
        self.userSearchBar.delegate = self
        users = User.fetchUsers()?.results.sorted{$0.name.first < $1.name.first}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: Table View Data Source
extension UserViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers?.count ?? 10
    }
    
    // MARK: - Cell Rendering
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: "User Cell", for: indexPath)
        let user = filteredUsers?[indexPath.row]
        cell.textLabel?.text = user?.fullName
        cell.detailTextLabel?.text = (user?.location.city.capitalized)! + "  ||  " + (user?.location.state.capitalized)!
        
        // MARK: - Downloads images async
        if let albumURL = URL(string: (user?.picture.large)!) {
            
            // doing work on a background thread
            DispatchQueue.global().async {
                if let data = try? Data.init(contentsOf: albumURL) {
                    
                    // go back to main thread to update UI
                    DispatchQueue.main.sync {
                        cell.imageView?.image = UIImage(data: data)
                    }
                }
            }
        }
        return cell
    }
    
}

extension UserViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchTerm = searchBar.text
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchBar.text
        userTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        userTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        userTableView.reloadData()
    }
}

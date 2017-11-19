//
//  UserListViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Lisa J on 11/17/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class UserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var users = [ResultsWrapper]()
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
        
    }
func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
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
        for user in users {
            print(user.name)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //row
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "User cell", for: indexPath)
        cell.textLabel?.text = "\(user.name.first.capitalized) \(user.name.last.capitalized)"
        cell.detailTextLabel?.text = "\(user.location.city.capitalized)"
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "usersegue" {
            print("segue works")
            if let destination = segue.destination as? UserDetailViewController {
                destination.userDetail = users[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
}
        


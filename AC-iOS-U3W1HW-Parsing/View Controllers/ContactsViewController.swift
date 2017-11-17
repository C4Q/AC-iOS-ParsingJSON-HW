//
//  ContactsViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by Luis Calle on 11/15/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate {
    
    var allContacts = [Contact]()
    @IBOutlet weak var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactsTableView.delegate = self
        self.contactsTableView.dataSource = self
        loadData()
        self.allContacts = self.allContacts.sorted{$0.name.first < $1.name.first}
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    let contactList = try myDecoder.decode(ContactList.self, from: data)
                    self.allContacts = contactList.results
                }
                catch let error {
                    print(error)
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell = tableView.dequeueReusableCell(withIdentifier: "Contact Cell", for: indexPath)
        let selectedContact = self.allContacts[indexPath.row]
        contactCell.textLabel?.text = selectedContact.name.first + " " + selectedContact.name.last
        contactCell.detailTextLabel?.text = selectedContact.location.city
        let url = URL(string: selectedContact.picture.thumbnail)
        let data = try? Data(contentsOf: url!)
        contactCell.imageView?.image = UIImage(data: data!)
        return contactCell
    }
}


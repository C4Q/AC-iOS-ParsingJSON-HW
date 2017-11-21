//
//  ContactViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/18/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {

    var contacts: Contact!
    var allContacts: [resultsUnwrapped] = []
    var contactFiltered: String = "" {
        didSet {
//            var result: [resultsUnwrapped] = []
//            guard let contacts = self.contacts else {return}
//            if let contactFiltered = self.contactFiltered {
//                if contactFiltered == "" {
//                    result = contacts.results
//                } else {
//                    result = contacts.results.filter{$0.name.fullName.contains(contactFiltered)}
//                }
//            } else {
//                result = contacts.results
//            }
//            self.allContacts = result.sorted{$0.name.fullName < $1.name.fullName}
            if contactFiltered.count > 0 {
                allContacts = (contacts.results.filter{$0.name.fullName.contains(contactFiltered)
                })
            } else {
                loadContactsData()
            }
            contactTableView.reloadData()
        }
    }
    
    @IBOutlet weak var contactTableView: UITableView!
    @IBOutlet weak var searchContact: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contactTableView.delegate = self
        self.contactTableView.dataSource = self
        loadContactsData()
        self.searchContact.delegate = self
    }

    func loadContactsData() {
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    let contactDecoded = try myDecoder.decode(Contact.self, from: data)
                    self.contacts = contactDecoded
                } catch let error {
                    print("Unexpeted error:", error)
                    return
                }
            }
        }
        self.allContacts = self.contacts!.results.sorted{$0.name.fullName < $1.name.fullName}
    }
    
    
    // MARK: - Segue ContactDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexContact = contactTableView.indexPathForSelectedRow!.row
        let contactDetailData = allContacts[indexContact]
        let contactDetailVC = segue.destination as? ContactDetailViewController
        contactDetailVC?.contact = contactDetailData
    }
    
}




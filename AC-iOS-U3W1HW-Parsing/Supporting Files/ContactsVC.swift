//  ContactsVC.swift
//  AC-iOS-U3W1HW-Parsing
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.

import UIKit

class ContactsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

	@IBOutlet weak var contactsTableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!

	
//	var contacts = Contact.init(results: [])
	var contacts = [Contact]()

	//Mark: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		self.contactsTableView.dataSource = self
		self.contactsTableView.delegate = self
		loadContactData()
	}
	
	func loadContactData() {
		if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
			let myURL = URL(fileURLWithPath: path)
			if let data = try? Data(contentsOf: myURL) {
				do {
					let results = try JSONDecoder().decode(ContactResultsWrapper.self, from: data)
					self.contacts = results.results
				}
				catch {
					print(error)
				}
			}
		}
	}
	
	//MARK: - Data Source Methods
	func tableView(_ contactsTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return contacts.count //
	}
	
	func tableView(_ contactsTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let contact = contacts[indexPath.row]
		let cell = self.contactsTableView.dequeueReusableCell(withIdentifier: "Contact Cell", for: indexPath)
		cell.textLabel?.text = "\(contact.name.first) \(contact.name.last)"
		cell.detailTextLabel?.text = contact.location.city
		return cell
	}
	
	
	//MARK: - Search Bar	
	var filteredContactArr: [Contact] {
		guard let searchTerm = searchTerm, searchTerm != "" else {
			return contacts
		}
		
		return contacts.filter {(contact) in
			contact.name.first.contains(searchTerm.lowercased()) || contact.name.last.contains(searchTerm.lowercased())
		}
	}
	
	var searchTerm: String? {//computed property
		didSet { //create a property observer to let us know when the search term changes, reload the data
			self.contactsTableView.reloadData() //whenever we change the search term, reload the data
		}
	}
	
	//MARK: - Search Bar Delegate Methods
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.searchTerm = searchBar.text
		searchBar.resignFirstResponder()
	}
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		self.searchTerm = searchText
	}
	
	//MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? ContactsDVC {
			let row = contactsTableView.indexPathForSelectedRow!.row
			destination.contact = self.contacts[row]
		}
	}
	
}

	







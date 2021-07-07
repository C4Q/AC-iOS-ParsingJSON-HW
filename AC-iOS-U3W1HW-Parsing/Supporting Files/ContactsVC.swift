//  ContactsVC.swift
//  AC-iOS-U3W1HW-Parsing
//  Created by Winston Maragh on 11/16/17.
//  Copyright © 2017 Winston Maragh. All rights reserved.

import UIKit

class ContactsVC: UIViewController {

	//MARK: - Outlets
	@IBOutlet weak var contactsTableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!

	//MARK: - Variables/Constants
	var contacts = [Contact]()
	var organizedContacts: [Contact] { return contacts.sorted { $0.name.first < $1.name.first } }

	//Mark: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		self.contactsTableView.dataSource = self
		self.contactsTableView.delegate = self
		self.searchBar.delegate = self
		loadContactData()
	}
	
	var searchTerm: String? {
		didSet {
			self.contactsTableView.reloadData()
		}
	}
	
	//MARK: - Functions
	func loadContactData() {
		if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
			let url = URL(fileURLWithPath: path)
			if let data = try? Data(contentsOf: url) {
				do {
					let contacts = try JSONDecoder().decode(ContactResultsWrapper.self, from: data)
					self.contacts = contacts.results
				}
				catch {
					print(error)
				}
			}
		}
	}
}

//MARK: - TableView - Data Source Methods
extension ContactsVC: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ contactsTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredContacts.count
	}

	func tableView(_ contactsTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let contact = filteredContacts[indexPath.row]
		let cell = self.contactsTableView.dequeueReusableCell(withIdentifier: "Contact Cell", for: indexPath)
		cell.textLabel?.text = contact.name.fullName
		cell.detailTextLabel?.text = contact.location.city
		
		//load image
		if let url = URL(string: contact.picture.thumbnail) {
			//doing work on a background thread - to avoid crashing the phone
			DispatchQueue.global().async {
				if let data = try? Data.init(contentsOf: url) {
					//go back to main thread to update UI
					DispatchQueue.main.async {
						cell.imageView?.image = UIImage(data: data)
					}
				}
			}
		}
		return cell
	}
	
	//MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? ContactsDVC {
			let row = contactsTableView.indexPathForSelectedRow!.row
			destination.contact = self.organizedContacts[row]
		}
	}
}

//MARK: - Search Bar
extension ContactsVC: UISearchBarDelegate {
	var filteredContacts: [Contact] {
		guard let searchTerm = searchTerm, searchTerm != "" else {
			return organizedContacts
		}
		return organizedContacts.filter {(contact) in
			contact.name.fullName.lowercased().contains(searchTerm.lowercased())
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
}

//
//  ContactsTableViewController.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/16/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

//searchbar and filtering



class ContactsTableViewController: UIViewController {
    
    //create instance of array
    var contacts = [Person]()
    
    //connect tableview to View Controller
    @IBOutlet weak var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setup delegates
        contactsTableView.dataSource = self
        //contactsTableView.delegate = self
        //call function to retrieve data
        loadContactsData()
    }
    
    //make a get data function
    func loadContactsData(){
        //unwrap and setup path
        if let path = Bundle.main.path(forResource: "userinfo", ofType: "json") {
            //setup url filepath with path
            let url = URL(fileURLWithPath: path)
            //unwrap and setup data with contents of url
            if let data = try? Data(contentsOf: url){
                //setup JSON Decoder
                let myDecoder = JSONDecoder()
                //set up do/catch clause
                do{
                    //use myDecoder to try and decode the data from the Contacts struct
                    let contactInfo = try myDecoder.decode(Contacts.self, from: data)
                    //set that to the contacts instance
                    //self.contacts refers to its instance of the ViewController
                    self.contacts = contactInfo.results
                    contacts.sort(){$0.name.first < $1.name.first}
                } catch let error {
                    print(error)
                }
            }
            for person in contacts{
                print(person.name, person.location.city, person.email)
            }
        }
    }
    
    //make segue going to detail contacts view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if let destination = segue.destination as? DetailContactsViewController{
            // Pass the selected object to the new view controller.
            // Make sure the instance is created in the detail VC first
            //sending over information from the row of the tableview that was selected by the user
            destination.contacts = contacts[contactsTableView.indexPathForSelectedRow!.row]
            
        }
    }
    
}



//make extension to build out tableView
extension ContactsTableViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Person Cell", for: indexPath)
        
        let person = contacts[indexPath.row]
        
        cell.textLabel?.text = person.name.first.capitalized + " " + person.name.last.capitalized
        cell.detailTextLabel?.text = person.location.city
        
        //adding thumbnail image from the internet
        if let pictureURL = URL(string: person.picture.thumbnail){
            DispatchQueue.global().sync{
                if let data = try? Data.init(contentsOf: pictureURL)  {
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
                        //Call this method on your application’s main thread when you want to adjust the layout of a view’s subviews. This method makes a note of the request and returns immediately. Because this method does not force an immediate update, but instead waits for the next update cycle, you can use it to invalidate the layout of multiple views before any of those views are updated. This behavior allows you to consolidate all of your layout updates to one update cycle, which is usually better for performance.
                        //refreshes the cell
                        cell.setNeedsLayout()
                    }
                }
            }
        }
        
        return cell
    }
}


//make extension for searchBar funtionality
//extension ContactsTableViewController: UISearchController {
    
    
    
    
    
    
//}





































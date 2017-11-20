//
//  APIManager.swift
//  AC-iOS-U3W1HW-Parsing
//
//  Created by C4Q on 11/19/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class APIManager {
    func getData(endpoint: String, completionHandler: @escaping (Data?) -> ()) {
        guard let url = URL(string: endpoint) else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("Could not grab data")
                print(error)
                completionHandler(data)
                return
            }
            
            if let data = data {
                completionHandler(data)
            }
        }
        task.resume()
    }
}

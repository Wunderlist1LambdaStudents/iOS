//
//  EntryController.swift
//  Wunderlist
//
//  Created by Vincent Hoang on 5/28/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    func fetchEntriesFromAPI(completion: @escaping NetworkController.CompletionHandler = { _ in }) {
        
        let token = UserController.shared.bearer?.token
        
        let url = URL(string: "/api/todos", relativeTo: NetworkController.baseURL)!
        var requestURL = URLRequest(url: url)
        requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestURL.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if let error = error {
                NSLog("Error fetching tasks: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from API")
                completion(.failure(.noData))
                return
            }
            
            
        }
    }
}

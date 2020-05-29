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
    
    init() {
        fetchEntriesFromAPI()
    }
    
    func fetchEntriesFromAPI(completion: @escaping NetworkController.CompletionHandler = { _ in }) {
        
        let token = UserController.shared.bearer?.token
        
        let url = URL(string: "/api/todos", relativeTo: NetworkController.baseURL)!
        var requestURL = URLRequest(url: url)
        requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestURL.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
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
            
            do {
                let entryRepresentations = Array(try JSONDecoder().decode([String : EntryRepresentation].self, from: data).values)
                
                try self.updateEntries(with: entryRepresentations)
            } catch {
                NSLog("Error decoding entries from API: \(error)")
                completion(.failure(.failedDecode))
            }
        }.resume()
    }
    
    private func updateEntries(with representations: [EntryRepresentation]) throws {
        let entriesToFetch = representations.compactMap { $0.id }
        
        let representationsByID = Dictionary(uniqueKeysWithValues: zip(entriesToFetch, representations))
        
        var entriesToCreate = representationsByID
        
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id IN %@", entriesToFetch)
        
        let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
        
        var error: Error?
    }
}

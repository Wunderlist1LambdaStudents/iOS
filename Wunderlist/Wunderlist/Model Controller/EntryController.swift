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
    
    static let shared = EntryController()
    
    func fetchEntriesFromAPI(completion: @escaping NetworkController.CompletionHandler = { _ in }) {
        
        let token = UserController.shared.bearer?.token
        
        let url = URL(string: "/api/todos",
                      relativeTo: NetworkController.baseURL)!
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = RequestType.get.rawValue
        requestURL.addValue("application/json",
                            forHTTPHeaderField: "Content-Type")
        requestURL.setValue("Bearer \(token ?? "")",
            forHTTPHeaderField: "Authorization")
        
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
                let entryRepresentations = Array(try JSONDecoder().decode([String : EntryRepresentation].self,
                                                                          from: data).values)
                
                try self.updateEntries(with: entryRepresentations)
            } catch {
                NSLog("Error decoding entries from API: \(error)")
                completion(.failure(.failedDecode))
            }
        }.resume()
    }
    
    private func updateEntries(with representations: [EntryRepresentation]) throws {
        let entriesToFetch = representations.compactMap { $0.id }
        
        let representationsByID = Dictionary(uniqueKeysWithValues: zip(entriesToFetch,
                                                                       representations))
        
        var entriesToCreate = representationsByID
        
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id IN %@",
                                             entriesToFetch)
        
        let backgroundContext = CoreDataStack.shared.container.newBackgroundContext()
        
        var error: Error?
        
        backgroundContext.performAndWait {
            do {
                let existingEntries = try backgroundContext.fetch(fetchRequest)
                
                for entry in existingEntries {
                    guard let representation = representationsByID[entry.id] else { continue }
                    
                    self.update(entry: entry, with: representation)
                    entriesToCreate.removeValue(forKey: entry.id)
                }
            } catch let fetchError {
                error = fetchError
            }
            
            
            for representation in entriesToCreate.values {
                Entry(entryRepresentation: representation,
                      context: backgroundContext)
            }
        }
        
        if let error = error { throw error }
        
        try CoreDataStack.shared.save(context: backgroundContext)
    }
    
    private func update(entry: Entry,
                        with representation: EntryRepresentation) {
        entry.bodyDescription = representation.bodyDescription
        entry.completed = representation.completed
        entry.important = representation.important
        entry.title = representation.title
        entry.date = representation.date
    }
    
    func sendEntryToServer(entry: EntryWithoutID,
                           completion: @escaping NetworkController.CompletionHandler = { _ in }) {
        let token = UserController.shared.bearer?.token
        let id = UserController.shared.bearer?.id
        
        let url = URL(string: "/api/users/\(id ?? 0)/todos",
            relativeTo: NetworkController.baseURL)!
        
        var request = URLRequest(url: url)
        request.httpMethod = RequestType.post.rawValue
        request.addValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token ?? "")",
                         forHTTPHeaderField: "Authorization")
        
        do {
            request.httpBody = try JSONEncoder().encode(entry)
            

        } catch {
            NSLog("Error encoding entry \(entry): \(error)")
            completion(.failure(.failedEncode))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Error sending entry to server \(entry): \(error)")
                completion(.failure(.otherError))
                return
            }
            
            completion(.success(true))
        }.resume()
    }
    
    func createEntry(id: Int,
                     title: String,
                     bodyDescription: String,
                     date: Date,
                     completed: Bool = false,
                     important: Bool,
                     user_id: Int) {
        let entryWithoutID = EntryWithoutID(title: title,
                                            bodyDescription: bodyDescription,
                                            important: important,
                                            completed: false,
                                            user_id: Int32(user_id),
                                            date: date)
        
        sendEntryToServer(entry: entryWithoutID)
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
}

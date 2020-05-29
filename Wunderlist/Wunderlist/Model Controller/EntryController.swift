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
    
    var entries: [EntryRepresentation] = []
    
    func fetchEntriesFromAPI(completion: @escaping NetworkController.CompletionHandler = { _ in }) {
        
        let token = UserController.shared.bearer?.token
        let userId = UserController.shared.bearer?.id
        
        
        let url = URL(string: "/api/users/\(userId ?? 0)/todos",
                      relativeTo: NetworkController.baseURL)!
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = RequestType.get.rawValue
        requestURL.addValue("application/json",
                            forHTTPHeaderField: "Content-Type")
        requestURL.setValue("\(token ?? "")",
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
                let entryRepresentations = Array(try JSONDecoder().decode([String : EntryRepresentation].self, from: data).values)
                
                try self.updateEntries(with: entryRepresentations)
                self.entries = entryRepresentations
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
        entry.completed = (representation.completed == 0 ? false : true)
        entry.important = (representation.important == 0 ? false : true)
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
        request.setValue("\(token ?? "")",
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
        let _ = Entry(id: Int32(id), title: title, bodyDescription: bodyDescription, date: date, completed: completed, important: important, user_id: Int32(user_id))
        
   //     sendEntryToServer(entry: entryWithoutID)
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    func updater(entry: Entry, title: String, description: String, date: Date, important: Bool) {
        entry.title = title
        entry.bodyDescription = description
        entry.date = Date()
        entry.important = important
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    func updateComplete(entry: Entry) {
        entry.completed = true
        
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    func delete(entry: Entry) {
        
        CoreDataStack.shared.mainContext.delete(entry)
      //  deleteEntryFromServer(entry: entry)
        do {
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
}

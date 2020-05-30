//
//  Entry+Convenience.swift
//  Wunderlist
//
//  Created by Vincent Hoang on 5/27/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    
    var entryRepresentation: EntryRepresentation? {
        guard let title = title, let desc = bodyDescription, let date = date else {
            return nil
        }
        
    
        return EntryRepresentation(title: title,
                                   bodyDescription: desc,
                                   important: (important ? 1 : 0),
                                   completed: (completed ? 1 : 0),
                                   id: id,
                                   userId: userId,
                                   date: date)
    }
    
    @discardableResult convenience init(id: Int32,
                                        title: String,
                                        bodyDescription: String,
                                        date: Date,
                                        completed: Bool = false,
                                        important: Bool = false,
                                        userId: Int32,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.title = title
        self.bodyDescription = bodyDescription
        self.date = date
        self.id = id
        self.userId = userId
        self.completed = completed
        self.important = important
    }
    
    @discardableResult convenience init?(entryRepresentation: EntryRepresentation,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(id: entryRepresentation.id,
                  title: entryRepresentation.title,
                  bodyDescription: entryRepresentation.bodyDescription,
                  date: entryRepresentation.date,
                  completed: (entryRepresentation.completed == 0 ? false : true),
                  important: (entryRepresentation.important == 0 ? false : true),
                  userId: entryRepresentation.userId,
                  context: context)
    }
}

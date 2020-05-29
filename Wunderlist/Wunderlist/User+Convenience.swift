//
//  User.swift
//  Wunderlist
//
//  Created by Vincent Hoang on 5/27/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import Foundation
import CoreData

extension User {
    
    @discardableResult convenience init(id: Int,
                                        name: String,
                                        password: String,
                                        entries: NSSet,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.name = name
        self.entries = entries
        self.password = password
    }
    
    
}

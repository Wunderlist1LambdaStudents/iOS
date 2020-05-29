//
//  EntryRepresentation.swift
//  Wunderlist
//
//  Created by Vincent Hoang on 5/27/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import Foundation

struct EntryRepresentation: Codable {
    var title: String
    var bodyDescription: String
    var important: Int32
    var completed: Int32
    var id: Int32
    var user_id: Int32
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case title
        case bodyDescription = "description"
        case important
        case completed
        case id
        case user_id
        case date = "date_time"
    }
}

struct EntryWithoutID: Codable {
    var title: String
    var bodyDescription: String
    var important: Bool
    var completed: Bool
    var user_id: Int32
    var date: Date
    
    enum CodingKeys: String, CodingKey {
        case title
        case bodyDescription = "description"
        case important
        case completed
        case user_id
        case date = "date_time"
    }
}

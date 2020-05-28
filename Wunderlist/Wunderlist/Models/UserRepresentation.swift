//
//  UserRepresentation.swift
//  Wunderlist
//
//  Created by Vincent Hoang on 5/27/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import Foundation

struct UserRepresentation: Codable {
    var name: String
    var password: String
    
    enum CodingKeys: String, CodingKey {
        case name = "username"
        case password
    }
}

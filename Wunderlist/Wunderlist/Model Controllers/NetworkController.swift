//
//  NetworkController.swift
//  Wunderlist
//
//  Created by Vincent Hoang on 5/27/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noData
    case otherError
    case failedDecode
    case failedEncode
}

enum RequestType: String {
    case put = "PUT"
    case get = "GET"
    case post = "POST"
}

class NetworkController {
    static let baseURL = URL(string: "https://bw-wunderlist2.herokuapp.com/")!
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
}

//
//  UserController.swift
//  Wunderlist
//
//  Created by Vincent Hoang on 5/27/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import Foundation

class UserController {
    
    func registerUser(userName: String, password: String, completion: @escaping NetworkController.CompletionHandler = { _ in }) {
        
        let registerURL = URL(string: "/api/auth/register", relativeTo: NetworkController.baseURL)!
        
        var request = URLRequest(url: registerURL)
        request.httpMethod = RequestType.post.rawValue
        
        let bodyData = "username=\(userName)&password=\(password)"
        request.httpBody = bodyData.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Error registering user: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            completion(.success(true))
        }.resume()
    }
}

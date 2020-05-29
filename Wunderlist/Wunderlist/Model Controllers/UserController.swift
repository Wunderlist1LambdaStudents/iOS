//
//  UserController.swift
//  Wunderlist
//
//  Created by Vincent Hoang on 5/27/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import Foundation

class UserController {
    
    static let shared = UserController()
    
    var bearer: Bearer?
    
    func registerUser(username: String,
                      password: String,
                      completion: @escaping NetworkController.CompletionHandler = { _ in }) {
        
        let registerURL = URL(string: "/api/auth/register",
                              relativeTo: NetworkController.baseURL)!
        
        var request = URLRequest(url: registerURL)
        request.httpMethod = RequestType.post.rawValue
        request.addValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        
        do {
            let userRepresentation = UserRepresentation(username: username,
                                                        password: password)
            request.httpBody = try JSONEncoder().encode(userRepresentation)
        } catch {
            NSLog("Error encoding user: \(error)")
            completion(.failure(.failedEncode))
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if let error = error {
                NSLog("Error registering user: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            completion(.success(true))
        }.resume()
    }
    
    func loginUser(username: String,
                   password: String,
                   completion: @escaping NetworkController.CompletionHandler = { _ in }) {
        let loginURL = URL(string: "/api/auth/login",
                           relativeTo: NetworkController.baseURL)!
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = RequestType.post.rawValue
        request.addValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        
        do {
            let representation = UserRepresentation(username: username,
                                                    password: password)
            request.httpBody = try JSONEncoder().encode(representation)
        } catch {
            NSLog("Error encoding user \(error)")
            completion(.failure(.failedEncode))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Error registering user: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from server while logging in")
                completion(.failure(.noData))
                return
            }
            
            do {
                self.bearer = try JSONDecoder().decode(Bearer.self, from: data)
                completion(.success(true))
            } catch {
                NSLog("Error decoding bearer object: \(error)")
                completion(.failure(.failedDecode))
                return
            }
            
            completion(.success(true))
        }.resume()
    }
}

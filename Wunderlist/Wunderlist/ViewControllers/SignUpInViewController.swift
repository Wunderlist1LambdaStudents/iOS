//
//  SignUpInViewController.swift
//  Wunderlist
//
//  Created by Bradley Diroff on 5/26/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import UIKit

class SignUpInViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var changeButton: UIButton!
    
    private var isSignUpMode: Bool = false
    
    let segueName = "loginSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        let username = nameField.text ?? ""
        let password = passField.text ?? ""
        
        
        if !username.isEmpty && !password.isEmpty {
            if isSignUpMode {
                UserController.shared.registerUser(username: username, password: password) { result in
                    do {
                        let success = try result.get()
                        if success {
                            NSLog("Sign up successful")
                            
                            DispatchQueue.main.async {
                                let alert = UIAlertController(title: "Success", message: "You may now log in", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))
                            
                                self.present(alert, animated: true)
                                self.toggleSignUpType()
                            }
                            
                        } else {
                            NSLog("Sign up unsuccessful")
                            
                            DispatchQueue.main.async {
                                let alert = UIAlertController(title: "Error", message: "Unable to sign up", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                                
                                self.present(alert, animated: true)
                            }

                        }
                    } catch {
                        NSLog("Error signing up")
                        return
                    }
                }
            } else {
                UserController.shared.loginUser(username: username, password: password) { result in
                    do {
                        let success = try result.get()
                        if success {
                            NSLog("Login successful")
                            
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: self.segueName, sender: nil)
                            }
                        }
                    } catch {
                        NSLog("Error logging in")
                        return
                    }
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Username and/or password fields must not be empty!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            present(alert, animated: true)
        }
        
    }
    
    @IBAction func changeSignType(_ sender: Any) {
        toggleSignUpType()
    }
    
    private func toggleSignUpType() {
        if isSignUpMode {
            signInButton.setTitle("Sign In", for: .normal)
            changeButton.setTitle("Don't have an account?", for: .normal)
        } else {
            signInButton.setTitle("Sign Up", for: .normal)
            changeButton.setTitle("Already have an account?", for: .normal)
        }
        
        isSignUpMode = !isSignUpMode
    }
    
}

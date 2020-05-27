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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInTapped(_ sender: Any) {
    }
    
    @IBAction func changeSignType(_ sender: Any) {
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

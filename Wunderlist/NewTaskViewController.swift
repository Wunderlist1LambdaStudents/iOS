//
//  NewTaskViewController.swift
//  Wunderlist
//
//  Created by Akmal Nurmatov on 5/27/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var dailyButton: UIButton!
    @IBOutlet weak var monthlyButton: UIButton!
    @IBOutlet weak var yearlyButton: UIButton!
    @IBOutlet weak var taskTitle: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTaskButton(_ sender: UIButton) {
    }
    
    @IBAction func dismissPage(_ sender: Any) {
    }
    
    @IBAction func dailyTapped(_ sender: UIButton) {
    }
    
    @IBAction func monthlyTapped(_ sender: UIButton) {
    }
    
    @IBAction func yearlyTapped(_ sender: UIButton) {
    }
    
    
    
}

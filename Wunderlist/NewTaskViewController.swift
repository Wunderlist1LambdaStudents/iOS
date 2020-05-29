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
    @IBOutlet weak var importantSwitch: UISwitch!
    

    var entryController: EntryController?
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTaskButton(_ sender: UIButton) {
        guard let titleName = taskNameTextField.text, titleName != "",
            let description = notesTextField.text,
            description != "" else { return }
        
        var important = false
        
        if importantSwitch.isOn {
            important = true
        }
        
        guard let userId = UserController.shared.bearer?.id else {
            NSLog("Unable to get user_id, bearer object null in UserController")
            return
        }
        
        EntryController.shared.createEntry(id: Int(userId),
                                           title: titleName,
                                           bodyDescription: description,
                                           date: datePicker.date,
                                           important: important,
                                           user_id: Int(userId))
        
        do {
             try CoreDataStack.shared.mainContext.save()
             navigationController?.dismiss(animated: true,
                                           completion: nil)
         } catch {
             NSLog("Error saving managed object context: \(error)")
         }
    }
    
    @IBAction func dismissPage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dailyTapped(_ sender: UIButton) {
    }
    
    @IBAction func monthlyTapped(_ sender: UIButton) {
    }
    
    @IBAction func yearlyTapped(_ sender: UIButton) {
    }
    
}

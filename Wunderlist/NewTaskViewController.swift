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

    var entryController: EntryController?
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTaskButton(_ sender: UIButton) {
        guard let titleName = taskNameTextField.text, titleName != "", let description = notesTextField.text, description != ""  else { return }
        
        guard let userId = UserController.shared.bearer?.id else {
            NSLog("Unable to get user_id, bearer object null in UserController")
            return
        }
        
        let entry = EntryWithoutID(title: titleName, bodyDescription: description, important: false, completed: false, user_id: userId, date: Date())
        
        EntryController.shared.sendEntryToServer(entry: entry) { result in

            guard let success = try? result.get() else {
                return
            }
            
            if success {
                NSLog("Successfully sent entry to server")
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        NSLog("attempting to send entry to server")
//        do {
//            try CoreDataStack.shared.mainContext.save()
//            navigationController?.dismiss(animated: true, completion: nil)
//        } catch {
//            NSLog("Error saving managed object context: \(error)")
//        }
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

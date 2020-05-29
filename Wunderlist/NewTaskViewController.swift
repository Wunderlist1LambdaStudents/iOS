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
        
        let entry = Entry(id: Int32.random(in: 1...10000000), title: titleName, bodyDescription: description, date: Date(), completed: false, important: false, user_id: userId)
        
        entryController?.sendEntryToServer(entry: entry)
        
        do {
            try CoreDataStack.shared.mainContext.save()
            navigationController?.dismiss(animated: true, completion: nil)
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

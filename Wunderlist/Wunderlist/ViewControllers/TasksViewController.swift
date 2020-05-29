//
//  TasksViewController.swift
//  Wunderlist
//
//  Created by Bradley Diroff on 5/27/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTaskTapped(_ sender: Any) {
    }

}

extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let warningCell = UITableViewCell()
        warningCell.backgroundColor = UIColor.red
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TasksTableViewCell else {return warningCell}
        
        cell.delegate = self
        
        return cell
    }
}

extension TasksViewController: AddOldEntryDelegate {
    func entryAdd(_ item: Entry) {
   //     UserController.shared.updateToComplete(item)
    }
}

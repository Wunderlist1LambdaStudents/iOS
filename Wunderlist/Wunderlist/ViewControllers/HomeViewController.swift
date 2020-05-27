//
//  HomeViewController.swift
//  Wunderlist
//
//  Created by Bradley Diroff on 5/27/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.accessibilityIdentifier = "Wunderlist.searchBar"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
    }
    
    @IBAction func addTaskTapped(_ sender: Any) {
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

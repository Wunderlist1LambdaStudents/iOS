//
//  TasksTableViewCell.swift
//  Wunderlist
//
//  Created by Bradley Diroff on 5/28/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import UIKit

protocol AddOldEntryDelegate {
func entryAdd(_ item: Entry)
}

class TasksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buttonFace: UIButton!
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    var delegate: AddOldEntryDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let entry = entry else {return}
        delegate?.entryAdd(entry)
    }
    
    func updateViews() {
        guard let entry = entry else {return}
        
        nameLabel.text = entry.title
        descriptionLabel.text = entry.description
        
        if entry.completed == false {
            buttonFace.setTitle("Not Done",for: .normal)
        } else {
            buttonFace.setTitle("Done",for: .normal)
        }
        
    }

}

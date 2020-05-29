//
//  HomeTableViewCell.swift
//  Wunderlist
//
//  Created by Bradley Diroff on 5/28/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import UIKit

protocol ChangeStatusDelegate {
func entryChange(_ item: Entry)
}


class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buttonFace: UIButton!
    
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    
    var delegate: ChangeStatusDelegate?
    
    @IBAction func buttonPress(_ sender: UIButton) {
        guard let entry = entry else {return}
        delegate?.entryChange(entry)
    }
    
    func updateViews() {
        guard let entry = entry else {return}
        
        nameLabel.text = entry.title
        descriptionLabel.text = entry.description
        
        if entry.completed == false {
            buttonFace.setTitle("Done",for: .normal)
        } else {
            buttonFace.setTitle("Not Done",for: .normal)
        }
        

    }
}

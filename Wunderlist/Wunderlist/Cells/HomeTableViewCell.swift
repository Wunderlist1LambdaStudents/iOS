//
//  HomeTableViewCell.swift
//  Wunderlist
//
//  Created by Bradley Diroff on 5/28/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buttonFace: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func buttonPress(_ sender: UIButton) {
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

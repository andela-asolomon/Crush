//
//  TimelineTableViewCell.swift
//  DemoInsta
//
//  Created by Ayoola Solomon on 7/15/15.
//  Copyright (c) 2015 Ayoola Solomon. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var crushBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        crushBtn.layer.cornerRadius = 5
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}

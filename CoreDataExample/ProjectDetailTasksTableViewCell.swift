//
//  ProjectDetailTableViewCell.swift
//  CoreDataExample
//
//  Created by Piera Marchesini on 28/09/17.
//  Copyright © 2017 Piera Marchesini. All rights reserved.
//

import UIKit

class ProjectDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var taskTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

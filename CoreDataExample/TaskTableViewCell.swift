//
//  TaskTableViewCell.swift
//  CoreDataExample
//
//  Created by Piera Marchesini on 27/09/17.
//  Copyright © 2017 Piera Marchesini. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleTask: UILabel!
    @IBOutlet weak var priorityTask: UILabel!
    @IBOutlet weak var dateTask: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

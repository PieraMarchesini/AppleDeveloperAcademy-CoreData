//
//  ProjectDetailProjectNameTableViewCell.swift
//  CoreDataExample
//
//  Created by Piera Marchesini on 28/09/17.
//  Copyright © 2017 Piera Marchesini. All rights reserved.
//

import UIKit

class ProjectDetailProjectNameTableViewCell: UITableViewCell {

    @IBOutlet weak var projectName: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

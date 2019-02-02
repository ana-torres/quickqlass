//
//  ActivityTableViewCell.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 19/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var completedSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

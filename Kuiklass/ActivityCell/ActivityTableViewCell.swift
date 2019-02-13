//
//  ActivityTableViewCell.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 19/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        checkButton.setImage(UIImage(named:"check" ), for: .normal)
        checkButton.setImage(UIImage(named:"checkok"), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setActivityData(_ title: String, _ dateTime: String, _ completedSwitch: Bool) {
        titleLabel.text = title
        dateTimeLabel.text = dateTime
    }

    @IBAction func checkActivity(_ sender: UIButton){
        UIView.animate(withDuration: 0, delay: 0, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
        }) { (success) in
            UIView.animate(withDuration: 0, delay: 0, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
                self.titleLabel.textColor = UIColor.gray
                self.dateTimeLabel.textColor = UIColor.gray
            
            }, completion: nil)
        }
    }
}

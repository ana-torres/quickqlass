//
//  CourseCollectionViewCell.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 15/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import UIKit

class CourseCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var courseDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func setUpViews() {
        
        //Borde redondeado
        self.courseImage.layer.borderWidth = 1
        self.courseImage.layer.cornerRadius = 4
        self.courseImage.layer.borderColor = UIColor.clear.cgColor
        self.courseImage.layer.masksToBounds = true
        
        //Sombreado de la celda
        self.backgroundColor = .clear
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 5)
        self.layer.shadowOpacity = 0.9
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 4).cgPath
        self.contentView.layer.cornerRadius = 20
        
    }
    

}

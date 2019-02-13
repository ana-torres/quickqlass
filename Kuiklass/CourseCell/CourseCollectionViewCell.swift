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
    @IBOutlet weak var mainView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.backgroundColor = UIColor.clear
    
        
    }
    
    func setUpViews() {
        
        self.courseImage.alpha = 0.1
        
        //Borde redondeado
        self.mainView.layer.borderWidth = 2
        self.mainView.layer.cornerRadius = 4
        self.mainView.layer.borderColor = UIColor(red:0.31, green:0.80, blue:0.66, alpha:1.0).cgColor
        self.mainView.layer.masksToBounds = true

        
        //Sombreado de la celda
        self.backgroundColor = .white
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red:0.21, green:0.31, blue:0.34, alpha:0.5).cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 5)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 4).cgPath
        self.contentView.layer.cornerRadius = 20
        
    }
    

}

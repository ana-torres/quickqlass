//
//  TabController.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 04/02/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

class TabController: RAMAnimatedTabBarController {

    var activities: [Activity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

//            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        // Do any additional setup after loading the view.
        
    
    }
    @objc func addTapped() {
        self.performSegue(withIdentifier: "addActivity", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

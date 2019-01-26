//
//  AddCourseViewController.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 15/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class AddCourseViewController: BaseViewController {
    
    @IBOutlet weak var name: UITextField!
    var ref: DatabaseReference!


    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference(withPath: "courses")
        
    }
    
    
    
    @IBAction func addCourse (_ sender: Any){
        
        loadingShow()
        
        guard let courseName = name.text else {return}
    
        var courseItem = Course(courseName)
        
        let uid = self.ref?.childByAutoId().key
        self.ref?.updateChildValues(["\(uid!)": courseItem.toAnyObject()], withCompletionBlock: {error, ref in
            
                self.alertLoading.dismiss(animated: true, completion: {
                    self.navigationController?.popViewController(animated: true)
                })
            
            if error != nil {
                print("ERROR")
                return
            }
            
        })
    }

}

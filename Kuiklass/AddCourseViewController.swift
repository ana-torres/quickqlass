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
    var courses: [Course] = []


    override func viewDidLoad() {
        super.viewDidLoad()

        let user = Auth.auth().currentUser
        ref = Database.database().reference(withPath: "course")
        
    }
    
    
    
    @IBAction func addCourse (_ sender: Any){
        
        loadingShow()
        
        guard let courseName = name.text else {return}
    
        let user = Auth.auth().currentUser
        var courseItem = Course(courseName, user!.uid)
        
        
//       Anotaciones de un ejemplo self.ref.child("users").child(self.user.uid).child("items").childByAutoId().child("title").setValue(userInput)
        
        let cid = self.ref?.childByAutoId().key
        self.ref?.updateChildValues(["\(cid!)": courseItem.toAnyObject()], withCompletionBlock: {error, ref in
            
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

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
    
    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var courseDescription: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var ref: DatabaseReference?


    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.mainButton()
        


        ref = Database.database().reference(withPath: "courses")
        
    }
    
    
    
    @IBAction func addCourse (_ sender: Any){
        
        loadingShow()
        
//
       let user = Auth.auth().currentUser!

        
        guard let courseName = courseName.text else { return }
        guard let courseDescription = courseDescription.text else { return }
        var courseItem = Course(courseName, courseDescription)
//       Anotaciones de un ejemplo self.ref.child("users").child(self.user.uid).child("items").childByAutoId().child("title").setValue(userInput)
        
        let key = self.ref?.child("courses").childByAutoId().key
        
        self.ref?.child(user.uid).updateChildValues(["\(key!)": courseItem.toAnyObject()], withCompletionBlock: {error, ref in
            
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

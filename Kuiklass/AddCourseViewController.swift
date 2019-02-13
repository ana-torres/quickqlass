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
import Kingfisher

class AddCourseViewController: BaseViewController {
    
    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var courseDescription: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var imageUrl: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var addButton: UIButton!


    
    var ref: DatabaseReference?


    override func viewDidLoad() {
        super.viewDidLoad()
        

        addButton.mainButton()
        courseName.mainField()
        courseLabel.fieldLabel()
        courseDescription.mainField()
        descriptionLabel.fieldLabel()
        imageButton.secButton()

        ref = Database.database().reference(withPath: "courses")
        
    }
    
    
    @IBAction func addCourse (_ sender: Any){
        
        loadingShow()
        
//
       let user = Auth.auth().currentUser!

        
        guard let courseName = courseName.text else { return }
        guard let courseDescription = courseDescription.text else { return }
        var courseItem = Course(courseName, courseDescription, imageUrl.text ?? "")
//       Anotaciones de un ejemplo self.ref.child("users").child(self.user.uid).child("items").childByAutoId().child("title").setValue(userInput)
        
        let key = self.ref?.child("courses").child(user.uid).childByAutoId().key
        
        self.ref?.child(user.uid).updateChildValues(["\(key!)": courseItem.toAnyObject()], withCompletionBlock: {error, ref in
            
                self.alertLoading.dismiss(animated: true, completion: {
                    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home")
                    self.present(controller, animated: true, completion: nil)
                })
            
            if error != nil {
                print("ERROR")
                return
            }
            
        })
    }
    
    @IBAction func loadImage(_ sender: Any){
        
        let url = URL(string: imageUrl.text ?? "")
        imageView.kf.setImage(with: url)
        imageView.contentMode = .scaleAspectFit
                
    }
}


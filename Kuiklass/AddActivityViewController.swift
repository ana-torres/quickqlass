//
//  AddActivityViewController.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 15/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//
/*
import UIKit
import FirebaseDatabase
import FirebaseAuth

class AddActivityViewController: BaseViewController {
    
    @IBOutlet weak var activityName: UITextField!
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference(withPath: "activities")
        
    }
    
    @IBAction func addActivity (_ sender: Any){
        
        loadingShow()
        
        guard let activityName = activityName.text else {return}
        
        var activityItem = Activity(activityName, "")
        
        let key = self.ref?.childByAutoId().key
        self.ref?.updateChildValues(["\(key!)": activityItem.toAnyObject()], withCompletionBlock: {error, ref in
            
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
*/

//
//  AddActivityViewController.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 15/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class AddActivityViewController: BaseViewController {
    
    @IBOutlet weak var activityName: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.mainLabel()
        dateTimeLabel.mainLabel()
        addButton.mainButton()
        
        ref = Database.database().reference(withPath: "activities")
        
        datePicker.addTarget(self, action: #selector(AddActivityViewController.datePickerChanged), for: UIControl.Event.valueChanged)
        
    }
    
    @IBAction func addActivity (_ sender: Any){
        
        loadingShow()
        
        guard let activityName = activityName.text else {return}
        guard let activityDate = dateLabel.text else {return}
        
        let activityItem = Activity(activityName, activityDate, false)
        
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
    
    @IBAction func datePickerChanged(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: datePicker.date)
        dateLabel.text = strDate
    }




}


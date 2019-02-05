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

class AddActivityViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var activityName: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var ref: DatabaseReference!
    let importInfo = ImportInfo.shared

    var categories: [String] = [String]()
    var activityCateg: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        categoryPicker.delegate = self
        categoryPicker.dataSource = self

        nameLabel.fieldLabel()
        dateTimeLabel.fieldLabel()
        addButton.mainButton()
        activityName.mainField()
        categoryLabel.fieldLabel()
        
        categories = ["Actividad", "Examen", "Otro"]
        let user = Auth.auth().currentUser
        
        //aqui es en la rama en la que se escribe de Firebase
    
        
        ref = Database.database().reference(withPath: "courses").child(user!.uid).child((importInfo.currentCourse?.key)!)
        
        datePicker.addTarget(self, action: #selector(AddActivityViewController.datePickerChanged), for: UIControl.Event.valueChanged)
        
    }
    
    @IBAction func addActivity (_ sender: Any){
        
        loadingShow()
        
        guard let activityName = activityName.text else {return}
        guard let activityDate = dateLabel.text else {return}
        
        let activityItem = Activity(activityName, activityDate, false, activityCateg)
        let user = Auth.auth().currentUser
        
        let key = self.ref?.child("courses").child(user!.uid).child((importInfo.currentCourse?.key)!).childByAutoId().key
        
        self.ref?.child("activities").updateChildValues(["\(key!)": activityItem.toAnyObject()], withCompletionBlock: {error, ref in
            
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

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        activityCateg = categories[row]
    }
    

}


//
//  LoginViewController.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 10/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var regisButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginTitle.mainLabel()
        userLabel.fieldLabel()
        passwordLabel.fieldLabel()
        userField.mainField()
        passwordField.mainField()
        loginButton.mainButton()
        regisButton.secButton()
        forgotButton.secButton()
    
        // Do any additional setup after loading the view.
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

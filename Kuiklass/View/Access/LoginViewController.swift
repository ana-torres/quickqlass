//
//  LoginViewController.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 10/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var regisButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginTitle.mainLabel()
        emailField.mainField()
        passwordField.mainField()
        loginButton.mainButton()
        regisButton.secButton()
        forgotButton.secButton()
    
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func login(_ sender: Any) {
        
        loadingShow()
        
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            
            self.loadingHide()
            
            if ((error) != nil) {
                print("Error \(String(describing: error))")
            }
            
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainNav")
            self.present(controller, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func passwordReset(_ sender: UIButton) {
        let prompt = UIAlertController(title: "Recuperar Contraseña", message: "Email:", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            Auth.auth().sendPasswordReset(withEmail: self.emailField.text!, completion: { (error) in
                if let error = error {
                    if let errCode = AuthErrorCode(rawValue: error._code) {
                        switch errCode {
                        case .userNotFound:
                            //errorCodeUserNotFound
                            DispatchQueue.main.async {
                                self.showBasicAlert("Error","Usuario no registrado, inténtelo de nuevo")
                            }
                        default:
                            DispatchQueue.main.async {
                                self.showBasicAlert("Error", "\(error.localizedDescription)")
                            }
                        }
                    }
                    return
                } else {
                    DispatchQueue.main.async {
                        self.showBasicAlert("Recuperar contraseña", "Gracias! En breves recibirás un email para recuperar tu contraseña")
                    }
                }
            })
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
    }

}

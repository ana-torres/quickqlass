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
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var regisButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginTitle.mainLabel()
        emailLabel.fieldLabel()
        passwordLabel.fieldLabel()
        emailField.mainField()
        passwordField.mainField()
        loginButton.mainButton()
        regisButton.secButton()
        forgotButton.secButton()
    
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        loadingShow()
        
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            
            self.loadingHide()
            
            if ((error) != nil) {
                print("Error \(String(describing: error))")
            }
            
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home")
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
            Auth.auth().sendPasswordReset(withEmail: userInput!, completion: { (error) in
                if let error = error {
                    if let errCode = AuthErrorCode(rawValue: error._code) {
                        switch errCode {
                        case .errorCodeUserNotFound:
                            DispatchQueue.main.async {
                                self.showAlert("User account not found. Try registering")
                            }
                        default:
                            DispatchQueue.main.async {
                                self.showAlert("Error: \(error.localizedDescription)")
                            }
                        }
                    }
                    return
                } else {
                    DispatchQueue.main.async {
                        self.showAlert("You'll receive an email shortly to reset your password.")
                    }
                }
            })
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil)
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

//
//  RegisterViewController.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 10/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: BaseViewController {
    

    @IBOutlet weak var regisLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var termSwitch: UISwitch!
    @IBOutlet weak var completeButton: UIButton!
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        regisLabel.mainLabel()
        nameLabel.fieldLabel()
        surnameLabel.fieldLabel()
        emailLabel.fieldLabel()
        passwordLabel.fieldLabel()
        nameField.mainField()
        surnameField.mainField()
        emailField.mainField()
        passwordField.mainField()
        termsLabel.fieldLabel()
        completeButton.mainButton()
        
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func regisnUser(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (authResult, error) in
            
            if(error != nil){
                print("Es incorrecto \(String(describing: error))")
            }
            
            guard let user = authResult?.user else { return }
            self.ref.child("users").child(user.uid).setValue(["name": self.nameField.text, "surname": self.surnameField.text, "email": self.emailField.text])
            
        }
    
        
        guard let _ = nameField.text, nameField.text?.count != 0  else {
            alert("Nombre vacío", "Por favor, introduzca su nombre")
            return
        }
        
        guard let _ = surnameField.text, surnameField.text?.count != 0  else {
            alert("Apellidos vacíos", "Por favor, introduzca sus apellidos")
            return
        }
        
        guard let email = emailField.text, emailField.text?.count != 0  else {
            alert("Email vacío", "Por favor, introduzca un email")
            return
        }
        
        if isValidEmail(emailID: email) == false {
            alert("Email incorrecto", "Por favor, introduzca una dirección de email correcta")
            return
        }
        
        guard let password = passwordField.text, passwordField.text?.count != 0  else {
            alert("Contraseña vacía", "Por favor, introduzca una contraseña")
            return
        }
        
        if isValidPassword(passwordID: password) == false {
            alert("Contraseña inválida", "Por favor, introduzca una contraseña con entre 6 y 10 caracteres")
            return
        }
 
        let registro = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home") as! HomeViewController
        
        self.navigationController?.pushViewController(registro, animated: true)
 
    }
    
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func isValidPassword(passwordID: String) -> Bool {
        let passwordRegEx = "^[A-Z0-9a-z._%+-]{6,10}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: passwordID)
    }
    
    func alert(_ titulo: String,_ mensaje: String) {
        let myalert = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertController.Style.alert)
        myalert.addAction(UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction!) in
            print("Selected")
        })
        myalert.addAction(UIAlertAction(title: "Cancelar", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel")
        })
        
        self.present(myalert, animated: true)
        
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

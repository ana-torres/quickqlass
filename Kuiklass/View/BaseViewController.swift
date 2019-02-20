//
//  BaseViewController.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 26/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import UIKit
import Firebase
import RAMAnimatedTabBarController

class BaseViewController: UIViewController {
    
    let alertLoading = UIAlertController(title: nil, message: "Cargando...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loadingShow(){
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        
        alertLoading.view.addSubview(loadingIndicator)
        present(alertLoading, animated: true, completion: nil)
    }
    
    func loadingHide() {
        alertLoading.dismiss(animated: true, completion: nil)
    }
    
    func showBasicAlert(_ title: String, _ message: String){
        let myalert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        myalert.addAction(UIAlertAction(title: "Aceptar", style: .default) { (action:UIAlertAction!) in
            print("Selected")
        })
        
        self.present(myalert, animated: true)
    }
    
}

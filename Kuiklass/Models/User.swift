//
//  User.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 31/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct User {
    
    let uid: String
    let name: String
    var surname: String
    var email: String
    
    // Constructor estandar
    init(_ uid: String, _ name: String, _ surname: String, _ email: String) {
        self.uid = uid
        self.name = name
        self.surname = surname
        self.email = email
    }
    
    // constructor para leer de firebase
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let uid = value["uid"] as? String,
            let name = value["name"] as? String,
            let surname = value["surname"] as? String,
            let email = value["email"] as? String else {
                return nil
        }
        
        self.uid = uid
        self.name = name
        self.surname = surname
        self.email = email
    }
    
    // funcion para escribir en firebase de manera sencilla
    func toAnyObject() -> Any {
        return [
            "uid": uid,
            "name": name,
            "surname": surname,
            "email": email,
        ]
    }
}


//
//  Activity.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 15/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import Foundation
import FirebaseDatabase
struct Activity {
    
    let ref: DatabaseReference?

    var name: String
    var date: String
    var completed: Bool
//    enum Category: String {
//        case Class
//        case Exam
//        case Exercise
//    }
    
    // Constructor estandar
    init(/*_ uid: String = "",*/ _ name: String, /*_ idCourse: String,*/ _ date: String, _ completed: Bool /*_ categ: String*/) {
        self.ref = nil
        self.name = name
        self.date = date
     //   self.categ = categ
        self.completed = completed
    }
    
    // constructor para leer de firebase
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let date = value["date"] as? String,
           // let categ = value["categ"] as? String
            let completed = value["completed"] as? Bool
            else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.name = name
        self.date = date
        //self.categ = categ
        self.completed = completed
    
}
    
    // funcion para escribir en firebase de manera sencilla
    func toAnyObject() -> Any {
        return [
            "name": name,
            "date": date,
           // "categ": categ
            "completed": completed
        ]
    }
}

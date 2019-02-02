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
    let uid: String
    var name: String
    var date: Date
   // var date: String
   // var time: String
    //var idCourse: String
    //var categ: String
    var completed: Bool
    
    // Constructor estandar
    init(_ uid: String = "", _ name: String, _ idCourse: String, _ date: Date, _ completed: Bool /*_ categ: String*/) {
        self.ref = nil
        self.uid = uid
        self.name = name
        self.date = date
        //self.time = time
        //self.idCourse = idCourse
     //   self.categ = categ
        self.completed = completed
    }
    
    // constructor para leer de firebase
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            //let uid = value["uid"] as? String,
            let name = value["name"] as? String,
            let date = value["date"] as? Date,
            //let time = value["time"] as? String,
            //let idCourse = value["idCourse"] as? String,
           // let categ = value["categ"] as? String
            let completed = value["completed"] as? Bool
            else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.uid = snapshot.key
        self.name = name
        self.date = date
        //self.time = time
        //self.idCourse = idCourse
        //self.categ = categ
        self.completed = completed
    
}
    
    // funcion para escribir en firebase de manera sencilla
    func toAnyObject() -> Any {
        return [
            "uid": uid,
            "name": name,
            "date": date,
            //"time": time,
            //"idCourse": idCourse,
           // "categ": categ
            "completed": completed
        ]
    }
}

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
    
    var uid: String?
    let name: String
   // var date: String
   // var time: String
    var idCourse: String
    //var categ: String
    
    // Constructor estandar
    init(_ name: String, _ idCourse: String /*_ categ: String*/) {
        self.uid = nil
        self.name = name
        //self.date = date
        //self.time = time
        self.idCourse = idCourse
     //   self.categ = categ
    }
    
    // constructor para leer de firebase
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let uid = value["uid"] as? String,
            let name = value["name"] as? String,
            //let date = value["date"] as? String,
            //let time = value["time"] as? String,
            let idCourse = value["idCourse"] as? String//,
           // let categ = value["categ"] as? String
            else {
                return nil
        }
        
        self.uid = uid
        self.name = name
        //self.date = date
        //self.time = time
        self.idCourse = idCourse
        //self.categ = categ
    
}
    
    // funcion para escribir en firebase de manera sencilla
    func toAnyObject() -> Any {
        return [
            "uid": uid,
            "name": name,
            //"date": date,
            //"time": time,
            "idCourse": idCourse,
           // "categ": categ
        ]
    }
}

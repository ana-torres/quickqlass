//
//  Course.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 15/01/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Course {
    
    var ref: DatabaseReference?
   // var key: String
    var name: String
    var image: String
    var description: String
    //var activities: [Activity]
    //let userId: String
    // Constructor estandar
    init(_ name: String,_ description: String, _ image: String = ""/*, _ activities: [Activity] = [], _ userId: String*/) {
        self.ref = nil
        //self.key = key
        self.name = name
        self.image = image
        self.description = description
        //self.userId = userId
       // self.activities = activities
    }
    
    // constructor para leer de firebase
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            //let uid = value["uid"] as? String,
            let name = value["name"] as? String,
            let description = value["description"] as? String,
            let image = value["image"] as? String
            //let activities = value ["activities"] as? [Activity]
            //let userId = value ["userId"] as? String
            else {
                return nil
        }
        
        self.ref = snapshot.ref
        //self.key = snapshot.key
        self.name = name
        self.image = image
        self.description = description
        //self.activities = activities
        //self.userId = userId
    }
    
    
    // funcion para escribir en firebase de manera sencilla
    func toAnyObject() -> Any {
        return [
            "name": name,
            //"key": key,
            "image": image,
            "description": description,
            //"activities": activities
            //"userId" : userId
        ]
    }
}

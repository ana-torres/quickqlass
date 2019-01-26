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
    
    var uid: String?
    let name: String
    var image: String
    var activities: [Activity]
    //var completed: Bool
    // Constructor estandar
    init(_ name: String, _ image: String = "") {
        self.uid = nil
        self.name = name
        self.image = image
        self.activities = []
        //self.completed = true;
    }
    
    // constructor para leer de firebase
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let uid = value["uid"] as? String,
            let name = value["name"] as? String,
            let image = value["image"] as? String,
            var activities = value ["activities"] as? [Activity] else {
                return nil
        }
        
        self.uid = uid
        self.name = name
        self.image = image
        self.activities = []
    }
    
    
    // funcion para escribir en firebase de manera sencilla
    func toAnyObject() -> Any {
        return [
            "uid": uid,
            "name": name,
            "image": image,
            "activities": activities
        ]
    }
}

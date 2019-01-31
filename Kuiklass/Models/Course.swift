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
    var cid: String
    var name: String
    //var image: String
    var activities: [Activity]
    let userId: String
    // Constructor estandar
    init(_ cid: String = "", _ name: String, _ image: String = "", _ userId: String) {
        self.ref = nil
        self.cid = cid
        self.name = name
        //self.image = image
        self.activities = []
        self.userId = userId
    }
    
    // constructor para leer de firebase
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            //let uid = value["uid"] as? String,
            var name = value["name"] as? String,
            //let image = value["image"] as? String,
            var activities = value ["activities"] as? [Activity],
            let userId = value ["userId"] as? String
            else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.cid = snapshot.key
        self.name = name
        //self.image = image
        self.activities = []
        self.userId = userId
    }
    
    
    // funcion para escribir en firebase de manera sencilla
    func toAnyObject() -> Any {
        return [
            "cid": cid,
            "name": name,
           // "image": image,
            "activities": [activities],
            "userId" : userId
        ]
    }
}

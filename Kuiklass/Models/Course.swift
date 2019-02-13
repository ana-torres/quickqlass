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
    var name: String
    var image: String?
    var description: String
    var activities: [Activity] = []
    
    // Constructor estandar
    init(_ name: String,_ description: String, _ image: String = ""/*, _ activities: [Activity] = []*/) {
        self.ref = nil
        self.name = name
        self.image = image
        self.description = description

       // self.activities = activities
    }
    
    // constructor para leer de firebase
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let description = value["description"] as? String,
            let image = value["image"] as? String
            //let activities = value ["activities"] as? [Activity]
            else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.name = name
        self.image = image
        self.description = description
        //self.activities = activities
    }
    
    
    // funcion para escribir en firebase de manera sencilla
    func toAnyObject() -> Any {
        return [
            "name": name,
            //"key": key,
            "image": image,
            "description": description
            //"activities": activities
            //"userId" : userId
        ]
    }
}

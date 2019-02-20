//
//  ImportInfo.swift
//  Kuiklass
//
//  Created by Ana Torres Piedra on 05/02/2019.
//  Copyright © 2019 Ana Torres. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ImportInfo {
    
    static let shared = ImportInfo()
    
    var currentCourse: DatabaseReference?
    var myCurrentCourse: String?
    var currentActivity: DatabaseReference?
    var myCurrentActivity: String?
    
    init() {
        // don't forget to make this private
    }
}



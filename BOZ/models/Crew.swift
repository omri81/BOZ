//
//  Crew.swift
//  BOZ
//
//  Created by Bar Arbiv on 09/03/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Foundation

public class Crew{
    
    var name: String!
    var phone: String!
    var deleted: Bool!
    
    init(name: String, phone: String) {
        self.name = name
        self.phone = phone
        self.deleted = false
    }
    
}

//
//  Branch.swift
//  BOZ
//
//  Created by Bar Arbiv on 28/02/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Foundation

public class Branch{
    
    var name: String!
    var address: String!
    var phoneNumber: String!
    var lat: Double!
    var lon: Double!
    
    init(name: String, address: String, phoneNumber: String, lat: Double, lon: Double) {
        self.name = name
        self.address = address
        self.phoneNumber = phoneNumber
        self.lat = lat
        self.lon = lon
    }
    
}

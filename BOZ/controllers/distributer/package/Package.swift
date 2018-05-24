//
//  Package.swift
//  BOZ
//
//  Created by user134028 on 3/18/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Foundation

public struct Package {
    let idNumber:String
    let _id:String
    let name:String
    let famelyName:String
    let phoneNumber:String
    let address:String
    let latitude:Double
    let longitude:Double
    var itemList:[Item]
    var _rev:String
    init (
        idNumber:String,
        _id:String,
        name:String,
        famelyName:String,
        phoneNumber:String,
        address:String,
        latitude:Double,
        longitude:Double,
        itemList:[Item],
        _rev:String)
    {
        self.idNumber = idNumber
        self._id = _id
        self.name = name
        self.famelyName = famelyName
        self.phoneNumber = phoneNumber
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.itemList = itemList
        self._rev = _rev
    }
}
public struct Item {
    let title:String
    let amount:Int
    init (title:String,amount:Int)
    {
        self.title = title
        self.amount = amount
    }
}

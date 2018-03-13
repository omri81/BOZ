//
//  jsonMilkSubst.swift
//  BOZ
//
//  Created by user134028 on 3/12/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Foundation

public struct Doc {
    let docs : [Product]
    struct Product {
        var _id:String
        var _rev:String
        var cosher:String
        var amount:Double
        var description:String
        var manufacter:String
        var qr:String
        var spaciel:String
        var stage:Int
        var title:String
        var age:String
        init(
            _id:String?,
            _rev:String?,
            cosher:String?,
            amount:Double?,
            description:String?,
            manufacter:String?,
            qr:String?,
            spaciel:String?,
            stage:Int?,
            title:String?,
            age:String?)
        {
            self._id = _id ?? ""
            self._rev = _rev ?? ""
            self.cosher = cosher ?? ""
            self.amount = amount ?? 0
            self.description = description ?? ""
            self.manufacter = manufacter ?? ""
            self.qr = qr ?? ""
            self.spaciel = spaciel ?? ""
            self.stage = stage ?? 0
            self.title = title ?? ""
            self.age = age ?? ""
        }
    }
    init(docs:[Product]) {
        self.docs = docs
    }
}

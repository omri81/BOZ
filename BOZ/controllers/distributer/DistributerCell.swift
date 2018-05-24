//
//  DistributerCell.swift
//  BOZ
//
//  Created by user134028 on 4/26/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class DistributerCell: UICollectionViewCell {
    var lat:Double = 0, lon : Double = 0
    var phone:String = ""
    var _id: String = ""
    var _rev: String = ""
    
    @IBAction func phoneCall() {
        Methods.makePhoneCall(toNumber: phone)
    }
    @IBAction func gotoWaze() {
        Methods.tryNavigateWithWaze(lat: lat, lon: lon)
    }
    
    
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var addressLB: UILabel!
    @IBOutlet weak var dayLB: UILabel!
    @IBOutlet weak var hourLB: UILabel!
    
}

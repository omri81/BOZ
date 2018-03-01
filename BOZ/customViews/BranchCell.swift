//
//  BranchCell.swift
//  BOZ
//
//  Created by Bar Arbiv on 28/02/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class BranchCell: UICollectionViewCell {
    
    let WAZE_BTN = "wazeBtn"
    let PHONE_BTN = "phoneBtn"
    var lat: Double!
    var lon: Double!
    var phoneNumber: String!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBAction func onClick(sender: UIButton){
        if sender.restorationIdentifier == WAZE_BTN{
            Methods.tryNavigateWithWaze(lat: lat, lon: lon)
        }else{
            Methods.makePhoneCall(toNumber: phoneNumber)
        }
    }
    
    public func setCellData(branch: Branch){
        nameLbl.text? = branch.name
        addressLbl.text? = branch.address
        self.lat = branch.lat
        self.lon = branch.lon
        self.phoneNumber = branch.phoneNumber
        
    }
    
    
}

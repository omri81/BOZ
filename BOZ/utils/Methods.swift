//
//  Methods.swift
//  BOZ
//
//  Created by Bar Arbiv on 28/02/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

public class Methods{
    
    static let OFFICE_NUMBER = "0507888094"
    
    public static func makePhoneCall(toNumber : String){
        guard let url = URL(string: "tel://\(toNumber)") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    public static func makePhoneCallToOffice(){
        makePhoneCall(toNumber: OFFICE_NUMBER)
    }
    
    public static func tryNavigateWithWaze(lat : Double, lon : Double){
        
        if UIApplication.shared.canOpenURL(URL(string: "waze://")!) {
            // Waze is installed. Launch Waze and start navigation
            let urlStr: String = "waze://?ll=\(lat),\(lon)&navigate=yes"
            UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
        }
        else {
            // Waze is not installed. Launch AppStore to install Waze app
            UIApplication.shared.open(URL(string: "http://itunes.apple.com/us/app/id323229106")!, options: [:], completionHandler: nil)
        }
        
    }
    
}

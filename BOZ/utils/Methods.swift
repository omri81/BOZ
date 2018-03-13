//
//  Methods.swift
//  BOZ
//
//  Created by Bar Arbiv on 28/02/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

public class Methods{
    
    private static let OFFICE_NUMBER = "0507888094"
    private static let OFFICIAL_WEBSITE = "https://www.2help.org.il/"
    private static let OFFICIAL_FACEBOOK_PAGE_ID = "138399090105076"
    
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
    
    public static func openOfficialWebsite(){
        guard let url = URL(string: OFFICIAL_WEBSITE) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
   
    
    public static func openFacebookPage(){
        
        if UIApplication.shared.canOpenURL(URL(string: "fb://")!){
            let appUrl = "fb://profile/\(OFFICIAL_FACEBOOK_PAGE_ID)"
            UIApplication.shared.open(URL(string: appUrl)!, options: [:], completionHandler: nil)
        }else{
            UIApplication.shared.open(URL(string: "https://www.facebook.com/2help.org.il/")!, options: [:], completionHandler: nil)
        }
    }
    
}

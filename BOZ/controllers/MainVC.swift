//
//  MainVC.swift
//  BOZ
//
//  Created by Bar Arbiv on 27/02/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    private let TO_ABOUT_VC = "toAboutVC"
    private let TO_LOGIN_VC = "toLoginVC"
    private let TO_QUICK_DONATION_VC = "toQuickDonationVC"
    private let TO_ASK_DONATION_VC = "toAskDonationVC"
   
    
    private let ABOUT_BTN = "aboutBtn"
    private let LOGIN_BTN = "loginBtn"
    private let QUICK_DONATION_BTN = "quickDonationBtn"
    private let ASK_DONATION_BTN = "askDonationBtn"
    private let PHONE_BTN = "phoneBtn"
    private let WEBSITE_BTN = "websiteBtn"
    private let FACEBOOK_BTN = "facebookBtn"
    
    
    
    @IBOutlet weak var logoImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // first time user logs in, we store the privte key return from the server so next time we'll not ask credentials from the user and server and only inform the server for the login.
        
        let prefs = UserDefaults.standard
        let privateToken = prefs.string(forKey: BaseViewController.PRIVATE_GUID)
        if (privateToken != nil && privateToken != "")
        {
            print (privateToken)
            let next = storyboard!.instantiateViewController(withIdentifier: "toLoginVC") as! LoginVC
            next.Login(id:"",token:"", withPrivateToken:true)
        }
        
        logoImg.loadGif(name: "logo")
    }

    @IBAction func onBtnClicked(sender: UIButton){
        switch(sender.restorationIdentifier){
            case ABOUT_BTN?:
                performSegue(withIdentifier: TO_ABOUT_VC, sender: self)
            case LOGIN_BTN?:
                performSegue(withIdentifier: TO_LOGIN_VC, sender: self)
            case QUICK_DONATION_BTN?:
                performSegue(withIdentifier: TO_QUICK_DONATION_VC, sender: self)
            case ASK_DONATION_BTN?:
                performSegue(withIdentifier: TO_ASK_DONATION_VC, sender: self)      
            case PHONE_BTN?:
                Methods.makePhoneCallToOffice()
            case WEBSITE_BTN?:
                Methods.openOfficialWebsite()
            case FACEBOOK_BTN?:
                Methods.openFacebookPage()
            default:
                break
        }
    }

}











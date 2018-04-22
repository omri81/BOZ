//
//  MainVC.swift
//  BOZ
//
//  Created by Bar Arbiv on 27/02/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController {
    var products = [Doc.Product]()
    
    private let TO_ABOUT_VC = "toAboutVC"
    private let TO_LOGIN_VC = "toLoginVC"
    private let TO_QUICK_DONATION_VC = "toQuickDonationVC"
    private let TO_ASK_DONATION_NC = "toAskDonationNC"
   
    
    private let ABOUT_BTN = "aboutBtn"
    private let LOGIN_BTN = "loginBtn"
    private let LOGOUT_BTN = "logoutBtn"
    private let QUICK_DONATION_BTN = "quickDonationBtn"
    private let ASK_DONATION_BTN = "askDonationBtn"
    private let PHONE_BTN = "phoneBtn"
    private let WEBSITE_BTN = "websiteBtn"
    private let FACEBOOK_BTN = "facebookBtn"
  
    @IBOutlet weak var logoImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImg.loadGif(name: "logo")
    }
    override func viewDidAppear(_ animated: Bool) {
        // first time user logs in, we store the privte key return from the server so next time we'll not ask credentials from the user and server and only inform the server for the login.
    }
    @IBAction func onBtnClicked(sender: UIButton){
        switch(sender.restorationIdentifier){
            case ABOUT_BTN?:
                performSegue(withIdentifier: TO_ABOUT_VC, sender: self)
            case LOGIN_BTN?:
                performSegue(withIdentifier: TO_LOGIN_VC, sender: self)
        case LOGOUT_BTN?:
            dismiss(animated: true, completion: nil)
            
            case QUICK_DONATION_BTN?:
                performSegue(withIdentifier: TO_QUICK_DONATION_VC, sender: self)
                
            case ASK_DONATION_BTN?:
            
            let alert = UIAlertController(title: "האם רשום כבר?", message: "הכנס מזהה", preferredStyle: .alert)
            alert.addTextField(configurationHandler: {(tf) in
                tf.placeholder = "הכנס מזהה"
            })
            alert.addAction(UIAlertAction(title: "הכנס", style: .default, handler: {(check) in
                //check with server if token is valid
                self.TokenLogin(privateToken: alert.textFields![0].text!)
            }))
            alert.addAction(UIAlertAction(title: "הרשם כעת", style: .default, handler: {(apply) in
               Methods.openDonationFormWebsite()
            }))
            alert.addAction(UIAlertAction(title: "ביטול", style: .cancel, handler: nil))
            
            show(alert, sender: self)
        
            
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
    
    
    
    func TokenLogin(privateToken:String) {
        //add privateToken validation + alert if null..less then amount of digits..
        var URL_LOGIN = "https://zeevtesthu.mybluemix.net/api/Users/"
        
        let parameters: Parameters = [
            "token" : privateToken
        ]
        
        URL_LOGIN = URL_LOGIN + "LoginToken"
        
        Alamofire.request(URL_LOGIN, method: HTTPMethod.post , parameters: parameters ,
                          encoding: JSONEncoding.default, headers: [:])
            .validate(contentType: ["application/json"]).responseJSON { response in
                print("response: \(response)")
                switch response.result {
                case .success:
                    print("sucess response from server")
                    guard let responseJSON = response.result.value as? [String: Any],
                        let status = responseJSON["status"] as? String,
                        let statusMsg = responseJSON["statusMsg"] as? String
                        else {
                            self.alertServerProblem()
                            return
                    }
                    if status == "OK" {
                        print("login success")
                        guard let role = responseJSON["role"] as? String
                            else {
                                self.alertServerProblem()
                                return
                        }
                        //Enter to the app:
                        if role == "helples"
                        {
                            let prefs = UserDefaults.standard
                            prefs.set(privateToken, forKey: BaseViewController.PRIVATE_GUID)
                            prefs.set(role, forKey: DONATOR_ROLE)
                            
                            let mainVC =  self.storyboard?.instantiateViewController(withIdentifier: "toHelplessNC") as! HelplessNC
                            self.show(mainVC, sender: self)
                            
                        } else
                        {
                            self.alertLoginFail()
                        }
                    } else {
                        switch (statusMsg) {
                        case "Not approved":
                            print("Not approved")
                            self.LoginNotApproved()
                        case "Wrong Password":
                            print("wrong password")
                            self.loginWrongPassword()
                        default:
                            self.alertLoginFail()
                        }
                        self.alertLoginFail()
                    }
                    
                case .failure(let error):
                    print("error:\(error)")
                    self.alertLoginFail()
                }
        }
    }
    
    func alertMsg(title ttl:String,msg:String) {
        let alert = UIAlertController(
            title: ttl,
            message: msg,
            preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "בסדר", style: .default) { (action) in
            // do something when user press OK button, like deleting text in both fields or do nothing
        }
        
        alert.addAction(OKAction)
        
        present(alert, animated: true, completion: nil)
        return
    }
    
    func alertServerProblem(){
        alertMsg(title:"כשלון כניסה למערכת",
                 msg: "אין גישה לשרת, אולי בעיית תקשורת נסה מאוחר יותר בבקשה")
    }
    
    
    func alertLoginFail() {
        alertMsg(title:"כשלון כניסה למערכת",
                 msg: "נא וודא שהמזהה הוקלד כהלכה")
    }
    func LoginNotApproved() {
        alertMsg(title:"כשלון כניסה למערכת",
                 msg: " ההרשמה ממתינה לאישור מנהל")
        
    }
    func loginWrongPassword(){
        alertMsg(
            title: "מזהה שגוי",
            msg: "מזהה שגוי")
    }
    
    
    
}











//
//  LoginVC.swift
//  BOZ
//
//  Created by Bar Arbiv on 02/03/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {

    @IBOutlet weak var tokenTF: MyTextField!
    @IBOutlet weak var idNumberTF: MyTextField!
    private static let TO_REGISTER_VC = "toRegisterVC"
    private static let TO_ADMIN_VC = "toAdminVC"
    private static let TO_DELIVERY_VC = "toDeliveryVC"
    private static let TO_STORAGE_VC = "toStorageVC"
    
    private let LOGIN_BTN = "loginBtn"
    private let BACK_BTN = "backBtn"
    private let REGISTER_BTN = "registerBtn"
    
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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onClicked(sender: UIButton){
        switch sender.restorationIdentifier{
        case LOGIN_BTN?:
            if (idNumberTF.text!.isEmpty) || tokenTF.text!.isEmpty {
                alertMsg(title:"חסרים פרטים",msg:"נא למלא תעודת זהות וסיסמא")
                return
            }
            if ((idNumberTF.text!.count)<6 || tokenTF.text!.count < 3) {
                self.alertMsg(title:"נתונים לא חוקיים",msg:"תעודת זהות לפחות 6 תווים וסיסמה 3 תווים לפחות")
                return
            }
            // text is not empty and valid
            // send login request to the server:
            self.Login(id:idNumberTF.text!,token:tokenTF.text!)
            break
        case BACK_BTN?:
                break
        case REGISTER_BTN?:
                break
            default:
                break
        }
    }
    
    func alertServerProblem(){
        alertMsg(title:"כשלון כניסה למערכת",
                 msg: "אין גישה לשרת, אולי בעיית תקשורת נסה מאוחר יותר בבקשה")
        }
    
    
    func alertLoginFail() {
        alertMsg(title:"כשלון כניסה למערכת",
                 msg: "נא למלא תעודת זהות וסיסמא")
    }
    func LoginNotApproved() {
        alertMsg(title:"כשלון כניסה למערכת",
                 msg: " ההרשמה ממתינה לאישור מנהל")
        
    }
    func loginWrongPassword(){
        alertMsg(
            title: "סיסמא שגויה",
            msg: "נא למלא תעודת זהות וסיסמא")
    }
    
    func Login(id:String,token:String) {
        
        let parameters: Parameters = [
            "idNumber" : id,
            "token" : token
        ]
        
        let URL_LOGIN = "https://zeevtesthu.mybluemix.net/api/Users/Login"
        // self.myJsonPost()
        Alamofire.request(URL_LOGIN, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: [:])
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
                        // login sucssess
                        self.loginSucess(role: role)
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
    func loginSucess(role:String) {
        print("login success, role is: \(role)")
        //showEnterScreen(role)
    }
}

//
//  RegistrationViewController.swift
//  BOZ
//
//  Created by user134028 on 3/5/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class RegistrationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://zeevtesthu.mybluemix.net/Admin")!
        webView.load(URLRequest(url: url))
    }
    
    @IBOutlet weak var webView: WKWebView!
    
    func regDistributer(){
        let url = "https://zeevtesthu.mybluemix.net/api/Users/CreateDistributer"
        let parameters:Parameters = [
            "idNumber": "0234596620",
            "name" : "אגם",
            "famelyName" : "בן עמי",
            "token" : "246",
            "phoneNumber" : "0543333060",
            "address" : "הפרחים 24 קריית אתא",
            "latitude": 32.807221,
            "longitude": 35.104375,
            "vehicle" : "רכב"
        ]

        // self.myJsonPost()
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: [:])
            .validate(contentType: ["application/json"]).responseJSON { response in
                print("response: \(response)")
                switch response.result {
                case .success:
                    print("sucess response from server")
                    guard let responseJSON = response.result.value as? [String: Any],
                        let status = responseJSON["status"] as? String,
                        let statusMsg = responseJSON["statusMsg"] as? String
                        else {
                           // self.alertServerProblem()
                            return
                    }
                    if status == "OK" {
                        print("login success")
                        guard let role = responseJSON["role"] as? String
                            else {
                              //  self.alertServerProblem()
                                return
                        }
                        // login sucssess
                        //self.loginSucess(role: role)
                        
                    } else {
                        switch (statusMsg) {
                        case "Not approved":
                            print("Not approved")
                           // self.LoginNotApproved()
                        case "Wrong Password":
                            print("wrong password")
                            //self.loginWrongPassword()
                        default:
                           let x = 2 // stam
                        }
                       // self.alertLoginFail()
                    }
                    
                case .failure(let error):
                    print("error:\(error)")
                    //self.alertLoginFail()
                }
        }
    }
}

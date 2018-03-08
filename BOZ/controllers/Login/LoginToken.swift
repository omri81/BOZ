//
//  File.swift
//  BOZ
//
//  Created by user134028 on 3/8/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Foundation
import Alamofire

extension LoginVC {
    func LoginToken(_ privateToken:String) {
        let parameters: Parameters = [
            "token" : privateToken
        ]
        let URL_LOGIN = "https://zeevtesthu.mybluemix.net/api/Users/LoginToken"
        
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
                        // store private token
                        guard let privateToken = responseJSON["userGuid"] as? String
                            else {
                                self.alertServerProblem()
                                return
                        }
                        let prefs = UserDefaults.standard
                        prefs.set(privateToken, forKey: BaseViewController.PRIVATE_GUID)
                        //Enter to the app:
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


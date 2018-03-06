//
//  RegistrationViewController.swift
//  BOZ
//
//  Created by user134028 on 3/5/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import Alamofire


class RegistrationViewController: UIViewController {
    
    private let REG_DISTRIBUTER_URL = "https://zeevtesthu.mybluemix.net/api/Users/CreateDistributer"
    private let REG_STORE_MANAGER_URL = "https://zeevtesthu.mybluemix.net/api/Users/CreateStoreManger"
    
    @IBOutlet weak var VehicleSeg: UISegmentedControl!
    @IBOutlet weak var phoneTF: MyTextField!
    @IBAction func registerBtn() {
        if validateInputs() {
            register()
        }
    }
    @IBOutlet weak var nameTF: MyTextField!
    @IBOutlet weak var usernameTF: MyTextField!
    
    @IBOutlet weak var addressTF: MyTextField!
    @IBOutlet weak var segRole: UISegmentedControl!
    @IBOutlet weak var verifyPasswordTF: MyTextField!
    @IBOutlet weak var passwordTF: MyTextField!
    @IBOutlet weak var famelyNameTF: MyTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func validateInputs()->Bool {
        //check and alert
        return true
    }
    func register(){
        let parameters:Parameters = [
            "idNumber": usernameTF.text!,
            "name" : nameTF.text!,
            "famelyName" : famelyNameTF.text!,
            "token" : passwordTF.text!,
            "phoneNumber" : phoneTF.text!,
            "address" : addressTF.text!,
            "latitude": 32.807221,
            "longitude": 35.104375,
            "vehicle" : VehicleSeg.titleForSegment(at: VehicleSeg.selectedSegmentIndex)!
        ]
        let url = (segRole.selectedSegmentIndex == 0) ? REG_DISTRIBUTER_URL : REG_STORE_MANAGER_URL
       
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

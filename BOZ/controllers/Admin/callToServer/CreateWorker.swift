//
//  AdminToServer.swift
//  BOZ
//
//  Created by user134028 on 3/9/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Foundation
import Alamofire

    enum role {
        case Admin
        case Store
        case Delivery
        case Helpless
        case Donators
        case AllWorkers
    }
extension CrewEditCVVC {

    func createWorker(user:role,
        userNameInput idNumberInput:String,
        nameInput:String,
        lastnameInput:String,
        passwordInput:String,
        phoneNumberInput:String,
        addressInput:String,
        latitudeInput:Double,
        longitudeInput:Double ,
        vehicleInput :String,
        completion: @escaping (_ resutl:String)->()
        ) -> ()
    {
        let URL_SERVER = "https://zeevtesthu.mybluemix.net"
        var url = ""
        switch user {
        case role.Admin:
            url = URL_SERVER + "/api/Users/CreateAdminUser"
        case role.Store:
            url = URL_SERVER + "/api/Users/CreateStoreManger"
        case role.Delivery:
            url = URL_SERVER + "/api/Users/CreateDistributer"
        default: break
            print("you can create every one you want here.")
        }
        
        
        let parameters : Parameters = [
            "idNumber" : idNumberInput,
            "name" : nameInput,
            "famelyName" : lastnameInput,
            "token" : passwordInput,
            "phoneNumber" : phoneNumberInput,
            "address" : addressInput,
            "latitude" : latitudeInput,
            "longitude" : longitudeInput ,
            "vehicle" : vehicleInput
        ]
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: [:])
            .validate(contentType: ["application/json"]).responseJSON { response in
                print("response: \(response)")
                switch response.result {
                case .success:
                    guard let responseJSON = response.result.value as? [String: Any]
                    else
                    {
                        completion("Fail , no json")
                        return
                    }
                    guard let status = responseJSON["Status"] as? String,
                     let statusMsg = responseJSON["StatusMsg"] as? String,
                     let id = responseJSON["id"] as? String,
                     let rev = responseJSON["rev"] as? String
                    else
                    {
                        completion("Fail , no Status/StatusMsg/id/rev")
                        return
                    }
                    if (status == "OK") {
                        print("sucess response from server")
                        completion("OK")
                    } else {
                        print("error: \(statusMsg)")
                        completion("Fail")                    }
                case .failure(let error):
                    print("error:\(error)")
                    completion("Error: \(error)")
                }
                
        }
    }
    
}




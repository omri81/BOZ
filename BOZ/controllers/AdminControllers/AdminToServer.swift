//
//  AdminToServer.swift
//  BOZ
//
//  Created by user134028 on 3/9/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Foundation
import Alamofire

extension AddWorkerController {
    //Create User
    //Create Branch
    //Approve user
    static fileprivate let queue = DispatchQueue(label: "requests.queue", qos: .utility)
    static fileprivate let mainQueue = DispatchQueue.main
    
    func returnResult(returnValue:Bool)->Bool {
        return returnValue
    }
    
    func createDelivery(
        idNumberInput:String,
        nameInput:String,
        lastnameInput:String,
        passwordInput:String,
        phoneNumberInput:String,
        addressInput:String,
        latitudeInput:Double,
        longitudeInput:Double ,
        vehicleInput :String
        ) -> ()
    {
        let URL_SERVER = "https://zeevtesthu.mybluemix.net"
        var returnValue = false
        
        let url = URL_SERVER + "/api/Users/CreateDistributer"
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
                    guard let responseJSON = response.result.value as? [String: Any] else { return }
                    guard let status = responseJSON["Status"] as? String else {return}
                    guard let statusMsg = responseJSON["StatusMsg"] as? String else {return}
                    guard let id = responseJSON["id"] as? String else {return}
                    guard let rev = responseJSON["rev"] as? String else {return}
                    print("status:\(status),                     statusMsg: \(statusMsg),                     id:\(id) , rev:\(rev)")
                    if (status == "OK") {
                        print("sucess response from server")
                        // store in core something ??
                    } else {
                        print("error: \(statusMsg)")
                        // error what do you want to do ?
                    }
                case .failure(let error):
                    print("error:\(error)")
                    // error what do you want to do ?
                }
                
        }
    }

}



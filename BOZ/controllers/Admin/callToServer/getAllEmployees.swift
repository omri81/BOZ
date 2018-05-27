//
//  getAllEmployees.swift
//  BOZ
//
//  Created by user139205 on 5/26/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

struct Worker {
   var _id:String,
    _rev:String ,
    address:String,
    approved:Int,
    famelyName:String,
    idNumber:String,
    latitude:Double,
    longitude:Double,
    name:String,
    phoneNumber:String,
    role:String,
    token:String,
    vehicle:String
}

extension CrewEditCVVC {
    func getAllEmployees(user:role, completion: @escaping (_ sucess:String, _ result:[Worker])->()){
        var userArray:[Worker] = []
        let URL_SERVER = "https://zeevtesthu.mybluemix.net"
        var url = ""
        switch user {
            case role.Delivery :
                url = URL_SERVER + "/api/Users/GetAllDistributers"
            case  role.Admin:
                url = URL_SERVER + "/api/Users/GetAllAdminUsers"
            case  role.Store:
                url = URL_SERVER + "/api/Users/GetAllStoreManagers"
            default: break
        }
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success:
                print("sucess response from server")
               // print(response.result.value!)
                guard let responseJSON = response.result.value as? [String: Any],
                let rows = responseJSON["rows"] as? [[String:Any]]
                    else {
                        completion("Fail: Json problem",[])
                        return
                    }
                for r in rows {
                    guard let docs = r["doc"] as? [String:Any]
                        else {
                            completion("Fail: no such field doc", [])
                            return
                    }
                    guard let _id = docs["_id"] as? String,
                        let _rev =  docs["_rev"] as? String,
                        let address = docs["address"] as? String,
                        let approved = docs["approved"] as? Int,
                        let famelyName = docs["famelyName"] as? String,
                        let idNumber = docs["idNumber"] as? String,
                        let latitude = docs["latitude"] as? Double,
                        let longitude = docs["longitude"] as? Double,
                        let name = docs["name"] as? String,
                        let phoneNumber = docs["phoneNumber"] as? String,
                        let role = docs["role"] as? String,
                        let token = docs["token"] as? String,
                        let vehicle = docs["vehicle"] as? String
                    else {continue}
                    let worker = Worker(_id: _id, _rev: _rev, address: address, approved: approved, famelyName: famelyName, idNumber: idNumber, latitude: latitude, longitude: longitude, name: name, phoneNumber: phoneNumber, role: role, token: token, vehicle: vehicle)
                    userArray.append(worker)
                }
                completion("OK",userArray)
                break
            case .failure(let error):
                print("error:\(error)")
                completion("Fail",[])
                break
            }
        }
    }
}

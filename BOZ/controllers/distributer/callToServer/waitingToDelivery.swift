//
//  waitingToDelivery.swift
//  BOZ
//
//  Created by user134028 on 4/30/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Foundation
import Alamofire

extension DistributerVC {
    func getAllEmptyDestributer(bookmark:String)
    {
        let parameters : Parameters = [
            "bookmark": bookmark
        ]
        print(parameters)
        let url = "https://zeevtesthu.mybluemix.net/api/DeliverDonation/GetAllWaitingToDelevery"
        Alamofire.request(url, method: HTTPMethod.post , parameters: parameters ,
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
                            // self.alertServerProblem()
                            // make alert
                            return
                    }
                    if status == "OK" {
                        print("retrived success")
                        guard let docs = responseJSON["docs"] as? [[String:Any]]
                            else {return}
                        self.donations = []
                        for d in docs{
                            guard let idNumber = d["idNumber"] as? String ,
                                let _id = d["_id"] as? String,
                                let _rev = d["_rev"] as? String,
                                let name = d["name"] as? String ,
                                let famelyName = d["famelyName"] as? String ,
                                let phoneNumber = d["phoneNumber"] as? String ,
                                let address = d["address"] as? String ,
                                let latitude = d["latitude"] as? Double ,
                                let longitude = d["longitude"] as? Double
                                else{return}
                            guard let productList = d["productList"] as? [[String:Any]]
                                else{return}
                            // initiate Donatordetails
                            var package = Package(idNumber: idNumber,_id: _id, name: name, famelyName: famelyName, phoneNumber: phoneNumber, address: address, latitude: latitude, longitude: longitude, itemList: [], _rev:_rev)
                            for p in productList {
                                guard let title = p["title"] as? String,
                                let amount = p["amount"] as? Int
                                    else {return}
                                let item = Item(title: title, amount: amount)
                                package.itemList.append(item)
                            }
                            self.donations.append(package)
                        }  // outer loop of docs
                        print("---------------------")
                        print("self.donations retrived")
                        self.collectionView.reloadData()
                    } else {
                        // status != "ok"
                        self.alertMsg(title: "בעיה בשרת", msg: "סליחה, קרתה שגיאה, נא לנסות שנית בבקשה.")
                    }
                    
                case .failure(let error):
                    self.alertMsg(title: "בעיה בשרת", msg: "סליחה, קרתה שגיאה, נא לנסות שנית בבקשה.")
                }
        }
    }
}

//
//  DistributerViewController.swift
//  BOZ
//
//  Created by user134028 on 3/6/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import Alamofire

class DistributerViewController: UIViewController {

    var donations:[DonatorDetails] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllEmptyDestributer(bookmark: "")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
                        for d in docs{
                            guard let idNumber = d["idNumber"] as? String ,
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
                            for p in productList {
                                // do some..
                            }
                            let donation = DonatorDetails(idNumber: idNumber, name: name, famelyName: famelyName, phoneNumber: phoneNumber, address: address, latitude: latitude, longitude: longitude, productList: productList as! [DistributerViewController.DonatorDetails.Item])
                            // chanfe donations to be: [DonatorDetails]
                            //append the struct to donations
                            self.donations.append(donation)
                        }
                        
                        
                    } else {
                        
                    }
                    
                case .failure(let error):
                    print("error:\(error)")
                }
        }
    }

}

extension DistributerViewController {
    public struct DonatorDetails {
        let idNumber:String
        let name:String
        let famelyName:String
        let phoneNumber:String
        let address:String
        let latitude:Double
        let longitude:Double
        let productList:[Item]
        init (
            idNumber:String,
            name:String,
            famelyName:String,
            phoneNumber:String,
            address:String,
            latitude:Double,
            longitude:Double,
            productList:[Item])
        {
            self.idNumber = idNumber
            self.name = name
            self.famelyName = famelyName
            self.phoneNumber = phoneNumber
            self.address = address
            self.latitude = latitude
            self.longitude = longitude
            self.productList = productList
        }
        struct Item {
            let title:String
            let amount:Int
            init (title:String,amount:Int)
            {
                self.title = title
                self.amount = amount
            }
        }
    }

}

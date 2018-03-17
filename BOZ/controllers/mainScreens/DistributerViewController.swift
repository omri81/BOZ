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

    var donations:[Package] = []
    
    @IBAction func logout() {
        let next = storyboard!.instantiateViewController(withIdentifier: "toMainVC") as! MainVC
        show(next, sender: self)
    }
    
    
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
                            var package = Package(idNumber: idNumber, name: name, famelyName: famelyName, phoneNumber: phoneNumber, address: address, latitude: latitude, longitude: longitude, itemList: [])
                            for _ in productList {
                                let title = ""
                                let amount = 2
                                let item = Item(title: title, amount: amount)
                                package.itemList.append(item)
                            }
                            self.donations.append(package)
                        }  // outer loop of docs
                        print("---------------------")
                        print(self.donations)
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

extension DistributerViewController {
    public struct Package {
        let idNumber:String
        let name:String
        let famelyName:String
        let phoneNumber:String
        let address:String
        let latitude:Double
        let longitude:Double
        var itemList:[Item]
        init (
            idNumber:String,
            name:String,
            famelyName:String,
            phoneNumber:String,
            address:String,
            latitude:Double,
            longitude:Double,
            itemList:[Item])
        {
            self.idNumber = idNumber
            self.name = name
            self.famelyName = famelyName
            self.phoneNumber = phoneNumber
            self.address = address
            self.latitude = latitude
            self.longitude = longitude
            self.itemList = itemList
        }
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

extension DistributerViewController {
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
}

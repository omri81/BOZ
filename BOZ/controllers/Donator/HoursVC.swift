//
//  HoursVC.swift
//  BOZ
//
//  Created by user134028 on 3/12/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import Alamofire

class HoursVC: UIViewController {
    let productList:[String:Any] = [:]
    
    @IBAction func doneClick() {
        //users default
        let prefs = UserDefaults.standard
        let lastName = prefs.string(forKey: DONATOR_LAST_NAME)
        let firstName = prefs.string(forKey: DONATOR_FIRST_NAME)
        let idNumber = prefs.string(forKey: DONATOR_IDNUMBER)
        let phone = prefs.string(forKey: DONATOR_PHONE_NUMBER)
        let address = prefs.string(forKey: DONATOR_ADDRESS)
        let longtitude = prefs.double(forKey: DONATOR_LONGTITUDE)
        let latitude = prefs.double(forKey: DONATOR_LATITUDE)
        //selected product
        //take it from barcode, this is just a sample
        var selectedProducts:[[String:Any]] = [
            [  "qr": "5099864006711",
               "manufacter": "saimilak",
               "title": "סימילאק אדבנס פלוס- שלב 2",
               "description": "תרכובת המזון סימילאק אדבנס פלוס, שלב 2, מתאימה לצרכיהם של תינוקות מגיל חצי שנה עד שנה. ",
               "age": "6-12 חודשים",
               "spaciel": "no glotan",
               "cosher": "בהשגחת OU ובאישור הרבנות הראשית לישראל",
               "amount": 2
            ],
            [  "qr": "5099864006711",
               "manufacter": "saimilak",
               "title": "סימילאק אדבנס פלוס- שלב 2",
               "description": "תרכובת המזון סימילאק אדבנס פלוס, שלב 2, מתאימה לצרכיהם של תינוקות מגיל חצי שנה עד שנה. ",
               "age": "6-12 חודשים",
               "spaciel": "no glotan",
               "cosher": "בהשגחת OU ובאישור הרבנות הראשית לישראל",
               "amount": 1
            ]
            ]
        
        
        sendDonation(idNumber: idNumber!, name: firstName!, famelyName: lastName!, phoneNumber: phone!, address: address!, latitude: latitude, longitude: longtitude, productList: selectedProducts)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func sendDonation(
        idNumber:String,
        name:String,
        famelyName:String,
        phoneNumber:String,
        address:String,
        latitude:Double,
        longitude:Double,
        productList:[[String:Any]]
        )
    {
        let parameters : Parameters = [
            "idNumber": idNumber ,
            "name": name ,
            "famelyName": famelyName,
            "token": "****",
            "phoneNumber": phoneNumber,
            "address": address,
            "latitude": latitude,
            "longitude": longitude,
            "productList": productList
        ]
        print(parameters)
        let url = "https://zeevtesthu.mybluemix.net/api/DeliverDonation/PostDonation"
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
                        print("login success")
                        // self.alertSucess()
                        // make alert
                                                
                    } else {
                        
                    }
                    
                case .failure(let error):
                    print("error:\(error)")
                }
        }
    }
}

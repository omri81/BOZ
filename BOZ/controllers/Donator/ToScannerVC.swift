//
//  ToScannerVC.swift
//  BOZ
//
//  Created by MacMini on 27/05/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import Alamofire

class ToScannerVC: UIViewController,ScannerDelegate, UICollectionViewDataSource   {
    var itemDescription:[String] = []
    var itemScanned:[String] = []
    @IBOutlet var collectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemDescription.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DonationCellController
        
        cell.desc.text = itemDescription[indexPath.item]
        
        return cell
    }
    
    func addItemToArray(item: String) {
        if(!itemDescription.contains(item)){
            itemDescription.append(item)
            print(itemDescription)
            collectionView.reloadData()
        }else{
            //add 1 to counter
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func toScan(_ sender: Any) {
        let next = storyboard!.instantiateViewController(withIdentifier: "barcodeScanner") as! BarCodeScannerController
        next.delegate = self
        navigationController?.pushViewController(next, animated: true)
    }
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
        //take it from barcode array , this is just a sample
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
                        print("server success")
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

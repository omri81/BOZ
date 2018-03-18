//
//  TakeVC.swift
//  BOZ
//
//  Created by user134028 on 3/12/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import  Alamofire

class TakeVC: UIViewController, UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    private var longtitude:Double!
    private var latitude:Double!    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    
    var itemDescription:[String] = []
    var itemScanned:[String] = []
    
    @IBAction func toScan(_ sender: Any) {
        let next = storyboard!.instantiateViewController(withIdentifier: "barcodeScanner")
        navigationController?.pushViewController(next, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        readFromDefault()
        
        
    }

    func alertWrongInput(){
        
        let alert = UIAlertController(title: "נתונים שגויים", message: "נא עדכן נתונים", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(title: "בסדר", //with title "Ok"
                style: .default, //with default style
                handler: nil)) //without custom handler
        //show alert dialog to user
        self.present(alert, animated: true, completion: nil )
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            switch identifier {
            case "toHours":
                if !validateInput() {
                    alertWrongInput()
                    return false
                } else {
                    storeDefault()
                    return true
                }
            default:
                return true
            }
    }
    func readFromDefault() {
        let prefs = UserDefaults.standard
        
        if let name = prefs.string(forKey:DONATOR_FIRST_NAME)
        {self.firstName.text = name}
        
        if let famely = prefs.string(forKey:DONATOR_LAST_NAME){self.lastName.text = famely}
        
        if let phone = prefs.string(forKey:DONATOR_PHONE_NUMBER) {self.phoneNumber.text = phone}
        
        if let adrs = prefs.string(forKey:DONATOR_ADDRESS)  {self.addressTF.text = adrs}
        
        self.longtitude = prefs.double(forKey:DONATOR_LONGTITUDE)
        self.latitude = prefs.double(forKey:DONATOR_LONGTITUDE)
        
    }
    func storeDefault(){
        let prefs = UserDefaults.standard
        let textInput = getTexts()
        prefs.set(textInput.firstName, forKey: DONATOR_FIRST_NAME)
        prefs.set(textInput.lastName, forKey: DONATOR_LAST_NAME)
        prefs.set(textInput.phone, forKey: DONATOR_PHONE_NUMBER)
        prefs.set(textInput.address, forKey: DONATOR_ADDRESS)
        prefs.set(self.longtitude, forKey: DONATOR_LONGTITUDE)
        prefs.set(self.latitude, forKey: DONATOR_LATITUDE)
        prefs.set(textInput.phone, forKey: DONATOR_IDNUMBER)
        prefs.set(DONATOR_TOKEN, forKey: DONATOR_TOKEN)
    }
    
    
    func validateInput()->Bool{
        let text = getTexts()
        let valid =
            (text.firstName != nil) &&
                (text.firstName?.isEmpty == false) &&
            (text.lastName != nil) &&
            (text.lastName?.isEmpty == false) &&
            (text.phone != nil) &&
            (text.phone?.isEmpty == false) &&
            (text.phone!.count >= 10) &&
            (text.address != nil) &&
            (text.address?.isEmpty == false)
        return valid
    }
    private func getTexts() -> (firstName: String?, lastName:String?,phone:String?, address:String?) {
        return (firstName: firstName.text, lastName: lastName.text, phone : phoneNumber.text, address: self.addressTF.text)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addItemToArray(item: String){
        itemDescription.append(item)
        print(itemDescription)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemDescription.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DonationCellController
        
        cell.desc.text = itemDescription[indexPath.item]
        
        return cell
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

//
//  TasksVC.swift
//  BOZ
//
//  Created by user134028 on 4/29/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import Alamofire

class MyTasksVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

     var donations:[Package] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func logout(_ sender: Any) {
        let mainVC = storyboard!.instantiateViewController(withIdentifier: "toMainVC") as! MainVC
        UIApplication.shared.keyWindow?.rootViewController = mainVC
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return donations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyTasksCell
        
        cell.addressLB.text = donations[indexPath.item].address
        cell.nameLB.text = donations[indexPath.item].famelyName
        
        return cell
    }
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.9921568627, blue: 1, alpha: 0.1793931935)
        
        getMyTasks(bookmark: "")
        let prefs = UserDefaults.standard
        let myId = prefs.string(forKey: DONATOR_IDNUMBER)
        // zohar: call to server getMy tasks(ID)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMyTasks(bookmark:String)
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
                                let _id = d["_id"] as? String,
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
                            var package = Package(idNumber: idNumber,_id : _id, name: name, famelyName: famelyName, phoneNumber: phoneNumber, address: address, latitude: latitude, longitude: longitude, itemList: [])
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

extension MyTasksVC {
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

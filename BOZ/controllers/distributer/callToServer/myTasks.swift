
import Foundation
import Alamofire

extension DistributerVC {
    func getMyTasks(bookmark:String , delivererId:String)
    {
        let parameters : Parameters = [
            "delivererId" : delivererId,
            "bookmark": bookmark
        ]
        print(parameters)
        let url = "https://zeevtesthu.mybluemix.net/api/DeliverDonation/GetAllDonationsForSpecificDeliverer"
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
                        self.myTasks = []
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
                            
                            var package = Package(idNumber: idNumber, _id: _id, name: name, famelyName: famelyName, phoneNumber: phoneNumber, address: address, latitude: latitude, longitude: longitude, itemList: [])
                            for _ in productList {
                                let title = ""
                                let amount = 2
                                let item = Item(title: title, amount: amount)
                                package.itemList.append(item)
                            }
                            self.myTasks.append(package)
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


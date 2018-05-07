
import Foundation
import Alamofire

extension DistributerVC {
    func updateTasks(delivererId:String, donations:[String])
    {
        let parameters : Parameters = [
            "delivererId" : delivererId,
            "donations": donations
        ]
        print(parameters)
        let url = "https://zeevtesthu.mybluemix.net/api/DeliverDonation/BulkUpdate"
        Alamofire.request(url, method: HTTPMethod.put , parameters: parameters ,
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
                            self.alertMsg(title: "בעיה בשרת", msg: "סליחה, קרתה שגיאה, נא לנסות שנית בבקשה.")
                            return
                    }
                    if status == "OK" {
                        // reload tasks to ui
                        if self.personalView {
                            self.getMyTasks(bookmark: "", delivererId: self.myId)
                        } else {
                            self.getAllEmptyDestributer(bookmark: "") 
                        }
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



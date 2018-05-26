
import Foundation
import Alamofire

extension DistributerVC {
    func updateTasks(delivererId:String, donations:[String], completion: @escaping (_ result: String) -> Void )
    {
        let free:Bool = personalView //if it personal, free = tru so the request from server is to free the selected items
        let parameters : Parameters = [
            "free" : free as Bool,
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
                            completion("Fail")
                            return
                    }
                    if status == "OK" {
                        // clear selected items and reload tasks to ui
                        completion("OK")
                    } else {
                        // status != "ok"
                        self.alertMsg(title: "בעיה בשרת", msg: "סליחה, קרתה שגיאה, נא לנסות שנית בבקשה.")
                        completion("Fail")
                    }
                    
                case .failure(let error):
                    self.alertMsg(title: "בעיה בשרת", msg: "סליחה, קרתה שגיאה, נא לנסות שנית בבקשה.")
                    completion("Fail")
                }
        }
    }

        
}



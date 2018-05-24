
import Foundation
import Alamofire

extension PakageDetailsVC {
    func deleteTask(_id:String, _rev:String)
    {
        let parameters : Parameters = [
            "_id" : _id,
            "_rev" : _rev
        ]
        print(parameters)
        let url = "https://zeevtesthu.mybluemix.net/api/DeliverDonation/Delete"
        Alamofire.request(url, method: HTTPMethod.delete , parameters: parameters ,
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
                        // navigation pop to route
                        self.delegate?.collectionViewReload()
                        self.navigationController?.popToRootViewController(animated: true)
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

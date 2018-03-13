//
//  Data1.swift
//  BOZ
//
//  Created by hackeru on 13/03/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Alamofire

class Data1 {
    static fileprivate let queue = DispatchQueue(label: "requests.queue", qos: .utility)
    static fileprivate let mainQueue = DispatchQueue.main
    
    fileprivate class func make(request: DataRequest, closure: @escaping (_ json: Doc.Product?, _ error: Error?)->()) {
        request.responseJSON(queue: Data1.queue) { response in
            
            // print(response.request ?? "nil")  // original URL request
            // print(response.response ?? "nil") // HTTP URL response
            // print(response.data ?? "nil")     // server data
            //print(response.result ?? "nil")   // result of response serialization
            
            switch response.result {
                case .failure(let error):
                    Data1.mainQueue.async {
                        closure(nil, error)
                    }
                
                case .success(let data):
                    print("sucess response from server")
                    guard let responseJSON = response.result.value as? [String: Any],
                        let status = responseJSON["status"] as? String,
                        let statusMsg = responseJSON["statusMsg"] as? String
                        else {return}
                    if status == "OK" {
                        print("retrive success")
                        guard let _id = responseJSON["id"] as? String,
                            let _rev = responseJSON["rev"] as? String,
                            let cosher = responseJSON["cosher"] as? String,
                            let amount = responseJSON["amount"] as? Double,
                            let description = responseJSON["description"] as? String,
                            let manufacter = responseJSON["manufacter"] as? String,
                            let qr = responseJSON["qr"] as? String,
                            let spaciel = responseJSON["spaciel"] as? String,
                            let stage = responseJSON["stage"] as? Int,
                            let title = responseJSON["title"] as? String,
                            let age = responseJSON["age"] as? String
                        else {return}
                        Data1.mainQueue.async {
                            let barcodeResult = Doc.Product(
                                _id: _id,
                                _rev: _rev,
                                cosher: cosher,
                                amount: amount,
                                description: description,
                                manufacter: manufacter,
                                qr: qr,
                                spaciel: spaciel,
                                stage: stage,
                                title: title,
                                age: age)
                            closure((barcodeResult) , nil)
                        }
                        
                        } // later also a bookmark
                } // switch
            } // redponse
    }; // function closure
    
class func searchRequest(term: String, closure: @escaping (_ json: Doc.Product?, _ error: Error?)->()) {
        let url = "https://zeevtesthu.mybluemix.net/api/Milk/GetQR/" + term
        let request = Alamofire.request(url)
        Data1.make(request: request) { json, error in
            closure(json, error)
        }
    }
}

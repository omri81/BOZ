//
//  BarCodeVC.swift
//  BOZ
//
//  Created by user134028 on 3/12/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import Alamofire


class BarCodeVC: UIViewController {
    var bookMark = ""
    
    @IBAction func barcode(_ sender: Any, forEvent event: UIEvent) {
        getProducts()
        //getBarcode()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProducts() {
        struct Doc {
            let docs : [Product]
        }
        struct Product {
            var _id:String
            var _rev:String
            var cosher:String
            var amount:Double
            var description:String
            var manufacter:String
            var qr:String
            var spaciel:String
            var stage:Int
            var title:String
            var age:String
        }
        
        let parameters: Parameters = [
            "bookMark" : bookMark
        ]
        Alamofire.request(URL_PRODUCTS, method: HTTPMethod.post , parameters: parameters,
                          encoding: JSONEncoding.default, headers: [:])
            .validate(contentType: ["application/json"]).responseJSON { response in
                switch response.result {
                case .success:
                    print("sucess response from server")
                    guard let responseJSON = response.result.value as? [String: Any],
                        let status = responseJSON["status"] as? String,
                        let statusMsg = responseJSON["statusMsg"] as? String
                        else {return}
                    if status == "OK" {
                        print("retrive success")
                        guard let docs = responseJSON["docs"] as? [Dictionary<String,AnyObject>]                            else { return }
                            for data in docs
                            {
                                print (data["title"] as! String)

                            }
                       
                        
                      //  for doc in docs {
                      //      print(doc)
                      //  }
                        
                        }
                case .failure(let error):
                        print("error:\(error)")
                }
        }
    }
}

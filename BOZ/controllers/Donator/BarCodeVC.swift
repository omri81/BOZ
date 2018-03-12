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
        getBarcode()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getBarcode() {
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
                        guard let docs = responseJSON["docs"] as? [[String: Any]]
                            else { return }
                        print(docs)
                        }
                case .failure(let error):
                        print("error:\(error)")
                }
        }
    }
}

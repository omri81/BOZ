//
//  BarCodeVC.swift
//  BOZ
//
//  Created by user134028 on 3/12/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import Alamofire
import WebKit


class BarCodeVC: UIViewController , WKUIDelegate
{
    var webView: WKWebView!
    
    var bookMark = ""
    var products = [Dictionary<String,AnyObject>]()
    var barcodeResult = Doc.Product(
        _id: "",
        _rev: "",
        cosher: "",
        amount: 0,
        description: "",
        manufacter: "",
        qr: "",
        spaciel: "",
        stage: 0,
        title: "",
        age: "")
    
    @IBAction func barcode(_ sender: Any, forEvent event: UIEvent) {
        
        let b = getBarcode(qr: "5099864006704")
        print(b)
        
        DispatchQueue.global(qos: .background).async(execute: {
            //"do in background"
             //var k = getProducts()
            //when need to sync - UI main thread
            DispatchQueue.main.async {
                //"post execute"
                for m in self.products {
                    print (m)
                }
            }
        })
        
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: "https://zeevtesthu.mybluemix.net/api/Milk/GetQR/5099864006704")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getBarcode(qr:String) {
        
        Alamofire.request(URL_BARCODE+"/"+qr).response { response in // method defaults to `.get`
            print(response)
            }
        }

    
    
   public func getProducts() {
        
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
                        guard let docs = responseJSON["docs"] as? [Dictionary<String,AnyObject>]
                            else { return }
                            for data in docs
                            {
                                self.products.append(data)
                                let _id = data["_id"] as! String?
                                let _rev = data["_rev"] as! String?
                                let cosher = data["cosher"] as! String?
                                let amount = data["amount"] as! Double?
                                let description = data["description"] as! String?
                                let manufacter = data["manufacter"] as! String?
                                let qr = data["qr"] as! String?
                                let spaciel = data["spaciel"] as! String?
                                let stage = data["stage"] as! Int?
                                let title = data["title"] as! String?
                                let age = data["age"] as! String?
                                let p = Doc.Product(_id: _id, _rev: _rev, cosher: cosher, amount: amount, description: description, manufacter: manufacter, qr: qr, spaciel: spaciel, stage: stage, title: title, age: age)
                               // products.append(p)
                            } // later also a bookmark
                        
                        }
                case .failure(let error):
                        print("error:\(error)")
                }
        }
    }
    
}

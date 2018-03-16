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
    var bookMark = ""
  
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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

}

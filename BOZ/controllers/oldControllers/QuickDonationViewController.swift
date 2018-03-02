//
//  QuickDonationViewController.swift
//  BOZ
//
//  Created by user134028 on 2/22/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class QuickDonationViewController: BaseViewController {
    
    @IBAction func callMony() {
        let phoneNumber = "0522499060"
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
}

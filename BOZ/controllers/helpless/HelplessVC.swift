//
//  AskDonationApplicationController.swift
//  BOZ
//
//  Created by MacMini on 14/03/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class HelplessVC: UIViewController {

    @IBAction func logout() {
        let mainVC = storyboard!.instantiateViewController(withIdentifier: "toMainVC") as! MainVC
        UIApplication.shared.keyWindow?.rootViewController = mainVC
    }
    
    override func viewDidLoad() {
        
    }

}

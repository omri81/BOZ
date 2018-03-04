//
//  LoginVC.swift
//  BOZ
//
//  Created by Bar Arbiv on 02/03/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    private static let TO_REGISTER_VC = "toRegisterVC"
    private static let TO_ADMIN_VC = "toAdminVC"
    private static let TO_DELIVERY_VC = "toDeliveryVC"
    private static let TO_STORAGE_VC = "toStorageVC"
    
    private let LOGIN_BTN = "loginBtn"
    private let BACK_BTN = "backBtn"
    private let REGISTER_BTN = "registerBtn"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onClicked(sender: UIButton){
        switch sender.restorationIdentifier{
        case LOGIN_BTN?:
                break
        case BACK_BTN?:
                break
        case REGISTER_BTN?:
                break
            default:
                break
        }
    }
    


}

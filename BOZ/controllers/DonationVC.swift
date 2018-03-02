//
//  DonationVC.swift
//  BOZ
//
//  Created by Bar Arbiv on 27/02/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class DonationVC: UIViewController {

    private let MONEY_BTN = 1
    private let COME_TAKE_BTN = 2
    private let LEFT_AT_BTN = 3
    private let IM_COMING_BTN = 4
    private let WHAT_TO_DONATE_BTN = 5
    private let BACK_BTN = 6
    
    private let OFFICE_NUMBER = "0507888094"
    
    
    private let TO_COME_TAKE_VC = "toComeTakeVC"
    private let TO_LEFT_AT_VC = "toLeftAtVC"
    private let TO_IM_COMING_VC = "toImComingVC"
    private let TO_PRODUCT_VC = "toProductVC"
    
    @IBOutlet weak var logoImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        logoImg.loadGif(name: "logo")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func onBtnClicked(sender: UIButton){
        switch(sender.tag){
            case MONEY_BTN:
                Methods.makePhoneCallToOffice()
            case COME_TAKE_BTN:
                performSegue(withIdentifier: TO_COME_TAKE_VC, sender: self)
            case LEFT_AT_BTN:
                performSegue(withIdentifier: TO_IM_COMING_VC, sender: self)
            case IM_COMING_BTN:
                performSegue(withIdentifier: TO_IM_COMING_VC, sender: self)
            case WHAT_TO_DONATE_BTN:
                performSegue(withIdentifier: TO_PRODUCT_VC, sender: self)
            case BACK_BTN:
                self.navigationController?.dismiss(animated: true, completion: nil)
            default:
                break
        }
    }
}



















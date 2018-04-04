//
//  AdminViewController.swift
//  BOZ
//
//  Created by user134028 on 3/6/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class AdminVC: UIViewController {

    
    @IBAction func logout() {
        let mainVC = storyboard!.instantiateViewController(withIdentifier: "toMainVC") as! MainVC
        UIApplication.shared.keyWindow?.rootViewController = mainVC
    }
    private let CREW_EDIT_BTN = "crewEditBtn"
    private let BRANCH_EDIT_BTN = "branchEditBtn"
    private let PRODUCT_EDIT_BTN = "productEditBtn"
    private let CONFIRM_REQUESTS_BTN = "confirmRequestsBtn"
    
    private let TO_CREW_EDIT_VC = "toCrewEditVC"
    private let TO_BRANCH_EDIT_BTN = "toBranchEditVC"
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onclick(sender: UIButton){
        switch(sender.restorationIdentifier){
            case CREW_EDIT_BTN?:
                performSegue(withIdentifier: TO_CREW_EDIT_VC, sender: self  )
            case BRANCH_EDIT_BTN?:
                performSegue(withIdentifier: TO_BRANCH_EDIT_BTN, sender: self)
            case PRODUCT_EDIT_BTN?:
                break
            default:
                break
            
            
            
        }
    }

}

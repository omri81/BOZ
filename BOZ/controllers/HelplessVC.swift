//
//  HelplessVC.swift
//  BOZ
//
//  Created by user134028 on 3/17/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class HelplessVC: UIViewController {

    @IBAction func helpRequest() {
        alertMsg()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func alertMsg() {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  AddWorkerController.swift
//  BOZ
//
//  Created by MacMini on 07/03/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class AddWorkerController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //example:
        /*
        createDelivery(idNumberInput: <#T##String#>, nameInput: <#T##String#>, lastnameInput: <#T##String#>, passwordInput: <#T##String#>, phoneNumberInput: <#T##String#>, addressInput: <#T##String#>, latitudeInput: <#T##Double#>, longitudeInput: <#T##Double#>, vehicleInput: <#T##String#>)
         */
        //create Admin:
        var success = createWorker(user: .Admin, userNameInput: "", nameInput: "Admin22", lastnameInput: "<#T##String#>", passwordInput: "<#T##String#>", phoneNumberInput: "<#T##String#>", addressInput: "<#T##String#>", latitudeInput: 23.65, longitudeInput: 23.12, vehicleInput: "<#T##String#>")
        print ("create user: \(success)")
        //create Store:
        success = createWorker(user: .Store, userNameInput: "Store222", nameInput: "<#T##String#>", lastnameInput: "<#T##String#>", passwordInput: "<#T##String#>", phoneNumberInput: "<#T##String#>", addressInput: "<#T##String#>", latitudeInput: 23.65, longitudeInput: 23.12, vehicleInput: "<#T##String#>")
        print ("create user: \(success)")
        //create Delivery:
        success = createWorker(user: .Delivery, userNameInput: "Delivery2222", nameInput: "<#T##String#>", lastnameInput: "<#T##String#>", passwordInput: "<#T##String#>", phoneNumberInput: "<#T##String#>", addressInput: "<#T##String#>", latitudeInput: 23.65, longitudeInput: 23.12, vehicleInput: "<#T##String#>")
        print ("create user: \(success)")
        print ("create user: \(success)")
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

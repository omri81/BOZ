//
//  TakeVC.swift
//  BOZ
//
//  Created by user134028 on 3/12/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class TakeVC: UIViewController {

    private var longtitude:Double!
    private var latitude:Double!    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readFromDefault()
    }

    func alertWrongInput(){
        
        let alert = UIAlertController(title: "נתונים שגויים", message: "נא עדכן נתונים", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(title: "בסדר", //with title "Ok"
                style: .default, //with default style
                handler: nil)) //without custom handler
        //show alert dialog to user
        self.present(alert, animated: true, completion: nil )
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            switch identifier {
            case "toHours":
                if !validateInput() {
                    alertWrongInput()
                    return false
                } else {
                    storeDefault()
                    return true
                }
            default:
                return true
            }
    }
    func readFromDefault() {
        let prefs = UserDefaults.standard
        
        if let name = prefs.string(forKey:DONATOR_FIRST_NAME)
        {self.firstName.text = name}
        
        if let famely = prefs.string(forKey:DONATOR_LAST_NAME){self.lastName.text = famely}
        
        if let phone = prefs.string(forKey:DONATOR_PHONE_NUMBER) {self.phoneNumber.text = phone}
        
        if let adrs = prefs.string(forKey:DONATOR_ADDRESS)  {self.addressTF.text = adrs}
        
        self.longtitude = prefs.double(forKey:DONATOR_LONGTITUDE)
        self.latitude = prefs.double(forKey:DONATOR_LONGTITUDE)
        
    }
    func storeDefault(){
        let prefs = UserDefaults.standard
        let textInput = getTexts()
        prefs.set(textInput.firstName, forKey: DONATOR_FIRST_NAME)
        prefs.set(textInput.lastName, forKey: DONATOR_LAST_NAME)
        prefs.set(textInput.phone, forKey: DONATOR_PHONE_NUMBER)
        prefs.set(textInput.address, forKey: DONATOR_ADDRESS)
        prefs.set(self.longtitude, forKey: DONATOR_LONGTITUDE)
        prefs.set(self.latitude, forKey: DONATOR_LATITUDE)
        prefs.set(textInput.phone, forKey: DONATOR_IDNUMBER)
        prefs.set(DONATOR_TOKEN, forKey: DONATOR_TOKEN)
    }
    
    
    func validateInput()->Bool{
        let text = getTexts()
        let valid =
            (text.firstName != nil) &&
                (text.firstName?.isEmpty == false) &&
            (text.lastName != nil) &&
            (text.lastName?.isEmpty == false) &&
            (text.phone != nil) &&
            (text.phone?.isEmpty == false) &&
            (text.phone!.count >= 10) &&
            (text.address != nil) &&
            (text.address?.isEmpty == false)
        return valid
    }
    private func getTexts() -> (firstName: String?, lastName:String?,phone:String?, address:String?) {
        return (firstName: firstName.text, lastName: lastName.text, phone : phoneNumber.text, address: self.addressTF.text)
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

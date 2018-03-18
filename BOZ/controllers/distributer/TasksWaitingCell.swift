
import UIKit

class TasksWaitingCell: UICollectionViewCell {
    
    let WAZE_BTN = "wazeBtn2"
    let PHONE_BTN = "phoneBtn2"
    let ASIGN_BTN = "asignBtn2"
    var lat: Double!
    var lon: Double!
    var phoneNumber: String!
    
    @IBOutlet weak var hoursLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBAction func onClick(_ sender: UIButton) {
        if sender.restorationIdentifier == ASIGN_BTN {// todo
            print("asign to me")
        }
        if sender.restorationIdentifier == WAZE_BTN{
            Methods.tryNavigateWithWaze(lat: lat, lon: lon)
        }else{
            Methods.makePhoneCall(toNumber: phoneNumber)
        }
    }
    
    public func setCellData(package: Package){
       // self.hoursLbl = package.token
        self.addressLbl.text? = package.address
        self.lat = package.latitude
        self.lon = package.longitude
        self.phoneNumber = package.phoneNumber
    }
    
    
}


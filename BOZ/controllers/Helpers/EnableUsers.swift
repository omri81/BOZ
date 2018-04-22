//
//  EnableUsers.swift
//  BOZ
//
//  Created by user134028 on 3/9/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

/*GetNotApprovedHelpless(pagination req)
 GetNotApprovedDonators(pagination req)
 GetNotApprovedVolunteers(pagination req*/
import Foundation
import Alamofire

extension AddWorkerController {
    
    /*UpdateAdminUser([FromBody] AdminModel.item updaterUser)
     UpdateStoreManagerUser([FromBody] StoreManagerModel.item updaterUser)
     UpdateHelplessUser([FromBody] DistributerModel.item updaterUser)
     UpdateHelplessUser([FromBody] HelplessModel.item updaterUser)
     UpdateDonatorUser([FromBody] DonatorsModel.item updaterUser)*/
    
    func updateUser(user:role,lastBookmark:String) -> ()
    {
        let URL_SERVER = "https://zeevtesthu.mybluemix.net"
        var url = ""
        switch user {
        case role.Helpless :
            url = URL_SERVER + "/api/Users/GetNotApprovedHelpless"
        case  role.Donators:
            url = URL_SERVER + "/api/Users/GetNotApprovedDonators"
        case  role.AllWorkers:
            url = URL_SERVER + "/api/Users/GetNotApprovedVolunteers"
        default: break
        print("you can create every one you want here.")
        }
        
        let parameters : Parameters = [
            "bookmark" : lastBookmark
        ]
        
        Alamofire.request(url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: [:])
            .validate(contentType: ["application/json"]).responseJSON { response in
                print("response: \(response)")
                switch response.result {
                case .success:
                    guard let responseJSON = response.result.value as? [String: Any] else { return }
                    guard let status = responseJSON["Status"] as? String else {return}
                    guard let statusMsg = responseJSON["StatusMsg"] as? String else {return}
                    guard let id = responseJSON["id"] as? String else {return}
                    guard let rev = responseJSON["rev"] as? String else {return}
                    print("status:\(status),                     statusMsg: \(statusMsg),                     id:\(id) , rev:\(rev)")
                    if (status == "OK") {
                        print("sucess response from server")
                        // store in core something ??
                    } else {
                        print("error: \(statusMsg)")
                        // error what do you want to do ?
                    }
                case .failure(let error):
                    print("error:\(error)")
                    // error what do you want to do ?
                }
                
        }
    }
    
}





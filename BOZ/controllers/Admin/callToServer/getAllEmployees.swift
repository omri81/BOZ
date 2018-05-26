//
//  getAllEmployees.swift
//  BOZ
//
//  Created by user139205 on 5/26/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension CrewEditCVVC {
    func getAllEmployees(user:role,completion:@escaping (_ result:String)->()){
        let URL_SERVER = "https://zeevtesthu.mybluemix.net"
        var url = ""
        switch user {
            case role.Delivery :
                url = URL_SERVER + "/api/Users/GetAllDistributers"
            case  role.Admin:
                url = URL_SERVER + "/api/Users/GetAllAdminUsers"
            case  role.Store:
                url = URL_SERVER + "/api/Users/GetAllStoreManagers"
            default: break
        }
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success:
                print("sucess response from server")
               // print(response.result.value!)
                guard let responseJSON = response.result.value as? [String: Any],
                let rows = responseJSON["rows"] as? [[String:Any]]
                    else {
                        completion("no such field rows")
                        return
                    }
                completion("rows: \(rows)")
                break
            case .failure(let error):
                print("error:\(error)")
                completion("Fail")
                break
            }
        }
    }
}

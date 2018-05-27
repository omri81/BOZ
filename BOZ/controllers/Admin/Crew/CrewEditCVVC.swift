//
//  CrewEditCVVC.swift
//  BOZ
//
//  Created by Bar Arbiv on 09/03/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "CrewCell"

class CrewEditCVVC: UICollectionViewController {
    
    var temp: [Crew] = []
    var crew: [Crew] = []
    var adminUsers :[Worker] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllEmployees(user: role.Admin){
            (result,users) in
            if result == "OK" {
                self.adminUsers = users
                print(self.adminUsers)
                self.collectionView?.reloadData()
            } else {
                //alert
                print(result)
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return adminUsers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CrewCell
        cell.setCell(crew: Crew(name: adminUsers[indexPath.row].name + " " + adminUsers[indexPath.row].famelyName , phone: adminUsers[indexPath.row].phoneNumber))
        return cell
    }


}

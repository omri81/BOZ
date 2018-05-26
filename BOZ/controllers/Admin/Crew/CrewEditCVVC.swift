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

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllEmployees(user: role.Admin){
            (result) in
            print(result)
        }        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return temp.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        
    
        return cell
    }


}

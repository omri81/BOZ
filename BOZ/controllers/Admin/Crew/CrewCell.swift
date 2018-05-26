//
//  CrewCell.swift
//  BOZ
//
//  Created by Bar Arbiv on 09/03/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class CrewCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    var crew: Crew!
    
    
    
    @IBAction func deleteBtnClicked(_ sender: Any) {
        crew.deleted = true
        
    }
    
    func setCell(crew: Crew){
        self.crew = crew
        self.name.text = crew.name
        self.phone.text = crew.phone
    }
    
}

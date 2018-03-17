//
//  DonationCellController.swift
//  BOZ
//
//  Created by MacMini on 17/03/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class DonationCellController: UICollectionViewCell {
    
    @IBOutlet var amount: UILabel!
    @IBOutlet var desc: UILabel!
    @IBAction func plus1(_ sender: Any) {
        var kamut: Int = Int(amount.text!)!
        kamut += 1
        amount.text = "\(kamut)"
    }
}

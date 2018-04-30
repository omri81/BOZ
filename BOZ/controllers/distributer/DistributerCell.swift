//
//  DistributerCell.swift
//  BOZ
//
//  Created by user134028 on 4/26/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class DistributerCell: UICollectionViewCell {
    
    @IBAction func phoneCall() {
        
    }
    @IBAction func gotoWaze() {
    }
    
    @IBAction func myTasksBtn(_ sender: UIButton) {
        
    }
    @IBAction func assigBtn(_ sender: UIButton) {
    }
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var addressLB: UILabel!
    @IBOutlet weak var dayLB: UILabel!
    @IBOutlet weak var hourLB: UILabel!
  /*
     override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.contentView.backgroundColor = UIColor.red
            }
            else
            {
                self.transform = CGAffineTransform.identity
                self.contentView.backgroundColor = UIColor.gray
            }
        }
    }
   */
}

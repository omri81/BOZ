//
//  ProductCollectionViewCell.swift
//  BOZ
//
//  Created by user134028 on 2/23/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productLabel: UILabel!
    
    func displayContent(image:UIImage,title:String) {
        productImage.image = image
        productLabel.text = title + "dfsff"
    }
}

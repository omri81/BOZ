//
//  DonationProduct.swift
//  BOZ
//
//  Created by Bar Arbiv on 01/03/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

public class DonationProduct{
    
    var name: String!
    var description: String!
    var image : UIImage!
    
    init(name: String, description: String, image: UIImage?) {
        self.name = name
        self.description = description
        self.image = image
    }
    
}

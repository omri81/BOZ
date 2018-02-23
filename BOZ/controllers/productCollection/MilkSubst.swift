//
//  MilkSubst.swift
//  BOZ
//
//  Created by user134028 on 2/23/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Foundation

public struct MilkSubst {
    var title: String
    var fullDesc: String
    var coverImage: String
    
    init(title:String,fullDesc:String,coverImage:String) {
        self.title = title
        self.fullDesc = fullDesc
        self.coverImage = coverImage
    }
    init(){
        title = ""
        fullDesc = ""
        coverImage = "https://images.moviepilot.com/image/upload/c_fill,h_630,q_auto:best,w_1200/iloar0rvcsy1bhmpy0at.jpg"
    }
    
}

//
//  DataStore.swift
//  BOZ
//
//  Created by user134028 on 2/23/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import Foundation
import UIKit
public var subsArray = [MilkSubst]()
final class DataStore {
    
    static let sharedInstance = DataStore()
    fileprivate init() {}
    
    var milkSubsts: [MilkSubst] = []
    var images: [UIImage] = []
    
    func getSubsts(subs:[MilkSubst]) {
        milkSubsts = subs
        for subst in milkSubsts {
            //set img
            let url = URL(string: subst.coverImage)! //url to img
            URLSession.shared.dataTask(with: url) { (imgData, r, e) in
                let img = UIImage(data: imgData!) //in background
                print(r ?? "no r")
                print(e ?? "no e")
                print(imgData ?? "no imgData")
                self.images.append(img!)
               // DispatchQueue.main.async {
               //     self.images.append(img!)
               // }
                }.resume()
        }
        }
       /*"https://images.moviepilot.com/image/upload/c_fill,h_630,q_auto:best,w_1200/iloar0rvcsy1bhmpy0at.jpg"*/
}


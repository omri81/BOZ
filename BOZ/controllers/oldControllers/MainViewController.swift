//
//  MainViewController.swift
//  BOZ
//
//  Created by user134028 on 2/21/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import Foundation

class MainViewController: BaseViewController {
    
    
    @IBOutlet weak var quickDonationBtn: UIButton!
    @IBOutlet weak var logoGifImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //productfill
        let product = ProductModel()
        product.insertNewProduct(qr: "sfsef---QR---sdf",
                                 title: "תחליף חלב טעים")
        let milkModel = ProductModel()
        let milkArray = milkModel.productQueryAll()
            for m in milkArray {
                print ("milk: title: \(m.title!) qr: \(m.qr!)")
            }
        
        logoGifImageView.loadGif(name: "logo")
        quickDonationBtn.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.quickDonationBtn.transform = .identity
            },
                       completion: nil)
        
        getJsonFromUrl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        //this function is fetching the json from URL
        func getJsonFromUrl(){
            let URL_HEROES = "https://cf66e30d-0e37-45cc-b5b7-ff206a2861b3-bluemix.cloudant.com/neptun/1" // "https://api.myjson.com/bins/sxhnp"
            //creating a NSURL
            let url = NSURL(string: URL_HEROES)
            
            //fetching the data from the url
            URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
                
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    if let title = jsonObj!.value(forKey: "title") {
                        print(title)
                    }
                    //printing the json in console
                   // print(jsonObj!.value(forKey: "items")!)
                    
                    //getting the avengers tag array from json and converting it to NSArray
                    if let heroeArray = jsonObj!.value(forKey: "items") as? NSArray {
                        //looping through all the elements
                        for heroe in heroeArray{
                            
                            //converting the element to a dictionary
                            if let heroeDict = heroe as? NSDictionary {
                                var sub = MilkSubst()
                                //getting the title from the dictionary
                                if let title = heroeDict.value(forKey: "title") {
                                    sub.title = title as! String
                                }
                                //getting the fullDesc from the dictionary
                                if let fullDesc = heroeDict.value(forKey: "fullDesc") {
                                    sub.fullDesc = fullDesc as! String
                                }
                                //getting the artworkUrl100 from the dictionary
                                if let artworkUrl100 = heroeDict.value(forKey: "artworkUrl100") {
                                    sub.coverImage = artworkUrl100 as! String
                                    print(sub.coverImage)
                                }
                                subsArray.append(sub)
                            }
 
                        }

                    }
                    
                    OperationQueue.main.addOperation({
                        //calling another function after fetching the json
                       
                    })
                }
            }).resume()
    }
    

}

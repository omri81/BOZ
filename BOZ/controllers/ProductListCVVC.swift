//
//  ProductListCVVC.swift
//  BOZ
//
//  Created by Bar Arbiv on 01/03/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import Alamofire

class ProductListCVVC: UICollectionViewController {

    private let reuseIdentifier = "productCell"
    
    private var products: [DonationProduct] = []
        /*
        DonationProduct(name: "מטרנה", description: "תכולה: 700ג׳, גילאים: 3-7 חודשים", image: UIImage(named: "baby_food_ex")),
        DonationProduct(name: "סימילאק", description: "תכולה: 750ג׳, גילאים: 5-7 חודשים", image: UIImage(named: "baby_food_ex")),
        DonationProduct(name: "מטרנה", description: "תכולה: 600ג׳, גילאים: 1-3 חודשים", image: UIImage(named: "baby_food_ex")),
        DonationProduct(name: "סימילאק", description: "תכולה: קֿֿֿֿֿ/״ג, גילאים: 3-7 חודשים", image: UIImage(named: "baby_food_ex")),
        DonationProduct(name: "סימילאק", description: "תכולה: קֿֿֿֿֿ/״ג, גילאים: 3-7 חודשים", image: UIImage(named: "baby_food_ex")),
        DonationProduct(name: "סימילאק", description: "תכולה: קֿֿֿֿֿ/״ג, גילאים: 3-7 חודשים", image: UIImage(named: "baby_food_ex")),
    ]*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPoducts(url: "GetProductListForDonators",bookMark: "")
        //GetProductListForHelpless
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCell
        
        cell.setCell(products[indexPath.row])
    
        return cell
    }
    public func getPoducts(url:String,bookMark:String) {
        let parameters: Parameters = [
            "bookmark" : bookMark
        ]
        let methodeUrl = "https://zeevtesthu.mybluemix.net/api/Milk/" + url
        Alamofire.request(methodeUrl, method: HTTPMethod.post , parameters: parameters ,
                          encoding: JSONEncoding.default, headers: [:])
            .validate(contentType: ["application/json"]).responseJSON { response in
                print("response: \(response)")
                switch response.result {
                case .success:
                    print("sucess response from server")
                    guard let responseJSON = response.result.value as? [String: Any],
                        let status = responseJSON["status"] as? String,
                        let statusMsg = responseJSON["statusMsg"] as? String
                        else {
                            print("server problem")
                            return
                    }
                    if status == "OK" {
                        print("login success")
                        guard let docs = responseJSON as? [[String: Any]]
                            else {return}
                        var docsArray:[[String:Any]] = []
                        for d in docs {
                            docsArray.append(d)
                        }
                        print(docs)
                    } else {
                        print("server response: " + statusMsg)
                    }
                    
                case .failure(let error):
                    print("error:\(error)")
                }
        }
    }
}

class ProductCell: UICollectionViewCell{
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    

    
    public func setCell(_ product: DonationProduct){
        self.nameLbl.text? = product.name
        self.descriptionLbl.text? = product.description
        print(product.image)
        //self.image.image! = product.image
    }
    
}










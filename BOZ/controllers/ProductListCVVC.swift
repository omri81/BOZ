//
//  ProductListCVVC.swift
//  BOZ
//
//  Created by Bar Arbiv on 01/03/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit


class ProductListCVVC: UICollectionViewController {

    private let reuseIdentifier = "productCell"
    
    private var products: [DonationProduct] = [
        DonationProduct(name: "מטרנה", description: "תכולה: 700ג׳, גילאים: 3-7 חודשים", image: UIImage(named: "baby_food_ex")),
        DonationProduct(name: "סימילאק", description: "תכולה: 750ג׳, גילאים: 5-7 חודשים", image: UIImage(named: "baby_food_ex")),
        DonationProduct(name: "מטרנה", description: "תכולה: 600ג׳, גילאים: 1-3 חודשים", image: UIImage(named: "baby_food_ex")),
        DonationProduct(name: "סימילאק", description: "תכולה: קֿֿֿֿֿ/״ג, גילאים: 3-7 חודשים", image: UIImage(named: "baby_food_ex")),
        DonationProduct(name: "סימילאק", description: "תכולה: קֿֿֿֿֿ/״ג, גילאים: 3-7 חודשים", image: UIImage(named: "baby_food_ex")),
        DonationProduct(name: "סימילאק", description: "תכולה: קֿֿֿֿֿ/״ג, גילאים: 3-7 חודשים", image: UIImage(named: "baby_food_ex")),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCell
        
        cell.setCell(products[indexPath.row])
    
        return cell
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
        self.image.image! = product.image
    }
    
}










//
//  ProductListViewController.swift
//  BOZ
//
//  Created by user134028 on 2/23/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    
    let store = DataStore.sharedInstance
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.milkSubsts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        let milkSubst = store.milkSubsts[indexPath.row]
        print("\(indexPath.row), store image count:\(store.images.count)")
        let img = store.images[indexPath.row]

        cell.displayContent(image: img, title: milkSubst.title)
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        store.getSubsts(subs: subsArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

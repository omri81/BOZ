//
//  PakageDetailsVC.swift
//  BOZ
//
//  Created by user134028 on 5/18/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class PakageDetailsVC: UIViewController, UICollectionViewDataSource {
    private var  name = "",
    address = "" ,
    phone = ""
    var donations:[String] = []
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var addressLB: UITextView!
    @IBOutlet weak var phoneLB: UILabel!
    @IBAction func wazeBTN() {
    }
    @IBAction func doneBtn() {
    }
    @IBAction func notMineBtn() {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLB.text = name
        addressLB.text = address
        phoneLB.text = phone
    }
    public func setDetails(name:String,address:String,phone:String) {
        self.name = name
        self.address = address
        self.phone = phone
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return donations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PakageCell
        
        // enter all cell.donation name , amount etc...
        
        return cell
    }

}

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
    phone = "", _id = "", _rev = ""
    var personalView: Bool!
    var delegate: DistributerVCDelegate?
    var packageID:String = ""
    
    var donations:[Item] = []
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var addressLB: UITextView!
    @IBOutlet weak var phoneLB: UILabel!
    @IBOutlet var mine: UIButton!
    
    @IBAction func wazeBTN() {
    }
    @IBAction func deletBtn() {
        //deleting from DB
        deleteTask(_id: _id, _rev: _rev)
    }
    @IBAction func notMineBtn() {
        var tasks:[String] = []
        tasks.append(packageID)
        delegate?.updateTask(tasks: tasks)
        navigationController?.popToRootViewController(animated: true)        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLB.text = name
        addressLB.text = address
        phoneLB.text = phone
        
        mine.setTitle(personalView ? "בטל שיבוץ" : "שיבוץ", for: .normal)
        
    }
    public func setDetails(packageID: String, name:String,address:String,phone:String,personalView:Bool,_id:String,_rev:String,itemList:[Item]) {
        self.packageID = packageID
        self.name = name
        self.address = address
        self.phone = phone
        self.personalView = personalView
        self._id = _id
        self._rev = _rev
        self.donations = itemList
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // TODO: Self-sizing
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderID2", for: indexPath as IndexPath)
        
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return donations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PakageCell
        cell.itemLB.text =  donations[indexPath.row].title
        cell.amountLB.text = "\(donations[indexPath.row].amount)"
        return cell
    }
    func alertMsg(title ttl:String,msg:String) {
        let alert = UIAlertController(
            title: ttl,
            message: msg,
            preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "בסדר", style: .default) { (action) in
            // do something when user press OK button, like deleting text in both fields or do nothing
        }
        
        alert.addAction(OKAction)
        
        present(alert, animated: true, completion: nil)
        return
    }
    

}

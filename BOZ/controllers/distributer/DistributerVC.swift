	//
//  DistributerViewController.swift
//  BOZ
//
//  Created by user134028 on 3/6/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import Alamofire
    protocol DistributerVCDelegate{
        func collectionViewReload()
        func updateTask(tasks:[String])
    }

class DistributerVC: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate ,UIGestureRecognizerDelegate, DistributerVCDelegate
{
   
    
    
    var myId:String = ""
    var donations:[Package] = []
    var myTasks:[Package] = []
    var personalView:Bool = false
    var selectedItems:[String] = [] //  idNumber of each product
    
    
    
    @IBOutlet weak var actionBtn: UIButton!
    @IBAction func filterBtn(_ sender: UIButton) {
        personalView = !personalView
        if personalView {
            sender.setTitle("פנוי", for: UIControlState.normal)
            actionBtn.setTitle("שיחרור", for: .normal)
        } else {
            sender.setTitle("שלי", for: UIControlState.normal)
            actionBtn.setTitle("שיבוץ", for: .normal)
        }
        navigationItem.title = personalView ? "המשימות שלי" : "תרומות ממתינות לשיבוץ"
        if personalView {
            getMyTasks(bookmark: "", delivererId: myId )
        } else {
            getAllEmptyDestributer(bookmark: "")
        }
    }
    @IBAction func assignBtn() {
        if selectedItems.isEmpty {
            alertMsg(title: "שיבוץ", msg: "בחר יעדים לשיבוץ")
        } else {
            //call to server , pass selected array and set it to []
            updateTask(tasks: selectedItems)
        }
    }
    
    func updateTask(tasks:[String]){
        updateTasks(delivererId: myId,donations: tasks) {
            (result:String) in
            print(result)
            if result == "OK" {
                self.selectedItems = []
                if self.personalView {
                    self.getMyTasks(bookmark: "", delivererId: self.myId)
                } else {
                    self.getAllEmptyDestributer(bookmark: "")
                }
            }
        }
    }
    
    func collectionViewReload() {
        if personalView {
            getMyTasks(bookmark: "", delivererId: myId)
        } else {
            getAllEmptyDestributer(bookmark: "")
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func logout(_ sender: Any) {
        let mainVC = storyboard!.instantiateViewController(withIdentifier: "toMainVC") as! MainVC
        UIApplication.shared.keyWindow?.rootViewController = mainVC
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // TODO: Self-sizing
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath as IndexPath)
               
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personalView ? myTasks.count : donations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DistributerCell        
        cell.phone = personalView ?
            myTasks[indexPath.item].phoneNumber : donations[indexPath.item].phoneNumber
        cell.lat = personalView ?
        myTasks[indexPath.item].latitude : donations[indexPath.item].latitude
        cell.lon = personalView ?
            myTasks[indexPath.item].longitude : donations[indexPath.item].longitude
        cell.addressLB.text = personalView ?
            myTasks[indexPath.item].address : donations[indexPath.item].address
        cell.nameLB.text = personalView ?
            myTasks [indexPath.item].famelyName : donations[indexPath.item].famelyName
        cell._id = personalView ? myTasks[indexPath.item]._id :
            donations[indexPath.item]._id
        cell._rev = personalView ? myTasks[indexPath.item]._rev :
            donations[indexPath.item]._rev
        
        cell.layer.borderWidth = 100
        cell.layer.borderColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0).cgColor
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if cell?.layer.borderWidth == 100 {
        //if this is the first time:
        //mark it and add it to the selectedTasks
            cell?.layer.borderWidth = 200.0
            cell?.layer.borderColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4).cgColor
            addSelectedItem(item: indexPath.item)
        } else {
        //if this cell already been selected,
        //unmark it and remove it from selectedTasks
            cell?.layer.borderWidth = 100.0
            cell?.layer.borderColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0).cgColor
            removeSelectedItem(item: indexPath.item)
        }
    }
    func addSelectedItem (item:Int) {
        personalView ?
            selectedItems.append(myTasks[item]._id) :
            selectedItems.append(donations[item]._id)
    }
    func removeSelectedItem (item:Int) {
        if let index = personalView ?
            selectedItems.index(where: {$0 == myTasks[item]._id}) :
            selectedItems.index(where: {$0 == donations[item]._id})
        { selectedItems.remove(at: index) }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.9921568627, blue: 1, alpha: 0.1793931935)
        
        let prefs = UserDefaults.standard
        myId = prefs.string(forKey: DONATOR_IDNUMBER)!
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(longPressGR:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        self.collectionView.addGestureRecognizer(lpgr)
        
        getAllEmptyDestributer(bookmark: "")
        print("view did load")
    }
    @objc
    func handleLongPress(longPressGR: UILongPressGestureRecognizer) {
        if longPressGR.state != .ended {
            return
        }
        
        
        let point = longPressGR.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: point)
        
        if let indexPath = indexPath {
            var cell = self.collectionView.cellForItem(at: indexPath) as! DistributerCell
            let next = storyboard?.instantiateViewController(withIdentifier: "PakageDetails") as! PakageDetailsVC
            next.delegate = self
            let itemList = personalView ? myTasks[indexPath.row].itemList : donations[indexPath.row].itemList
            let p = personalView ? myTasks[indexPath.row].phoneNumber : donations[indexPath.row].phoneNumber
            let packageID = personalView ?
                myTasks[indexPath.row]._id : donations[indexPath.row]._id
            next.setDetails(packageID: packageID,name: cell.nameLB.text!, address: cell.addressLB.text!, phone: p, personalView: personalView,_id: cell._id, _rev: cell._rev, itemList: itemList )
            print(itemList)
            show(next, sender: self)
        } else {
            print("Could not find index path")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension DistributerVC {
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
    


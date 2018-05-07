//
//  DistributerViewController.swift
//  BOZ
//
//  Created by user134028 on 3/6/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit
import Alamofire

class DistributerVC: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate  {
    
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
            actionBtn.setTitle("שיבוץ", for: .normal)
        } else {
            sender.setTitle("שלי", for: UIControlState.normal)
            actionBtn.setTitle("שיחרור", for: .normal)
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
            updateTasks(delivererId: myId,donations: selectedItems)            
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func logout(_ sender: Any) {
        let mainVC = storyboard!.instantiateViewController(withIdentifier: "toMainVC") as! MainVC
        UIApplication.shared.keyWindow?.rootViewController = mainVC
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personalView ? myTasks.count : donations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DistributerCell
        
        cell.addressLB.text = personalView ?
            myTasks[indexPath.item].address : donations[indexPath.item].address
        cell.nameLB.text = personalView ?
            myTasks [indexPath.item].famelyName : donations[indexPath.item].famelyName
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
        
        getAllEmptyDestributer(bookmark: "")
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

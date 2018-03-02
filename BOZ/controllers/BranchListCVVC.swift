//
//  BranchListVC.swift
//  BOZ
//
//  Created by Bar Arbiv on 28/02/2018.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class BranchListCVVC: UICollectionViewController{
    
    let branches: [Branch] = [
        Branch(name: "מרכז קהילתי נאות שושנים", address: "רח' סיגלון 12 חולון", phoneNumber: "03-5503977", lat: 32.0140918, lon: 34.78227149999998),
        Branch(name: "מרכז קהילתי ומרכז הספורט בן גוריון", address: "רח' קרסל 6 חולון", phoneNumber: "03-5528490", lat: 31.9966358, lon: 34.7688905),
        Branch(name: "מרכז קהילתי נווה ארזים", address: "רח' ישעיהו 16 חולון", phoneNumber: "03-5506772", lat: 32.0166555, lon: 34.79153450000001),
        Branch(name: "מרכז קהילתי וולפסון", address: "רח' צבי ש\"ץ 29 חולון", phoneNumber: "03-6519181", lat: 32.0251251, lon: 34.768034899999975),
        Branch(name: "מרכז קהילתי לזרוס", address: "רח' סנהדרין 27 חולון", phoneNumber: "03-5030068", lat: 32.0037141, lon: 34.76340860000005),
        Branch(name: "מרכז קהילתי נאות רחל", address: "רח' חצרים 2 חולון", phoneNumber: "03-5035499", lat: 32.0159709, lon: 34.76477),
        Branch(name: "מרכז קהילתי קליין", address: "רח' פילדלפיה 16 חולון", phoneNumber: "03-5038083", lat: 32.0278104, lon: 34.76115589999995),
        Branch(name: "מקהל\"ת מרכז קהילתי תורני", address: "רח' פילדלפיה 5 חולון", phoneNumber: "03-5015529", lat: 32.0273938, lon: 34.76350200000002),
        Branch(name: "מרכז פסגות", address: "רח' סרלין 21 חולון", phoneNumber: "03-6530300", lat: 32.0245225, lon: 34.784841099999994),
        Branch(name: "מרכז חנקין", address: "רח' חנקין 109 חולון", phoneNumber: "03-5590021", lat: 32.0156698, lon: 34.778664299999946),
        Branch(name: "רעים מרכז למחול ותנועת הגוף", address: "רח' הופיין 44 חולון", phoneNumber: "03-5035299", lat: 32.013689, lon: 34.76994500000001),
        Branch(name: "מרכז שטיינברג החדש", address: "רח' גבעת התחמושת 21 חולון", phoneNumber: "03-5500012", lat: 32.0055055, lon: 34.790152000000035)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0.9921568627, blue: 1, alpha: 0.1793931935)
        // Do any additional setup after loading the view.
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return branches.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "branchCell", for: indexPath) as! BranchCell
        
        cell.setCellData(branch: branches[indexPath.row])
        
        return cell
    }
    
}

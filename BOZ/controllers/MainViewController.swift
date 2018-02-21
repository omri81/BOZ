//
//  MainViewController.swift
//  BOZ
//
//  Created by user134028 on 2/21/18.
//  Copyright © 2018 Ovadia. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var quickDonationBtn: UIButton!
    @IBOutlet weak var logoGifImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

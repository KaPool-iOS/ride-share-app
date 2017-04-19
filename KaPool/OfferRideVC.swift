//
//  OfferRideVC.swift
//  KaPool
//
//  Created by Madel Asistio on 4/19/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class OfferRideVC: UIViewController {
    @IBOutlet weak var priceView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        priceView.layer.shadowColor = UIColor.black.cgColor
        priceView.layer.shadowOpacity = 1
        priceView.layer.shadowOffset = CGSize.zero
        priceView.layer.shadowRadius = 10

        // Do any additional setup after loading the view.
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

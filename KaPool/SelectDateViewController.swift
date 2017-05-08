//
//  SelectDateViewController.swift
//  KaPool
//
//  Created by Madel Asistio on 5/8/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

protocol SelectDateViewControllerDelegate: class {
    func changeDepTime(_ dateChosen: Date)
}

class SelectDateViewController: UIViewController {

    weak var delegate: SelectDateViewControllerDelegate?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var goBttn: UIButton!
    var selectedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

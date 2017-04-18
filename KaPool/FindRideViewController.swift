//
//  FindRideViewController.swift
//  KaPool
//
//  Created by  Alex Sumak on 4/17/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class FindRideViewController:
UIViewController {
  
  @IBOutlet weak var fromText: UITextField!
  
  @IBOutlet weak var toText: UITextField!
  
  @IBOutlet weak var dateText: UITextField!
  
  @IBOutlet weak var timeText: UITextField!
  
  @IBOutlet weak var seatsText: UILabel!
  
  @IBOutlet weak var stepper: UIStepper!
  
  @IBAction func stepperChangeValue(_ sender: UIStepper) {
    
    seatsText.text = Int(sender.value).description
  }
  
  

    override func viewDidLoad() {
        super.viewDidLoad()
      super.viewDidLoad()
      stepper.wraps = true
      stepper.autorepeat = true
      stepper.maximumValue = 4
      
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

//
//  EditProfileViewController.swift
//  KaPool
//
//  Created by  Alex Sumak on 5/21/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
      
  @IBOutlet weak var nameLabel: UILabel!
  
    var fullname:String?

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.nameLabel?.text = fullname
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

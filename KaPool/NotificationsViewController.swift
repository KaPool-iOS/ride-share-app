//
//  NotificationsViewController.swift
//  KaPool
//
//  Created by Madel Asistio on 5/22/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit
import Parse

class NotificationsViewController: UIViewController {
    
    var notifs: [Trip] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Trip.getNotifs { (trips: [Trip]) in
            self.notifs = trips
            
            
            for notif in self.notifs {
                print(notif)
            }
        }
        
        

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

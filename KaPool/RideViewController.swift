//
//  RideViewController.swift
//  KaPool
//
//  Created by Jake Vo on 4/16/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit
import Parse

class RideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var rides: [Ride] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        getData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onOfferRide(_ sender: Any) {
        
        let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        appDelegate.login()
        
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "rideCell") as! RideCell
        
        
        return cell
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 0
    }
    
    func getData() {
        
        // construct query
        let query = PFQuery(className: "Ride")
        query.limit = 20
       
        // fetch data asynchronously
        query.findObjectsInBackground { (ride: [PFObject]?, error: Error?) -> Void in
            if let ride = ride {
                // do something with the array of object returned by the call
                
                for i in (0...ride.count-1).reversed() {
                    self.rides.append(Ride.init(ride[i]))
        
                }
                
                // self.instaPosts = posts
                self.tableView.reloadData()
                
            } else {
                print(error?.localizedDescription)
            }
        } 
        
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

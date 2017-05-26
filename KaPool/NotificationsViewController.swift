//
//  NotificationsViewController.swift
//  KaPool
//
//  Created by Madel Asistio on 5/22/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit
import Parse

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, tripMapViewControllerDelegate{
    
    var notifs: [Trip] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        Trip.getNotifs { (trips: [Trip]) in
            
            var tmpArr: [Trip] = []
            
             for trip in trips.reversed() {
                tmpArr.append(trip)
            }
            
            self.notifs = tmpArr
            self.tableView.reloadData()
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
    }
    
    func returningtoView(tripId: String, response: Int) {
        
        for trip in self.notifs {
            if trip.tripID == tripId {
                trip.response = response
            }
        }
        tableView.reloadData()
    
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "notifCell") as! NotifCell
        cell.trip = self.notifs[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        if (self.notifs[indexPath.row].response != 0) {
            return nil
        }
        
        return indexPath
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return notifs.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let tripCell = sender as! NotifCell
        let tripDetails = segue.destination as! tripMapViewController
        tripDetails.ride = tripCell.ride
        tripDetails.pickupLoc = tripCell.trip.pickupLocation
        tripDetails.pickupName = tripCell.trip.pickupName
        tripDetails.currTripID = tripCell.trip.tripID
        
        self.hidesBottomBarWhenPushed = true
        
    }
    

}

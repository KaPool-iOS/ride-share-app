//
//  Trip.swift
//  KaPool
//
//  Created by Madel Asistio on 5/21/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit
import Parse

class Trip: NSObject {
    
    var tripID: String?
    var createdAt: Date?
    var updatedAt: Date?
    var rideID: String?
    var riderID: String?
    var driverID: String?
    var pickupID: String?
    
    init(_ trip: PFObject) {
        
        super.init()
        
        self.tripID = trip.objectId
        self.createdAt = trip.createdAt
        self.updatedAt = trip.updatedAt
        self.rideID = trip.object(forKey: "rideID") as? String
        self.riderID = trip.object(forKey: "riderID") as? String
        self.driverID = trip.object(forKey: "driverID") as? String
        self.pickupID = trip.object(forKey: "pickupLoc") as? String
        
    }
    
    class func addTrip(rideid: String, pickup: String, driverAccepted: Bool, riderid: String, driverid: String, withCompletion completion: PFBooleanResultBlock?) {
        
        let trip = PFObject(className: "Trip")
        
        trip["rideID"] = rideid
        trip["pickupLoc"] = pickup
        trip["driverAccepted"] = false
        trip["riderID"] = riderid
        trip["driverID"] = driverid
        
        
        trip.saveInBackground(block: completion)
        
        
    }
    
    class func getNotifs(withCompletion completion: @escaping (_ trips: [Trip] ) -> ()) {
        
        var notifications: [Trip] = []
        let user = User.init(PFUser.current()!)
        
        let query = PFQuery(className: "Trip")
        
        // fetch data asynchronously
        query.findObjectsInBackground { (notifs: [PFObject]?, error: Error?) -> Void in
           
            if let notifs = notifs {
                // do something with the array of object returned by the call
                
                if notifs.count > 0 {
                    
                    for notif in notifs {
    
                        if (user.userID == notif.object(forKey: "driverID") as? String) {
                            notifications.append(Trip.init(notif))
                        }
                    }
            
                    completion(notifications)
                    
                } else {
                    print ("No Notifications Found")
                }
            }
        }
        
    }
    
}

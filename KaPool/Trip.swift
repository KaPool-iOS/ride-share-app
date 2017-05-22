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
    
    class func addTrip(rideid: String, pickup: String, driverAccepted: Bool, riderid: String, driverid: String, withCompletion completion: PFBooleanResultBlock?) {
        
        let trip = PFObject(className: "Trip")
        
        trip["rideID"] = rideid
        trip["pickupLoc"] = pickup
        trip["driverAccepted"] = false
        trip["riderID"] = riderid
        trip["driverID"] = driverid
        
        
        trip.saveInBackground(block: completion)
        
        
    }
    
}

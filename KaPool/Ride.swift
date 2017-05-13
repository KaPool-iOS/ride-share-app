//
//  Ride.swift
//  KaPool
//
//  Created by Jake Vo on 4/17/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//
import Foundation

import UIKit
import Parse
import GooglePlaces

class Ride: NSObject {
    
    var driver: String = ""
    var origin: GMSPlace?
    var destination: GMSPlace?
    var departDate: Date?
    var price: Double?
    var seats: Int?
    
    
    init(ride: PFObject?) {
        
        self.driver = ride?.object(forKey: "Driver") as! String
       // self.origin = ride[
     //   self.destination = destination
        self.departDate = ride?.object(forKey: "Date") as! Date?
        self.price = ride?.object(forKey: "Price") as! Double?
        self.seats = ride?.object(forKey: "SeatsAvail") as! Int?
        
    }
    
    class func addRide(destination: GMSPlace?, origin: GMSPlace?,
                       price: Double?, departDate: Date?, seats: Int?, withCompletion completion: PFBooleanResultBlock?) {
        
        // create Parse object PFObject
        let ride = PFObject(className: "Ride")
        
        // saves ride information into database
        ride["Price"] = price
        ride["Date"] = departDate
        ride["DestLatitude"] = (destination?.coordinate.latitude)!
        ride["DestLongitude"] = (destination?.coordinate.longitude)!
        ride["OriginLatitude"] = (origin?.coordinate.latitude)!
        ride["OriginLongitude"] = (origin?.coordinate.longitude)!
        ride["Active"] = true
        ride["SeatsAvail"] = seats
        ride["Driver"] = PFUser.current()?.objectId
        
        ride.saveInBackground(block: completion)
        
    }
    
    
}



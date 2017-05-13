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
    
    /*

    var driverName:String = ""
    var rideID:String = ""
    
    var location:String = ""
    var destination:String = ""
    
    var rideDate:Date?
    
    var time:String = ""
    var price:String = ""
    
    
    
    init(driverName:String, location:String, destination:String, rideDate:Date, time:String, price:String) {
        
        
        self.driverName = driverName
        self.riderName = riderName
        self.rideID = rideID
        
        self.location = location
        self.destination = destination
        self.rideDate = rideDate
        self.time = time
        self.price = price
    } */
    
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



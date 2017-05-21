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
    var originID: String?
    var destinationID: String?
    var departDate: Date?
    var price: Double?
    var seats: Int?
    var rideID: String?
    var destName: String?
    var originName: String?
    
    
    
    init(_ ride: PFObject?) {
        
        super.init()
        
        
        self.driver = ride?.object(forKey: "Driver") as! String
        self.departDate = ride?.object(forKey: "Date") as? Date
        self.price = ride?.object(forKey: "Price") as! Double?
        self.seats = ride?.object(forKey: "SeatsAvail") as! Int?
        self.rideID = ride?.object(forKey: "objectId") as? String
        self.originID = ride?.object(forKey: "Origin") as? String
        self.destinationID = ride?.object(forKey: "Destination") as? String
        self.destName = ride?.object(forKey: "destName") as? String
        self.originName = ride?.object(forKey: "originName") as? String
    }
    
    class func addRide(destination: GMSPlace?, origin: GMSPlace?,
                       price: Double?, departDate: Date?, seats: Int?, withCompletion completion: PFBooleanResultBlock?) {
        
        
        let placesClient = GMSPlacesClient()
        // create Parse object PFObject
        let ride = PFObject(className: "Ride")
        
        // saves ride information into database
        ride["Price"] = price
        ride["Date"] = departDate
        ride["Destination"] = destination?.placeID
        ride["Origin"] = origin?.placeID
        ride["Active"] = true
        ride["SeatsAvail"] = seats
        ride["Driver"] = PFUser.current()?.objectId
        
        
        placesClient.lookUpPlaceID((origin?.placeID)!, callback: { (place, error) -> Void in
            
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            print("the place is \(place!.name)")
           
            ride["originName"] = place!.name
        })
        
        placesClient.lookUpPlaceID((destination?.placeID)!, callback: { (place, error) -> Void in
            
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            
            ride["destName"] = place!.name
            
             ride.saveInBackground(block: completion)
        })
        
        
    }
    
}



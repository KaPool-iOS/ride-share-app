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
    
    
    init(_ ride: PFObject?) {
        
        super.init()
        
        
        self.driver = ride?.object(forKey: "Driver") as! String
        self.departDate = ride?.object(forKey: "Date") as? Date
        self.price = ride?.object(forKey: "Price") as! Double?
        self.seats = ride?.object(forKey: "SeatsAvail") as! Int?
        self.rideID = ride?.object(forKey: "objectId") as? String
        self.originID = ride?.object(forKey: "Origin") as? String
        self.destinationID = ride?.object(forKey: "Destination") as? String
        
    }
    
    class func addRide(destination: GMSPlace?, origin: GMSPlace?,
                       price: Double?, departDate: Date?, seats: Int?, withCompletion completion: PFBooleanResultBlock?) {
        
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
        
        ride.saveInBackground(block: completion)
        
    }
    /*
    func getPlace(_ placeID: String?, _ key: String?) {
        
        let placesClient = GMSPlacesClient()
        var thisPlace: GMSPlace?
        
        placesClient.lookUpPlaceID(placeID!, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else {
                print("No place details for \(placeID)")
                return
            }
            
            print("Place name \(place.name)")
            print("Place address \(place.formattedAddress)")
            print("Place placeID \(place.placeID)")
            print("Place attributions \(place.attributions)")
            
            thisPlace = place
            
            if key == "Origin" {
                self.origin = thisPlace
            } else {
                self.destination = thisPlace
            }
            
        })
    } */
    
    
    
}



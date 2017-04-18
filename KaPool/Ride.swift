//
//  Ride.swift
//  KaPool
//
//  Created by Jake Vo on 4/17/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//
import Foundation

import UIKit

class Ride: NSObject {

    var driverName:String = ""
    var riderName:String = ""
    var rideID:String = ""
    
    var location:String = ""
    var destination:String = ""
    
    var rideDate:Date?
    
    var time:String = ""
    var price:String = ""
    
    
    
    init(driverName:String,riderName:String,rideID:String, location:String, destination:String, rideDate:Date, time:String, price:String) {
        
        
        self.driverName = driverName
        self.riderName = riderName
        self.rideID = rideID
        
        self.location = location
        self.destination = destination
        self.rideDate = rideDate
        self.time = time
        self.price = price
    }
    
    
}



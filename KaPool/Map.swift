//
//  Map.swift
//  KaPool
//
//  Created by Madel Asistio on 5/26/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Parse
import Alamofire


class Map: NSObject {
    

    
    
    class func fetchMapData(mapView: GMSMapView, from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        
        let directionURL = "https://maps.googleapis.com/maps/api/directions/json?" +
            "origin=\(from.latitude),\(from.longitude)&destination=\(to.latitude),\(to.longitude)&" +
        "key=AIzaSyBXq3sMUeCLnoAkjSvKWaMSXvMKrDLyZ0s"
        
        
        
        Alamofire.request(directionURL).responseJSON
            { response in
                
                if let JSON = response.result.value {
                    
                    let mapResponse: [String: AnyObject] = JSON as! [String : AnyObject]
                    
                    let routesArray = (mapResponse["routes"] as? Array) ?? []
                    
                    let routes = (routesArray.first as? Dictionary<String, AnyObject>) ?? [:]
                    
                    let legs = (routes["legs"] as? Dictionary<String,AnyObject>) ?? [:]
                    let duration = (legs["duration"] as? Dictionary<String,AnyObject>) ?? [:]
                    
                    let durationTxt = duration["text"] as? String
                    
                    
                    
                    let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                    let polypoints = (overviewPolyline["points"] as? String) ?? ""
                    let line  = polypoints
                    
                    self.addPolyLine(mapView: mapView, encodedString: line)
                }
        }
        
    }
    
    class func travelMins(minString: String) {
        
    }
    
    class func addPolyLine(mapView: GMSMapView, encodedString: String) {
        
        let path = GMSMutablePath(fromEncodedPath: encodedString)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 5
        polyline.strokeColor = .blue
        polyline.map = mapView
        
    }


}

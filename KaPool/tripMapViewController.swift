//
//  tripMapViewController.swift
//  KaPool
//
//  Created by Madel Asistio on 5/22/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire

class tripMapViewController: UIViewController, GMSMapViewDelegate {
    
    @IBOutlet weak var requestorPic: GMSMapView!
    
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var timeView: UIView!
   
    @IBOutlet weak var decisionView: UIView!
    var pickupLoc: CLLocation!
    var pickupName: String!
    var tripArr: [Trip] = []
    var otherRidersLoc: [Trip] = []
    var origin: GMSPlace?
    var destination: GMSPlace?
    var ride: Ride!
    let apiKey: String = "AIzaSyBXq3sMUeCLnoAkjSvKWaMSXvMKrDLyZ0s"
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Trip.getTrips(rideid: ride.rideID!) { (trips: [Trip]) in
            print ("TRIPS GOT")
            self.tripArr = trips
            
            let placesClient = GMSPlacesClient()
            
            placesClient.lookUpPlaceID((self.ride.originID)!, callback: { (place, error) -> Void in
                
                if let error = error {
                    print("lookup place id query error: \(error.localizedDescription)")
                    return
                }
                
                self.origin = place
                
                placesClient.lookUpPlaceID((self.ride.destinationID)!, callback: { (place, error) -> Void in
                    
                    if let error = error {
                        print("lookup place id query error: \(error.localizedDescription)")
                        return
                    }
                    
                    self.destination = place
                 
        
                    
                    self.fixMap(trips: self.tripArr, handleComplete: {
                        self.handleViews()
                    })
                    /*
                    self.getOtherRiders(trips: self.tripArr, complete: {
                        
                        print("other riders got")
                        self.fixMap(trips: self.otherRidersLoc, handleComplete: {
                            print ("map done")
                            
                            // brings views to front
                            
                            self.handleViews()
                        })
                    }) */
                })
                
            })

        
        

        // Do any additional setup after loading the view.
        }
    }
    
    func handleViews() {

        
        self.decisionView.layer.shadowColor = UIColor.black.cgColor
        self.decisionView.layer.shadowOpacity = 0.5
        self.decisionView.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.mapView.bringSubview(toFront: self.decisionView)
        
        
        self.statsView.layer.shadowColor = UIColor.black.cgColor
        self.statsView.layer.shadowOpacity = 0.5
        self.statsView.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.mapView.bringSubview(toFront: self.statsView)
        
        
    }
    /*
    func getOtherRiders(trips: [Trip], complete:@escaping () -> ()) {
        
        //let placesClient = GMSPlacesClient()
       // let myGroup = DispatchGroup()
        
        for trip in trips {
            
            self.otherRidersLoc.append(trip)
        }
        
       /*
        var tripCt = 0
        while tripCt < trips.count {
            
           
            
            myGroup.enter()
            placesClient.lookUpPlaceID((trips[tripCt].pickupID)!, callback: { (place, error) -> Void in
                
                if let error = error {
                    print("lookup place id query error: \(error.localizedDescription)")
                    return
                }
                
                self.otherRidersLoc.append(place!)
                myGroup.leave()
                
            })
            tripCt = tripCt + 1
        }
        
        myGroup.notify(queue: DispatchQueue.main, execute: {
            print("Finished all requests.")
            complete ()
        }) */
    } */
    
    func fixMap(trips: [Trip], handleComplete:(()->())) {
        
        let camera = GMSCameraPosition.camera(withLatitude: origin!.coordinate.latitude,
                                              longitude: origin!.coordinate.longitude,
                                              zoom: 5)
        mapView.camera = camera
        mapView.delegate = self
        
        let path = GMSMutablePath()
        
        var bounds = GMSCoordinateBounds()
        
        for trip in trips {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: (trip.pickupLocation?.coordinate.latitude)!, longitude: (trip.pickupLocation?.coordinate.longitude)!)
            marker.map = self.mapView
            marker.title = trip.pickupName
            
            path.add((trip.pickupLocation?.coordinate)!)
            
            bounds = bounds.includingCoordinate(marker.position)
            
            marker.icon = GMSMarker.markerImage(with: UIColor.blue)
        }
        
        // adds origin and destination markers
        
        let ogMarker = GMSMarker()
        ogMarker.position = CLLocationCoordinate2D(latitude: origin!.coordinate.latitude, longitude: (origin?.coordinate.longitude)!)
        ogMarker.map = self.mapView
        ogMarker.title = "Origin"
        ogMarker.icon = GMSMarker.markerImage(with: UIColor.green)
        
        
        let destMarker = GMSMarker()
        destMarker.position = CLLocationCoordinate2D(latitude: destination!.coordinate.latitude, longitude: destination!.coordinate.longitude)
        destMarker.map = self.mapView
        
        destMarker.title = "Destination"
        
        path.add((origin?.coordinate)!)
        path.add((destination?.coordinate)!)
 
        
        bounds = bounds.includingCoordinate(ogMarker.position)
        bounds = bounds.includingCoordinate(destMarker.position)
        
        
        let update = GMSCameraUpdate.fit(bounds, withPadding: 100)
        mapView.animate(with: update)
        
     //   getPolylineRoute(from: (origin?.coordinate)!, to: (destination?.coordinate)!)

       // drawPath(currentLocation: (origin?.coordinate)!, destinationLoc: (destination?.coordinate)!)
        fetchMapData(from: (origin?.coordinate)!, to: (destination?.coordinate)!)

        
        handleComplete()
        
        
    }
    
    func fetchMapData(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        
        let directionURL = "https://maps.googleapis.com/maps/api/directions/json?" +
            "origin=\(from.latitude),\(from.longitude)&destination=\(to.latitude),\(to.longitude)&" +
        "key=\(self.apiKey)"
        
        
        
        Alamofire.request(directionURL).responseJSON
            { response in
                
                if let JSON = response.result.value {
                    
                    let mapResponse: [String: AnyObject] = JSON as! [String : AnyObject]
                    
                    let routesArray = (mapResponse["routes"] as? Array) ?? []
                    
                    let routes = (routesArray.first as? Dictionary<String, AnyObject>) ?? [:]
                    
                    let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                    let polypoints = (overviewPolyline["points"] as? String) ?? ""
                    let line  = polypoints
                    
                    self.addPolyLine(encodedString: line)
                }
        }
        
    }
    
    func addPolyLine(encodedString: String) {
        
        let path = GMSMutablePath(fromEncodedPath: encodedString)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 5
        polyline.strokeColor = .blue
        polyline.map = mapView
        
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

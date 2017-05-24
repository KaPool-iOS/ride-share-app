//
//  RideViewController.swift
//  KaPool
//
//  Created by Jake Vo on 4/16/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit
import Parse
import GooglePlaces
import GoogleMaps
import MapKit

class RideViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    //var tweetsArray: [Tweet]! = [Tweet]()
    var rides: [Ride]! = [Ride]()
    
    var startLocation: CLLocation!
    let defaults = UserDefaults.standard
    var globalValid = false
    
    var currLocName:String?
    
    var locationManager = CLLocationManager()
    var locationLatest:CLLocation!
    
    var searchDest:String = ""
    var searchDept:String = ""

    var signal = 0
    
    var destLoc:CLLocation?
    var originLoc:CLLocation?
    
    var dist1:Double = 0
    
    var dist2:Double = 0
    
    
    var bookCheck = false
    
    //@IBOutlet var tabbar: UITabBar!
    //@IBOutlet var tabbar: UITabBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        

        locationManager.startUpdatingLocation()

        
        
        //getData(distance: 0, signal: self.signal)
        // Do any additional setup after loading the view.
    }
    
    // SOMETHING TO ADD
    override func viewDidAppear(_ animated: Bool) {
        
        var distance:Double = 0.0
        //self.tableView.reloadData()
        
        if let destName = defaults.object(forKey: "destName") as? String {
            
            if let deptName = defaults.object(forKey: "deptName") as? String {
                print ("Here is destination \(destName)")
                print ("Here is origin \(deptName)")

                
                if let dist = defaults.object(forKey: "distance")  {
                    
                    print ("Here is it \(distance)")
                    
                    
                    
                    if let signalFromFindRide = defaults.object(forKey: "signal") as? Int {
                        
                        self.signal = signalFromFindRide
                        distance = dist as! Double
                        
                        if let originLat = defaults.object(forKey: "originLatitude") {
                            
                            if let originLon = defaults.object(forKey: "originLongtitude") {
                                
                                self.originLoc = CLLocation(latitude: originLat as! CLLocationDegrees, longitude: originLon as! CLLocationDegrees)
                            }
                            
                        }
                        
                        if let destLat = defaults.object(forKey: "destLatitude") {
                            
                            
                            if let destLon = defaults.object(forKey: "destLongtitude") {
                                
                                self.destLoc = CLLocation(latitude: destLat as! CLLocationDegrees, longitude: destLon as! CLLocationDegrees)
                                
                            }
                            
                            
                        }
                    }
                }
            }
            
        }
        
        getData(distance: distance, signal: self.signal)

    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse) {
            // User has granted autorization to location, get location
            locationManager.startUpdatingLocation()
        }
    }

    
    
    @IBAction func onOfferRide(_ sender: Any) {
        
        if PFUser.current() != nil {
            //let offerRide = storyboard.instantiateViewController(withIdentifier: "offerRide") as! UITabBarController
            //window?.rootViewController = offerRide
            
            // SOMETHING TO ADD -- PASS IN THE NEW RIDE
            let vc = storyboard?.instantiateViewController(withIdentifier: "offerRide") as! OfferRideVC
            
            self.present(vc, animated: true, completion: nil)
            
        } else {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "loginPage") as! SigninViewController
            vc.signal = "offer"
            
            self.present(vc, animated: true, completion: nil)
            
            
        }
    }
    
    /*
     get user current location
     convert it into place name
     then comapre if the places in ride array are close to this place
     */
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationLatest = locations[locations.count - 1]
        if self.startLocation == nil {
            self.startLocation = locationLatest
            
            //print("startLocation is \(startLocation!)")
            
            let lat = NSNumber(value: startLocation.coordinate.latitude)
            let lon = NSNumber(value: startLocation.coordinate.longitude)
            
            let userLocation: NSDictionary = ["lat": lat, "lon": lon]
            
            
            self.defaults.set(userLocation, forKey: "currentLocation")
            
            self.defaults.synchronize()
            
            CLGeocoder().reverseGeocodeLocation(startLocation, completionHandler: {(placemarks, error) -> Void in
                
                if error != nil {
                    
                    print(error!)
                    
                } else {
                    
                    if let placemark = placemarks?[0] {
                        
                        var address = ""
                        if placemark.subThoroughfare != nil {
                            
                            address += placemark.subThoroughfare! + " "
                        }
                        
                        if placemark.thoroughfare != nil {
                            
                            address += placemark.thoroughfare! + "?"
                            
                        }
                        
                        self.currLocName = address
                    }
                    
                }
                
                
            })
            
        }
        
        
    }
    
    
   
    

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "rideCell") as! RideCell
        
        cell.ride = rides[indexPath.row]
        
        
        return cell
    }
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return rides.count
    }
    
    // SOMETHING TO ADD
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //performSegue(withIdentifier: "rideDetSegue", sender: UITableViewCell.self)

    }
    
    func getData(distance: Double, signal: Int) {
        
        rides.removeAll()

        
        locationManager.stopUpdatingLocation()
        // construct query
        let query = PFQuery(className: "Ride")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (ride: [PFObject]?, error: Error?) -> Void in
            if let ride = ride {
                // do something with the array of object returned by the call
                
                if ride.count > 0  {
                    for i in 0...(ride.count - 1) {
                        self.rides.append(Ride.init(ride[i]))
                        
                        
                        
                        //calling from find ride
                        if signal == 1 {
                            
                            let originLocation:CLLocation = CLLocation(latitude: self.rides[i].destLat!, longitude: self.rides[i].destLon!)
                            
                            print ("origin lat is \(self.rides[i].originLat!)")
                            
                            print ("origin lon is \(self.rides[i].originLon!)")
                            
                            print ("from Find origin lat is \(String(describing: self.originLoc?.coordinate.latitude))")
                            
                            print ("from Find origin lon is \(String(describing: self.originLoc?.coordinate.longitude))")
                            
                            
                            print ("dest lat is \(self.rides[i].destLat!)")
                            
                            print ("dest lat is \(self.rides[i].destLon!)")
                            
                            print ("from Find dest lat is \(String(describing: self.destLoc?.coordinate.latitude))")
                            
                            print ("from Find dest lon is \(String(describing: self.destLoc?.coordinate.longitude))")

                            
                            
                            self.dist1 = self.calDistance(locOrigin: originLocation, locDest: self.originLoc!)
                            
                            
                            let destLocation:CLLocation = CLLocation(latitude: self.rides[i].originLat!, longitude: self.rides[i].originLon!)
                            
                            self.dist2 = self.calDistance(locOrigin: destLocation, locDest: self.destLoc!)
                            
                            print ("dist2 is \(self.dist2)")
                            print ("dist1 is \(self.dist1)")
                            
                            print ("the radius is \(self.rides[i].radius!)")
                            
                            if self.dist2 > self.rides[i].radius! || self.dist1 > self.rides[i].radius! {
                                
                                self.rides.remove(at: i)
                                
                            }
                        }
                        
                    }
                    
                    
                    
                    
                } else {
                    
                    
                    let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
                    noDataLabel.text          = "No Upcoming Ride"
                    noDataLabel.textColor     = UIColor.black
                    noDataLabel.font = UIFont(name: "Noteworthy", size: 25)
                    noDataLabel.textAlignment = .center
                    self.tableView.backgroundView  = noDataLabel
                    self.tableView.separatorStyle  = .none
                    
                }
                
                
                
                self.tableView.reloadData()
                // self.instaPosts = posts
                
                
            } else {
                print(error!)
            }
        }
        
    }
    
    func calDistance(locOrigin: CLLocation, locDest: CLLocation) -> Double {
        
        let distanceInMeters = locOrigin.distance(from: locDest)
        
        //print("inside calDistance)")
        
        let miles = ((Double)(distanceInMeters)) / 1609.0
        
        
        
        return miles
        
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "rideDetSegue" {
            let rideCell = sender as! RideCell
            let rideDeets = segue.destination as! RideDetailsVC
            rideDeets.curr = rideCell.ride
            rideDeets.origCoordinates = rideCell.origCoordinates
            rideDeets.destCoordinates = rideCell.destCoordinates
            
            rideDeets.ogName = rideCell.fromText.text
            rideDeets.destName = rideCell.toText.text
            
            
        }
    }
    
    
}




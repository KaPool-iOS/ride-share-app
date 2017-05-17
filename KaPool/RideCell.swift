//
//  RideCellTableViewCell.swift
//  KaPool
//
//  Created by Jake Vo on 4/17/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class RideCell: UITableViewCell {

    
    
    
    @IBOutlet var fromText: UILabel!
    @IBOutlet var toText: UILabel!
    @IBOutlet var dateText: UILabel!
    @IBOutlet var timeText: UILabel!
    @IBOutlet var priceText: UILabel!
    @IBOutlet var seatAvalText: UILabel!
    
  
    var ride: Ride! {
        
        didSet {
            
            
            getPlace(ride.originID, check: 1)
            getPlace(ride.destinationID,check: 0)
            dateText.text = (String) (describing: ride.departDate!)
            print("depart date is\(String(describing: ride.departDate!))")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func getDate() {
        
        
    }
    
    func getTime() {
        
        
        
    }
    func getPlace(_ placeID: String?, check: Int){
        
        let placesClient = GMSPlacesClient()
        //var thisPlace: GMSPlace?
        
        placesClient.lookUpPlaceID(placeID!, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else {
                print("No place details for \(String(describing: placeID))")
                return
            }
            
            print("Place name \(place.name)")
            print("Place address \(String(describing: place.formattedAddress))")
            print("Place placeID \(place.placeID)")
            print("Place attributions \(String(describing: place.attributions))")
            
            if check == 1 {
                
                self.fromText.text = (String) (describing: place.name)
            } else {
                self.toText.text = (String) (describing: place.name)
            }
            
        })
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

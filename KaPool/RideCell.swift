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

extension Date
{
    func toString(dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}

class RideCell: UITableViewCell {

    
    
    
    @IBOutlet var fromText: UILabel!
    @IBOutlet var toText: UILabel!
    @IBOutlet var dateText: UILabel!
    @IBOutlet var priceText: UILabel!
    @IBOutlet var seatNumText: UILabel!
    
    var destCoordinates: CLLocationCoordinate2D!
    var origCoordinates: CLLocationCoordinate2D!
    
  
    var ride: Ride! {
        
        didSet {
            
            
            getPlace(ride.originID, check: 1)
            getPlace(ride.destinationID,check: 0)
            priceText.text = (String) (describing: ride.price!).components(separatedBy: ".0")[0]
            dateText.text = ride.departDate?.toString(dateFormat: "MM/dd")
            seatNumText.text = (String) (describing: ride.seats!)
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
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
            
            print("Place name: \(place.name)")
            print("Place address \(String(describing: place.formattedAddress!))")
            print("Place placeID \(place.placeID)")
            print("Place attributions \(String(describing: place.attributions))")
            
            if check == 1 {
                
                self.fromText.text = (String) (describing: place.name)
                self.origCoordinates = place.coordinate
            } else {
                self.toText.text = (String) (describing: place.name)
                  self.destCoordinates = place.coordinate
            }
            
        })
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

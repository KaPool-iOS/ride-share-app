//
//  NotifCell.swift
//  KaPool
//
//  Created by Madel Asistio on 5/22/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class NotifCell: UITableViewCell {
    var testID: String?

    @IBOutlet weak var fromLabel: UILabel!
    var ride: Ride!
    
    var riderName: String!
    var destName: String!
    var departDate: Date!
    
    var trip: Trip! {
        didSet {
            
            //get user
            User.getUser(userid: (trip?.riderID)!) { (rider: User) in
                self.riderName = rider.username!
                
                // get ride
                Ride.getRideWithId(rideId: self.trip.rideID!) { (ride: Ride) in
                    self.ride = ride
                    self.riderName = ride.destName!
                    self.departDate = ride.departDate!
                    
                     self.fromLabel.text = "\(rider.username!) would like to accept your ride to \(self.ride.destName) at \(self.ride.departDate)"
                }
               
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        /*
        print(trip?.riderID!)
        User.getUser(userid: (trip?.riderID)!) { (rider: User) in
            self.fromLabel.text = rider.username
            
        } */
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

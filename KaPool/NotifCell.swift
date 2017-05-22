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
    
    var trip: Trip! {
        didSet {
            
            // get ride
            Ride.getRideWithId(rideId: trip.rideID!) { (ride: Ride) in
                self.ride = ride
            }
            
            //get user
            User.getUser(userid: (trip?.riderID)!) { (rider: User) in
                self.fromLabel.text = "\(rider.username!) would like to accept your ride to \(self.ride.destName) at \(self.ride.departDate)"
                
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

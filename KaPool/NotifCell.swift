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
                    
                    let dateStr = self.departDate.toString(dateFormat: "MM/dd h:mm a")
                    
                    var txtStr: String? = ""
                    print (self.trip.response)
                    if self.trip.response == 0 {
                        txtStr = "\(rider.username!) is a requesting a ride to \(self.ride.destName!) on \(dateStr)"
                    } else if self.trip.response == -1 {
                        txtStr = "You have declined \(rider.username!) for a ride to \(self.ride.destName!) on \(dateStr)"
                    } else if self.trip.response == 1 {
                        txtStr = "You have accepted \(rider.username!) for a ride to \(self.ride.destName!) on \(dateStr)"
                    }
                    
                    self.fromLabel.text = txtStr
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

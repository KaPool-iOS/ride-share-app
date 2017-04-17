//
//  RideCellTableViewCell.swift
//  KaPool
//
//  Created by Jake Vo on 4/17/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.
//

import UIKit

class RideCell: UITableViewCell {

    
    
    @IBOutlet var driverPic: UIImageView!
    @IBOutlet var fromText: UILabel!
    @IBOutlet var toText: UILabel!
    @IBOutlet var dateText: UILabel!
    @IBOutlet var timeText: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

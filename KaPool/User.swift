//
//  User.swift
//  KaPool
//
//  Created by Madel Asistio on 5/12/17.
//  Copyright © 2017 Madel Asistio. All rights reserved.


import UIKit
import Parse

class User: NSObject {
    
    var carColor: String?
    var carMake: String?
    var carModel: String?
    var userID: String?
    var emailVerified: Bool?
    var username: String?
    var phoneNum: Int?
    var email: String?
    var profilePic:UIImage?
  
    init(_ user:PFObject){
      super.init()
      //self.driver = ride?.object(forKey: "Driver") as! String
      
      self.username = user.object(forKey: "username") as? String
      self.carColor = user.object(forKey: "carColour") as? String
      self.carModel = user.object(forKey: "carModel") as? String
      self.carMake = user.object(forKey: "carMake") as? String
      self.userID = user.object(forKey: "objectID") as? String
      self.emailVerified = user.object(forKey: "emailVerified") as? Bool
      self.email = user.object(forKey: "email") as? String
      self.profilePic = user.object(forKey: "profilePic") as? UIImage
      
      
      
    
    }

  
}

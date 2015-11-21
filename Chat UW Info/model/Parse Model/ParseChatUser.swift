//
//  ParseChatUser.swift
//  Chat UW Info
//
//  Created by Zefeng Qiu on 2015-11-20.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import Foundation
import Parse
import Bolts
import UIKit


class ParseChatUser: PFObject {
  
  @NSManaged var user: PFUser
  @NSManaged var userPrivacy: Bool
  @NSManaged var userName: String
  @NSManaged var userDepartment: String
  @NSManaged var userEmail: String
  @NSManaged var infoSessionFollowed: [String]
  
  
  init(user: PFUser, userName: String, userEmail: String ,userDepartment: String) {
    super.init()
    
    self.user = user
    self.userName = userName
    self.userEmail = userEmail
    self.userDepartment = userDepartment
    
    //default init
    self.userPrivacy = true
    self.infoSessionFollowed = [String]()
  }
  
  
  override init() {
    super.init()
  }
  
  override class func query() -> PFQuery? {
    //1
    let query = PFQuery(className: ParseInfoSessionUnit.parseClassName())
    //2
    query.includeKey("user")
    //3
    query.orderByDescending("createdAt")
    return query
  }
  
}


extension ParseChatUser: PFSubclassing {
  
  class func parseClassName() -> String {
    return "ParseChatUser"
  }
  
  override class func initialize() {
    var onceToken: dispatch_once_t = 0
    dispatch_once(&onceToken) {
      self.registerSubclass()
    }
  }
  
}

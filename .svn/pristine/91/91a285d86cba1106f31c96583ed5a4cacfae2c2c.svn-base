//
//  ParseInfoSessionUnit.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-09-27.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import Foundation
import Parse
import Bolts
import UIKit

class ParseInfoSessionUnit: PFObject {
  
  @NSManaged var userName: String
  @NSManaged var oneInfoSession: String
  @NSManaged var chats: PFFile
  
  
  init(userName: String, infoSession: String, chats: PFFile) {
    super.init()
    
    self.userName = userName
    self.oneInfoSession = infoSession
    self.chats = chats
    
  }
  
  override init() {
    super.init()
  }
  
  override class func query() -> PFQuery? {
  
    let query = PFQuery(className: ParseInfoSessionUnit.parseClassName())
    
//    query.includeKey("user")

    query.orderByDescending("createdAt")
    return query
  }
  
}

extension ParseInfoSessionUnit: PFSubclassing{
  //1, Set the name of the class as seen in the backend database
  class func parseClassName() -> String {
    return "ParseInfoSessionUnit"
  }
  
  //2, Let Parse know that you intend to use this subclass for all objects with class type WallPost.
  //You want to do this only once, so you’re using dispatch_once_t to make sure of that.
  override class func initialize() {
    var onceToken: dispatch_once_t = 0
    dispatch_once(&onceToken) {
      self.registerSubclass()
    }
  }
}
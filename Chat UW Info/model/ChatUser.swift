//
//  ChatUser.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-17.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import Foundation
import Parse
import Bolts
import UIKit

class ChatUser {
  
  static var shareInstance = ChatUser()
  
	var userName = ""
	var userEmail = ""
  var userDepartment = ""
  var userPrivacy = true
  
  var userChatParseID = ""
  var userFollowedInfoSessions = [String]()
  
	var emailVerified = false
  
  
  
  class func beforeSignInInitChatUserSingleton(userName: String, userEmail: String, userDepart: String) {
    
    ChatUser.shareInstance.userName = userName
    ChatUser.shareInstance.userEmail = userEmail
    ChatUser.shareInstance.userDepartment = userDepart
  }
  
  
  func asginChater(name: String, email: String, department: String, verified: Bool, followInfoSessions: [String]) -> ChatUser {
    let chater = ChatUser()
    chater.userName = name
    chater.userEmail = email
    chater.userDepartment = department
    chater.emailVerified = verified
    chater.userFollowedInfoSessions = followInfoSessions
    
    return chater
  }
  
//  class func checkUserEmail(pfuser: PFUser) -> Bool {
//    var emailVerified = false
//    
//    pfuser.fetchInBackgroundWithBlock({ (object, error) -> Void in
//      if error != nil {
//        
//      }else {
//        pfuser.fetchIfNeededInBackgroundWithBlock({ (result, error) -> Void in
//          emailVerified = pfuser["emailVerified"] as! Bool
//        })
//      }
//    })
//    
//    return emailVerified
//  }
  
}


















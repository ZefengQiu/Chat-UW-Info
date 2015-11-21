//
//  ChatUser.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-17.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import Foundation


class ChatUser {
  
  static let shareInstance = ChatUser()
  
	var userName = ""
	var userEmail = ""
  var userDepartment = ""
  var userPrivacy = true
  
  var userIcahnParseID = ""
  var userFollowedInfoSessions = [String]()
  
	var emailVerified = false
  
  class func beforeSignInInitChatUserSingleton(userName: String, userEmail: String, userDepart: String) {
    
    ChatUser.shareInstance.userName = userName
    ChatUser.shareInstance.userEmail = userEmail
    ChatUser.shareInstance.userDepartment = userDepart
    
  }
  
}
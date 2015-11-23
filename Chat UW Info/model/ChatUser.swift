//
//  ChatUser.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-17.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import Foundation


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
  
//  class func clearSingletomUser() {
//    ChatUser.shareInstance.userName = ""
//    ChatUser.shareInstance.userEmail = ""
//    ChatUser.shareInstance.userDepartment = ""
//    ChatUser.shareInstance.userPrivacy = true
//    ChatUser.shareInstance.userFollowedInfoSessions = [String]()
//    ChatUser.shareInstance.emailVerified = false
//  }
  
}
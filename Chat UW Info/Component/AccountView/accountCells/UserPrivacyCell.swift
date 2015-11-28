//
//  UserPrivacyCell.swift
//  Chat UW Info
//
//  Created by Zefeng Qiu on 2015-11-20.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit
import Parse
import Bolts


protocol UserPrivacyCellDelegate: class {
  func changeUserPrivacyError(error: NSError)
  func succeedChangeUserPrivacy()
  func inChangingState()
}

class UserPrivacyCell: UITableViewCell {
  
  @IBOutlet weak var userPrivacyLabel: UILabel!
  @IBOutlet weak var privacySwitch: UISwitch!
  
  var chatUserName: String!
  weak var delegate: UserPrivacyCellDelegate?
  
  @IBAction func changePrivacyStatus() {
    //chang parse chat user's user privacy in database 
    self.delegate?.inChangingState()
    self.changeUserPrivacy(chatUserName)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    getChatUserPrivacyState()
    
    userPrivacyLabel.text = "Allow Others See me"
    userPrivacyLabel.textColor = UIColor.blackBlue()
    privacySwitch.onTintColor = UIColor.chatBule()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  private func changeUserPrivacy(userName: String) {
    let query = PFQuery(className: "ParseChatUser")
    query.whereKey("userName", equalTo: userName)
    
    query.getFirstObjectInBackgroundWithBlock({(object: PFObject?, error: NSError?) -> Void in
      if error != nil {
        self.delegate?.changeUserPrivacyError(error!)
      }else if let chatUserObject = object {
        if self.privacySwitch.on {
          chatUserObject["userPrivacy"] = true
        }else {
          chatUserObject["userPrivacy"] = false
        }
        chatUserObject.saveInBackgroundWithBlock({ succeeded, error in
          if succeeded {
            self.delegate?.succeedChangeUserPrivacy()
          }else if let error = error {
            self.delegate?.changeUserPrivacyError(error)
          }
        })
      }
    })
  }
  
  private func getChatUserPrivacyState() {
    let query = PFQuery(className: "ParseChatUser")
    query.whereKey("userName", equalTo: ChatUser.shareInstance.userName)
    
    query.getFirstObjectInBackgroundWithBlock({ (object: PFObject?, error: NSError?) -> Void in
      if error != nil {
        self.delegate?.changeUserPrivacyError(error!)
      }else if let chatUserObject = object {
        let state = chatUserObject["userPrivacy"] as! Bool
        self.privacySwitch.setOn(state, animated: true)
      }
    })
  }
  
}


extension UserPrivacyCell: TableViewInfo {
  
  class func identifier() -> String {
    return NSStringFromClass(UserPrivacyCell.self)
  }
  
  class func estimatedRowHeight() -> CGFloat {
    return 44
  }
  
  class func registerInTableView(tableView: UITableView) {
    let cellnib = UINib(nibName: "UserPrivacyCell", bundle: NSBundle(forClass: UserPrivacyCell.self))
    tableView.registerNib(cellnib, forCellReuseIdentifier: UserPrivacyCell.identifier())
  }
}
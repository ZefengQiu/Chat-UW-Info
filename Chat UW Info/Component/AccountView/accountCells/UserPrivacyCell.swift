//
//  UserPrivacyCell.swift
//  Chat UW Info
//
//  Created by Zefeng Qiu on 2015-11-20.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class UserPrivacyCell: UITableViewCell {
  
  @IBOutlet weak var userPrivacyLabel: UILabel!
  @IBOutlet weak var privacySwitch: UISwitch!
  
  @IBAction func changePrivacyStatus() {
    if !privacySwitch.on {
      print("others cannot see my account information")
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    userPrivacyLabel.text = "Allow Others See me"
    userPrivacyLabel.textColor = UIColor.chatBule()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
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
//
//  ChatInfoCell.swift
//  Char UW Info
//
//  Created by Qiu Zefeng on 2015-09-24.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class AudienceInfoCell: UITableViewCell {
  
  @IBOutlet weak var audienceLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}

extension AudienceInfoCell: TableViewInfo {
  class func identifier() -> String {
    return NSStringFromClass(AudienceInfoCell.self)
  }
  
  class func estimatedRowHeight() -> CGFloat {
    return 88
  }
  
  class func registerInTableView(tableView: UITableView) {
    let cellnib = UINib(nibName: "AudienceInfoCell", bundle: NSBundle(forClass: AudienceInfoCell.self))
    tableView.registerNib(cellnib, forCellReuseIdentifier: AudienceInfoCell.identifier())
  }
}

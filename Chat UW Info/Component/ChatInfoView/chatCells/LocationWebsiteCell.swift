//
//  WebsiteCell.swift
//  Char UW Info
//
//  Created by Qiu Zefeng on 2015-09-24.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class LocationWebsiteCell: UITableViewCell {
  
	@IBOutlet weak var locationWebsiteLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}


extension LocationWebsiteCell: TableViewInfo {
  class func identifier() -> String {
    return NSStringFromClass(LocationWebsiteCell.self)
  }
  
  class func estimatedRowHeight() -> CGFloat {
    return 44
  }
  
  class func registerInTableView(tableView: UITableView) {
    let cellnib = UINib(nibName: "LocationWebsiteCell", bundle: NSBundle(forClass: LocationWebsiteCell.self))
    tableView.registerNib(cellnib, forCellReuseIdentifier: LocationWebsiteCell.identifier())
  }
}
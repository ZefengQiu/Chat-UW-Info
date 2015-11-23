//
//  LoadingCell.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-09-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    activityIndicator.startAnimating()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}


extension LoadingCell: TableViewInfo {
  class func identifier() -> String {
    return NSStringFromClass(LoadingCell.self)
  }
  
  class func estimatedRowHeight() -> CGFloat {
    return 100
  }
  
  class func registerInTableView(tableView: UITableView) {
    let cellNib = UINib(nibName: "LoadingCell", bundle: NSBundle(forClass: LoadingCell.self))
    tableView.registerNib(cellNib, forCellReuseIdentifier: LoadingCell.identifier())
  }
}
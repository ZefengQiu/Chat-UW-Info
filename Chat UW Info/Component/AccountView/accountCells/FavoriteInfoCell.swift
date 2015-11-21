//
//  FavoriteInfoCell.swift
//  Chat UW Info
//
//  Created by Zefeng Qiu on 2015-11-20.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class FavoriteInfoCell: UITableViewCell {
  
  @IBOutlet weak var favoriteInfoLabel: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}

extension FavoriteInfoCell: TableViewInfo {
  
  class func identifier() -> String {
    return NSStringFromClass(FavoriteInfoCell.self)
  }
  
  class func estimatedRowHeight() -> CGFloat {
    return 44
  }
  
  class func registerInTableView(tableView: UITableView) {
    let cellnib = UINib(nibName: "FavoriteInfoCell", bundle: NSBundle(forClass: FavoriteInfoCell.self))
    tableView.registerNib(cellnib, forCellReuseIdentifier: FavoriteInfoCell.identifier())
  }
  
}

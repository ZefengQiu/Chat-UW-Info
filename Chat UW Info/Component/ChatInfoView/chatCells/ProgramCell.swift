//
//  ProgramCell.swift
//  Char UW Info
//
//  Created by Qiu Zefeng on 2015-09-24.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class ProgramCell: UITableViewCell {
  
  @IBOutlet weak var programLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}


extension ProgramCell: TableViewInfo {
  class func identifier() -> String {
    return NSStringFromClass(ProgramCell.self)
  }
  
  class func estimatedRowHeight() -> CGFloat {
    return 88
  }
  
  class func registerInTableView(tableView: UITableView) {
    let cellnib = UINib(nibName: "ProgramCell", bundle: NSBundle(forClass: ProgramCell.self))
    tableView.registerNib(cellnib, forCellReuseIdentifier: ProgramCell.identifier())
  }
}
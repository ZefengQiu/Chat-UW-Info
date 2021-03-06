//
//  SofaCell.swift
//  Chat UW Info
//
//  Created by Zefeng Qiu on 2015-11-21.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class SofaCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension SofaCell: TableViewInfo {
  
  class func identifier() -> String {
    return NSStringFromClass(SofaCell.self)
  }
  
  class func estimatedRowHeight() -> CGFloat {
    return 60
  }
  
  class func registerInTableView(tableView: UITableView) {
    let cellnib = UINib(nibName: "SofaCell", bundle: NSBundle(forClass: SofaCell.self))
    tableView.registerNib(cellnib, forCellReuseIdentifier: SofaCell.identifier())
  }
}
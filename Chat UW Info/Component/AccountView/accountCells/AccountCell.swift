//
//  AccountCell.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-15.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {
  
  @IBOutlet weak var keyLabel: UILabel!
  @IBOutlet weak var valueLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
	
	func configureCell(key: String, value: String) {
		keyLabel.text = key
		valueLabel.text = value
	}
	
}


extension AccountCell: TableViewInfo {
  
	class func identifier() -> String {
		return NSStringFromClass(AccountCell.self)
	}
	
	class func estimatedRowHeight() -> CGFloat {
		return 44
	}
	
	class func registerInTableView(tableView: UITableView) {
		let cellNib = UINib(nibName: "AccountCell", bundle: NSBundle(forClass: AccountCell.self))
		tableView.registerNib(cellNib, forCellReuseIdentifier: AccountCell.identifier())
	}
  
}
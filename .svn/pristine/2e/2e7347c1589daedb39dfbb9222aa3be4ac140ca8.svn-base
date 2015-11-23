//
//  HeaderCell.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-28.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
	
	@IBOutlet weak var headerLabel: UILabel!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}


extension HeaderCell: TableViewInfo {
	class func identifier() -> String {
		return NSStringFromClass(HeaderCell.self)
	}
	
	class func estimatedRowHeight() -> CGFloat {
		return 30
	}
	
	class func registerInTableView(tableView: UITableView) {
		let cellnib = UINib(nibName: "HeaderCell", bundle: NSBundle(forClass: HeaderCell.self))
		tableView.registerNib(cellnib, forCellReuseIdentifier: HeaderCell.identifier())
	}
}
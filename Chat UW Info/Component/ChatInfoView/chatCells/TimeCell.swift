//
//  TimeCell.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-27.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class TimeCell: UITableViewCell {
	
	@IBOutlet weak var timeLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}


extension TimeCell: TableViewInfo {
	class func identifier() -> String {
		return NSStringFromClass(TimeCell.self)
	}
	
	class func estimatedRowHeight() -> CGFloat {
		return 44
	}
	
	class func registerInTableView(tableView: UITableView) {
		let cellnib = UINib(nibName: "TimeCell", bundle: NSBundle(forClass: TimeCell.self))
		tableView.registerNib(cellnib, forCellReuseIdentifier: TimeCell.identifier())
	}
}
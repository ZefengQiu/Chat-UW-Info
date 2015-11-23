//
//  SettingCell.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-16.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

	@IBOutlet weak var settingLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	@IBAction func settingFunc() {
		
	}
	
	func configureSettingButton(title: String, titleColor: UIColor) {
		settingLabel.text = title
		settingLabel.textColor = titleColor
	}
}


extension SettingCell: TableViewInfo {
	class func identifier() -> String {
		return NSStringFromClass(SettingCell.self)
	}
	
	class func estimatedRowHeight() -> CGFloat {
		return 50
	}
	
	class func registerInTableView(tableView: UITableView) {
		let cellNib = UINib(nibName: "SettingCell", bundle: NSBundle(forClass: SettingCell.self))
		tableView.registerNib(cellNib, forCellReuseIdentifier: SettingCell.identifier())
	}
}
//
//  AddChatsCell.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-27.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class AddChatsCell: UITableViewCell {
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}


extension AddChatsCell: TableViewInfo {
	class func identifier() -> String {
		return NSStringFromClass(AddChatsCell.self)
	}
	
	class func estimatedRowHeight() -> CGFloat {
		return 44
	}
	
	class func registerInTableView(tableView: UITableView) {
		let cellnib = UINib(nibName: "AddChatsCell", bundle: NSBundle(forClass: AddChatsCell.self))
		tableView.registerNib(cellnib, forCellReuseIdentifier: AddChatsCell.identifier())
	}
}
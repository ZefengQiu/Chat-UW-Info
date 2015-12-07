//
//  LoadingAccountCell.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-16.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class LoadingAccountCell: UITableViewCell {
	
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}


extension LoadingAccountCell: TableViewInfo {
	class func identifier() -> String {
		return NSStringFromClass(LoadingAccountCell.self)
	}
	
	class func estimatedRowHeight() -> CGFloat {
		return 60
	}
	
	class func registerInTableView(tableView: UITableView) {
		let cellNib = UINib(nibName: "LoadingAccountCell", bundle: NSBundle(forClass: LoadingAccountCell.self))
		tableView.registerNib(cellNib, forCellReuseIdentifier: LoadingAccountCell.identifier())
	}
}
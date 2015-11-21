//
//  SearchCell.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-18.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
	
	@IBOutlet weak var employerNameLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	func configureCell(employerName: String) {
		employerNameLabel.text = employerName
	}
	
}

extension SearchCell: TableViewInfo {
	class func identifier() -> String {
		return NSStringFromClass(SearchCell.self)
	}
	
	class func estimatedRowHeight() -> CGFloat {
		return 55
	}
	
	class func registerInTableView(tableView: UITableView) {
		let cellNib = UINib(nibName: "SearchCell", bundle: NSBundle(forClass: SearchCell.self))
		tableView.registerNib(cellNib, forCellReuseIdentifier: SearchCell.identifier())
	}
}

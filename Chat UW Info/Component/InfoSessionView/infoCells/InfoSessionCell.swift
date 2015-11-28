//
//  InfoSessionCell.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-09-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class InfoSessionCell: UITableViewCell {
  
  @IBOutlet weak var employerLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var date_timeLabel: UILabel!
  
//  @IBOutlet weak var chatNumberLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
	func configureCellForInfoSession(InfoSession: InfoSessionUnit, grayInfoSession: Bool) {
		if grayInfoSession {
			employerLabel.textColor = UIColor.lightGrayColor()
			locationLabel.textColor = UIColor.lightGrayColor()
			date_timeLabel.textColor = UIColor.lightGrayColor()
		}else {
			employerLabel.textColor = UIColor.blackColor()
			locationLabel.textColor = UIColor.blackColor()
			date_timeLabel.textColor = UIColor.blackColor()
		}
    employerLabel.text = InfoSession.employer
    locationLabel.text = InfoSession.location
    date_timeLabel.text = "\(InfoSession.date)  \(InfoSession.time)"
  }
	
	
  
}

extension InfoSessionCell: TableViewInfo {
  class func identifier() -> String {
    return NSStringFromClass(InfoSessionCell.self)
  }
  
  class func estimatedRowHeight() -> CGFloat {
    return 100
  }
  
  class func registerInTableView(tableView: UITableView) {
    let cellnib = UINib(nibName: "InfoSessionCell", bundle: NSBundle(forClass: InfoSessionCell.self))
    tableView.registerNib(cellnib, forCellReuseIdentifier: InfoSessionCell.identifier())
  }
}

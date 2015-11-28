//
//  HeaderViewCell.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-15.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class HeaderViewCell: UITableViewCell {
  
  @IBOutlet weak var headerLabel: UILabel!
  @IBOutlet weak var headerImage: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
	
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configureHeader(headerName: String, image: String) {
    headerLabel.text = headerName
    headerImage.image = UIImage(named: image)
  }
  
}


extension HeaderViewCell: TableViewInfo {
	class func identifier() -> String {
		return NSStringFromClass(HeaderViewCell.self)
	}
	
	class func estimatedRowHeight() -> CGFloat {
		return 50
	}
	
	class func registerInTableView(tableView: UITableView) {
		let cellNib = UINib(nibName: "HeaderViewCell", bundle: NSBundle(forClass: HeaderViewCell.self))
		tableView.registerNib(cellNib, forCellReuseIdentifier: HeaderViewCell.identifier())
	}
}
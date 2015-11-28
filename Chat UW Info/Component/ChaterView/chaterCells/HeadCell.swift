//
//  HeaderCell.swift
//  Chat UW Info
//
//  Created by Zefeng Qiu on 2015-11-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class HeadCell: UITableViewCell {
  
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


extension HeadCell: TableViewInfo {
  class func identifier() -> String {
    return NSStringFromClass(HeadCell.self)
  }
  
  class func estimatedRowHeight() -> CGFloat {
    return 50
  }
  
  class func registerInTableView(tableView: UITableView) {
    let cellNib = UINib(nibName: "HeadCell", bundle: NSBundle(forClass: HeadCell.self))
    tableView.registerNib(cellNib, forCellReuseIdentifier: HeadCell.identifier())
  }
}
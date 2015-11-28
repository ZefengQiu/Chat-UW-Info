//
//  ChatsCell.swift
//  Char UW Info
//
//  Created by Qiu Zefeng on 2015-09-24.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

protocol ChatsCellDelegate: class {
  func inspectChater(chaterName: String)
}

class ChatsCell: UITableViewCell {
  
  @IBOutlet weak var personName: UIButton!
  
	@IBOutlet weak var chatTimeLabel: UILabel!
	
  @IBOutlet weak var chatContentLabel: UILabel!
  
  var chater: String!
  weak var delegate: ChatsCellDelegate?
  
  @IBAction func goToChaterView() {
    if chater != ChatUser.shareInstance.userName {
      delegate?.inspectChater(chater)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}

extension ChatsCell: TableViewInfo {
  class func identifier() -> String {
    return NSStringFromClass(ChatsCell.self)
  }
  
  class func estimatedRowHeight() -> CGFloat {
    return 88
  }
  
  class func registerInTableView(tableView: UITableView) {
    let cellnib = UINib(nibName: "ChatsCell", bundle: NSBundle(forClass: ChatsCell.self))
    tableView.registerNib(cellnib, forCellReuseIdentifier: ChatsCell.identifier())
  }
}
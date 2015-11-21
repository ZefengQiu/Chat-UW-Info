//
//  ExTableVc.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-01.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

extension UITableView {
  
  //refresh certain row in the table view
  
  func refreshTableSection(section: Int, numberOfRow: Int) {
    for var i = 0; i < numberOfRow; ++i {
      let indexPath = NSIndexPath(forRow: i, inSection: section)
      self.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
    }
  }
  
  //insert new row at certain section
  
  func insertRowsInSection(section: Int, numberOfRow: Int) {
    let indexPath = NSIndexPath(forRow: numberOfRow, inSection: section)
    self.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
  }
  
  func reloadCertainSection(section: Int) {
    let reSection = NSIndexSet(index: section)
    self.reloadSections(reSection, withRowAnimation: UITableViewRowAnimation.Top)
  }
  
}
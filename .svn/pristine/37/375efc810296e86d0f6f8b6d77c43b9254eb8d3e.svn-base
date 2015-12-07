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
  
  //add animate when loading the table view cell 
  
  func animateLoadingTableView() {
    self.reloadData()
    
    let cells = self.visibleCells
    let tableHeight: CGFloat = self.bounds.size.height
    
    for i in cells {
      let cell: UITableViewCell = i as UITableViewCell
      cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
    }
    
    var index = 0
    
    for a in cells {
      let cell: UITableViewCell = a as UITableViewCell
      UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
        cell.transform = CGAffineTransformMakeTranslation(0, 0);
        }, completion: nil)
      
      index += 1
    }
  }
  
}
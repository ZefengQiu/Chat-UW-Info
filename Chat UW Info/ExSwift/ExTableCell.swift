//
//  ExTableCell.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-01.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit


extension UITableViewCell {
  /// Search up the view hierarchy of the table view cell to find the containing table view
  var tableView: UITableView? {
    get {
      var table: UIView? = superview
      while !(table is UITableView) && table != nil {
        table = table?.superview
      }
      return table as? UITableView
    }
  }
}
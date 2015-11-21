//
//  TableViewInfo.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-09-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

protocol TableViewInfo {
  static func identifier() -> String
  static func estimatedRowHeight() -> CGFloat
  static func registerInTableView(tableView: UITableView)
}
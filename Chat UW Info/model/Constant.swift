//
//  Constant.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-09-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import Foundation
import UIKit

enum Month: String {
  case Jan = "Jan"
  case Feb = "Feb"
  case Mar = "Mar"
  case Apr = "Apr"
  case May = "May"
  case Jun = "Jun"
  case Jul = "Jul"
  case Aug = "Aug"
  case Sep = "Sep"
  case Oct = "Oct"
  case Nov = "Nov"
  case Dec = "Dec"
}


enum Term: String {
	case Spring = "Spring"
	case Summer = "Summer"
	case Fall = "Fall"
}


var verification = false


extension UIColor {
	class func chatBule() -> UIColor {
		return UIColor(red: 0.4157, green: 0.8, blue: 0.9804, alpha: 0.9)
	}
  
  class func blackBlue() -> UIColor {
    return UIColor(red: 0.0, green: 0.0, blue: 0.2, alpha: 1.0)
  }
  
  class func semiClearGray(aplha degree: CGFloat) -> UIColor {
    return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: degree)
  }
}
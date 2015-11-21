//
//  InfoSessionUnit.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-09-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import Foundation


struct InfoSessionUnit {
  
  var employer: String = ""
  var date: String = ""
  var time: String = ""
  var location: String = ""
  var website: String = ""
  var audience: String = ""
  var program: String = ""
	var longDate: String = ""
	
	static func changeDateFormat(dateStr: String) -> String {
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "MMMM d, yyyy"
		let date = dateFormatter.dateFromString(dateStr)
		dateFormatter.dateFormat = "MMM d, EEE"
		return dateFormatter.stringFromDate(date!)
	}
	
	static func changeToNSDate(dateFormat: String, dateStr: String) -> NSDate {
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = dateFormat
		return dateFormatter.dateFromString(dateStr)!
	}
  
}
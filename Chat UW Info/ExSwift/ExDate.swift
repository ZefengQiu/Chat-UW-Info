//
//  ExDate.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-27.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import Foundation


extension NSDate {
	
	func isGreater(dateToCompare : NSDate) -> Bool
	{
		//Declare Variables
		var isGreater = false
		
		//Compare Values
		if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
		{
			isGreater = true
		}
		
		//Return Result
		return isGreater
	}
	
	
	func isLess(dateToCompare : NSDate) -> Bool
	{
		//Declare Variables
		var isLess = false
		
		//Compare Values
		if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
		{
			isLess = true
		}
		
		//Return Result
		return isLess
	}
	
	class func getTodayStr(format: String) -> String {
		let date = NSDate()
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = format
		return dateFormatter.stringFromDate(date)
	}
	
}
//
//  ExArray.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import Foundation


extension Array {
	
	/**
	Creates a dictionary composed of keys generated from the results of
	running each element of self through groupingFunction. The corresponding
	value of each key is an array of the elements responsible for generating the key.
	
	- parameter groupingFunction:
	- returns: Grouped dictionary
	*/
	
	func groupBy <U> (groupingFunction group: (Element) -> U) -> [U: Array] {
		
		var result = [U: Array]()
		
		for item in self {
			
			let groupKey = group(item)
			
			// If element has already been added to dictionary, append to it. If not, create one.
			if result.has(groupKey) {
				result[groupKey]! += [item]
			} else {
				result[groupKey] = [item]
			}
		}
		
		return result
	}

}
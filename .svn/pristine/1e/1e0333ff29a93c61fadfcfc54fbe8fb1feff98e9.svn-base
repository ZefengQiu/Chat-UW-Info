//
//  CommendToParse.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-27.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import Foundation


class CommendToParse: NSObject, NSCoding{
	var user: String
	var commend: String
	var createDate: NSDate
	
	init(user: String, commend: String, createDate: NSDate) {
		self.user = user
		self.commend = commend
		self.createDate = createDate
	}
	
	//MARK: NSCoding
	
	required convenience init?(coder decoder: NSCoder) {
		guard let user = decoder.decodeObjectForKey("user") as? String,
					let commend = decoder.decodeObjectForKey("commend") as? String
			else {return nil}
		
		self.init(
			user: user,
			commend: commend,
			createDate: decoder.decodeObjectForKey("createDate") as! NSDate
		)
	}
	
	func encodeWithCoder(coder: NSCoder) {
		coder.encodeObject(self.user, forKey: "user")
		coder.encodeObject(self.commend, forKey: "commend")
		coder.encodeObject(self.createDate, forKey: "createDate")
	}
}
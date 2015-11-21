//
//  ChatUserTest.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-11-01.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import XCTest
@testable import Chat_UW_Info

class ParseUserTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	func testUserEmailVerified() {
		let builtInUser = ChatUser()
		
		XCTAssertFalse(builtInUser.emailVerified, "build in default user's email in false")
	}
	
	
	//test user commend locally 
	
	func testUserCommendDecoder() {
		
		let path = NSTemporaryDirectory() as NSString
		let localToSave = path.stringByAppendingPathComponent("testTasks")
		
		let testDate = NSDate()
		let newTask = CommendToParse(user: "Tom", commend: "test Tom can saving method -- NSCoder Class", createDate: testDate)
		
		//saving
		NSKeyedArchiver.archiveRootObject([newTask], toFile: localToSave)
		
		//loading
		let data = NSKeyedUnarchiver.unarchiveObjectWithFile(localToSave) as? [CommendToParse]
		
		XCTAssertNotNil(data)
		XCTAssertEqual(data!.count, 1)
		XCTAssertEqual(data!.first?.user, "Tom")
		XCTAssertEqual(data!.first?.commend, "test Tom can saving method -- NSCoder Class")
		XCTAssertEqual(data!.first?.createDate, testDate)
	}
	
		
}

//
//  ChatUWInfoDataUnitTest.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-11-01.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import XCTest
@testable import Chat_UW_Info

class ChatUWInfoDataUnitTest: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	
	func testUWBuildingRetrievingFromPlist() {
		let buidlingSpotReadPlist = BuildingSpot.loadAllBuildingSpots()
		
		XCTAssertEqual(buidlingSpotReadPlist.count, 179)
		
		for building in buidlingSpotReadPlist {
			XCTAssertNotNil(building.coordinate)
		}
	}
	
}

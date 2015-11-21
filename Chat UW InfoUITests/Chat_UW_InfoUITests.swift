//
//  Chat_UW_InfoUITests.swift
//  Chat UW InfoUITests
//
//  Created by Qiu Zefeng on 2015-09-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import XCTest

class Chat_UW_InfoUITests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		
		// Put setup code here. This method is called before the invocation of each test method in the class.
		
		// In UI tests it is usually best to stop immediately when a failure occurs.
		continueAfterFailure = false
		// UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
		XCUIApplication().launch()
		
		// In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testLoginToParse() {
		
		let app = XCUIApplication()
		let userTextField = app.textFields["User"]
		userTextField.tap()
		userTextField.typeText("Will")
		
		let passwordSecureTextField = app.secureTextFields["password"]
		passwordSecureTextField.tap()
		passwordSecureTextField.tap()
		passwordSecureTextField.typeText("lswearder")
		app.buttons["Log In"].tap()
		
		let tablesQuery = app.tables
		tablesQuery.staticTexts["Nov 4, Wed  7:30 PM - 9:30 PM"].swipeUp()
		// Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
		app.navigationBars["Will"].buttons["Nov 1"].tap()
		
		let tabBarsQuery = app.tabBars
		let accountButton = tabBarsQuery.buttons["Account"]
		accountButton.tap()
		tabBarsQuery.buttons["Search"].tap()
		tabBarsQuery.buttons["UW Map"].tap()
		tabBarsQuery.buttons["InfoSessions"].tap()
		accountButton.tap()
		tablesQuery.staticTexts["account log out"].tap()
		
	}
	
	func testInfoCell() {
		
		let app = XCUIApplication()
		let userTextField = app.textFields["User"]
		userTextField.tap()
		userTextField.typeText("Test")
		
		let passwordSecureTextField = app.secureTextFields["password"]
		passwordSecureTextField.tap()
		passwordSecureTextField.tap()
		passwordSecureTextField.typeText("lswearder")
		app.buttons["Log In"].tap()
		app.alerts["UW Email Verification"].collectionViews.buttons["OKAY"].tap()
		
		let tabBarsQuery = app.tabBars
		let accountButton = tabBarsQuery.buttons["Account"]
		accountButton.tap()
		tabBarsQuery.buttons["InfoSessions"].tap()
		
		let tablesQuery2 = app.tables
		tablesQuery2.cells.containingType(.StaticText, identifier:"Scotiabank").staticTexts["DC 1302"].tap()
		
		let tablesQuery = tablesQuery2
		tablesQuery.staticTexts["DC 1302"].tap()
		app.navigationBars["DC"].buttons["Scotiabank"].tap()
		tablesQuery.staticTexts["http://www.scotiabank.com/campus"].tap()
		app.buttons["Done"].tap()
		app.navigationBars["Scotiabank"].buttons["back"].tap()
		accountButton.tap()
		tablesQuery.staticTexts["account log out"].tap()
		
	}
	
	func testMap() {
		
		let app = XCUIApplication()
		let userTextField = app.textFields["User"]
		userTextField.tap()
		userTextField.typeText("Will")
		
		let passwordSecureTextField = app.secureTextFields["password"]
		passwordSecureTextField.tap()
		passwordSecureTextField.tap()
		passwordSecureTextField.typeText("lswaader")
		
		let logInButton = app.buttons["Log In"]
		logInButton.tap()
		logInButton.tap()
		app.alerts["Error"].collectionViews.buttons["Ok"].tap()
		passwordSecureTextField.typeText("lswearder")
		logInButton.tap()
		
		let tabBarsQuery = app.tabBars
		tabBarsQuery.buttons["UW Map"].tap()
		
		let uwBuildingsCatalogNavigationBar = app.navigationBars["UW Buildings Catalog"]
		let searchButton = uwBuildingsCatalogNavigationBar.buttons["Search"]
		searchButton.tap()
		
		let tablesQuery2 = app.tables
		let tablesQuery = tablesQuery2
		tablesQuery.staticTexts["Biology 1"].tap()
		
		let element = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
		element.tap()
		element.tap()
		searchButton.tap()
		
		let searchInThisAwesomeBarSearchField = tablesQuery2.searchFields["Search in this awesome bar..."]
		searchInThisAwesomeBarSearchField.tap()
		searchInThisAwesomeBarSearchField.typeText("will")
		tablesQuery.staticTexts["William G. Davis Computer Research Centre"].tap()
		element.tap()
		uwBuildingsCatalogNavigationBar.buttons["clear"].tap()
		tabBarsQuery.buttons["Account"].tap()
		tablesQuery.staticTexts["account log out"].tap()
		
	}
}

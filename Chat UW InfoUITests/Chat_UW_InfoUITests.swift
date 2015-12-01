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
    passwordSecureTextField.typeText("lswearddd")
    
    let logInButton = app.buttons["Log In"]
    logInButton.tap()
    app.alerts["Error"].collectionViews.buttons["Ok"].tap()
    passwordSecureTextField.typeText("lswearder")
    logInButton.tap()
    app.tabBars.buttons["Account"].tap()
    app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.tap()
    app.tables.staticTexts["account log out"].tap()
    
    
	}
	
	func testInfoCell() {
		
    
    let app = XCUIApplication()
    let userTextField = app.textFields["User"]
    userTextField.tap()
    userTextField.typeText("Will")
    
    let passwordSecureTextField = app.secureTextFields["password"]
    passwordSecureTextField.tap()
    passwordSecureTextField.typeText("lswearder")
    app.buttons["Log In"].tap()
    
    let tablesQuery = app.tables
    tablesQuery.cells.containingType(.StaticText, identifier:"Huawei Canada").staticTexts["TC 2218"].tap()
    app.navigationBars["Huawei Canada"].buttons["back"].tap()
    app.tabBars.buttons["Account"].tap()
    tablesQuery.staticTexts["account log out"].tap()
    
		
	}
	
	func testSearch() {
		
    
    let app = XCUIApplication()
    let userTextField = app.textFields["User"]
    userTextField.tap()
    userTextField.typeText("Test")
    
    let passwordSecureTextField = app.secureTextFields["password"]
    passwordSecureTextField.tap()
    passwordSecureTextField.typeText("lswearder")
    app.buttons["Log In"].tap()
    app.alerts["Email Verification"].collectionViews.buttons["OKAY"].tap()
    
    let tabBarsQuery = app.tabBars
    tabBarsQuery.buttons["Search"].tap()
    
    let searchInInfoSessionsSearchField = app.searchFields["Search in Info Sessions"]
    searchInInfoSessionsSearchField.tap()
    searchInInfoSessionsSearchField.typeText("apple")
    
    let tablesQuery = app.tables
    tablesQuery.staticTexts["Apple"].tap()
    app.navigationBars["Apple"].buttons["back"].tap()
    
    let cancelButton = app.buttons["Cancel"]
    cancelButton.tap()
    cancelButton.tap()
    tabBarsQuery.buttons["Account"].tap()
    tablesQuery.staticTexts["account log out"].tap()
    
		
	}
  
  
  func testMap() {
    
    let app = XCUIApplication()
    let userTextField = app.textFields["User"]
    userTextField.tap()
    userTextField.typeText("Test")
    
    let passwordSecureTextField = app.secureTextFields["password"]
    passwordSecureTextField.tap()
    passwordSecureTextField.typeText("lswearder")
    app.buttons["Log In"].tap()
    app.alerts["Email Verification"].collectionViews.buttons["OKAY"].tap()
    
    let tabBarsQuery = app.tabBars
    tabBarsQuery.buttons["UW Map"].tap()
    app.navigationBars["UW Buildings Catalog"].buttons["Search"].tap()
    
    let tablesQuery = app.tables
    tablesQuery.staticTexts["Biology 1"].tap()
    tabBarsQuery.buttons["Account"].tap()
    tablesQuery.staticTexts["account log out"].tap()
    
  }
}

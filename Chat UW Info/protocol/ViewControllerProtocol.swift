//
//  ViewControllerProtocol.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol ChatInfoSessionViewControllerDelegate: class {
	func tellNumberOfChats(controller: UIViewController, infoSessionEmployer employer: String ,numberOfChats num: Int)
}


protocol SignUpViewControllerDelegate: class {
	func signUpCancel(controller: UIViewController)
	func providingSignUpInformation(controller: UIViewController, signUpUserName userName: String, signUpPassword password: String)
}


protocol MapSearchViewControllerDelegate: class {
	func cancelSearchInMap(controller: UIViewController)
	func providingSearchResult(controller: UIViewController, searchResult result: String, buildingLocation location: CLLocationCoordinate2D)
}


protocol CommendViewControllerDelegate: class {
	func commendCancel(controller: UIViewController)
	func providingCommendFromViewController(controller: UIViewController, commendToSubmit commend: NSString)
}
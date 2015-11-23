//
//  CustomSearchController.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-21.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class CustomSearchController: UISearchController {
	
	var customSearchBar: CustomSearchBar!
	
	var customDelegate: CustomSearchControllerDelegate!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	// MARK: Initialization
	
	init(searchResultsController: UIViewController!, searchBarFrame: CGRect, searchBarFont: UIFont, searchBarTextColor: UIColor, searchBarTintColor: UIColor) {
		super.init(searchResultsController: searchResultsController)
		
		configureSearchBar(searchBarFrame, font: searchBarFont, textColor: searchBarTextColor, bgColor: searchBarTintColor)
	}
	
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	
	// MARK: Custom functions
	
	func configureSearchBar(frame: CGRect, font: UIFont, textColor: UIColor, bgColor: UIColor) {
		customSearchBar = CustomSearchBar(frame: frame, font: font , textColor: textColor)
		
		customSearchBar.barTintColor = bgColor
		customSearchBar.tintColor = textColor
		customSearchBar.showsBookmarkButton = false
		customSearchBar.showsCancelButton = true
		customSearchBar.delegate = self
	}

}

extension CustomSearchController: UISearchBarDelegate  {
	
	// MARK: UISearchBarDelegate functions
	
	func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
		customDelegate.didStartSearching()
	}
	
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		customSearchBar.resignFirstResponder()
		customDelegate.didTapOnSearchButton()
	}
	
	
	func searchBarCancelButtonClicked(searchBar: UISearchBar) {
		customSearchBar.resignFirstResponder()
		customDelegate.didTapOnCancelButton()
	}
	
	
	func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
		customDelegate.didChangeSearchText(searchText)
	}
	
}


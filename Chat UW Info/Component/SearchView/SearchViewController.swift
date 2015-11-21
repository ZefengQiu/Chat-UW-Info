//
//  SearchViewController.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-12.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
  
	@IBOutlet weak var searchTableView: UITableView!

	var dataArray = [String]()
	var filteredArray = [String]()
  
	var shouldShowSearchResults = false
	var searchController: UISearchController!
	var customSearchController: CustomSearchController!
	
	var infoDict = [String: Array<String>]()
	var dictKeys = [String]()
	
	var fetchISCoreData = [InfoSessionUnits]()
  var chatInfoDict = [String: InfoSessionUnits]()
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		searchTableView.dataSource = self
		searchTableView.delegate = self
		
		SearchCell.registerInTableView(searchTableView)
	}
	
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchInfoSessionData()
		configureCellOrder()
		configureCustomSearchController()
		
  }
	
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //MARK: configure function for custom search
  
  private func configureCustomSearchController() {
    let statusView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 20.0))
    statusView.backgroundColor = UIColor.chatBule()
    self.view.addSubview(statusView)
    
    customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, searchTableView.frame.size.width, 60.0), searchBarFont: UIFont(name: "Futura", size: 16.0)!, searchBarTextColor: UIColor.blackColor(), searchBarTintColor: UIColor.chatBule())
    
    customSearchController.customSearchBar.placeholder = "Search in Info Sessions"
    
    let customSearchBar = customSearchController.customSearchBar
    self.view.addSubview(customSearchBar)
    customSearchBar.translatesAutoresizingMaskIntoConstraints = false
    let views = ["customSearchBar" : customSearchBar]
    
    var constraints = [NSLayoutConstraint]()
    
    constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|[customSearchBar]|", options: [], metrics: nil, views: views)
    constraints += NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[customSearchBar]", options: [], metrics: nil, views: views)
    
    NSLayoutConstraint.activateConstraints(constraints)
    
    
    customSearchController.customDelegate = self
  }

  
}


extension SearchViewController {
	
	//MARK: fetch from core data
	func fetchInfoSessionData() {
		let fetchRequest = NSFetchRequest(entityName: "InfoSessionUnits")
		
		do {
			let fetchResults = try Locator.managedObjectContext.executeFetchRequest(fetchRequest) as! [InfoSessionUnits]
			fetchISCoreData = fetchResults
		}catch let error as NSError {
			print("fetch failed: \(error.localizedDescription))")
		}
		
		for infoData in fetchISCoreData {
      if let cancel = infoData.employer?.containsMatch("cancel", ignoreCase: true){
        if !cancel {
          chatInfoDict[infoData.employer!] = infoData
          if let resecheduled = infoData.employer?.containsMatch("rescheduled", ignoreCase: true) {
            if resecheduled {
              let resechedule = infoData.employer?.componentsSeparatedByString("* ")
              dataArray.append(resechedule![1])
            }else {
              dataArray.append(infoData.employer!)
            }
          }
        }
      }
		}
	}
	
	private func configureCellOrder() {
		infoDict = dataArray.groupBy(groupingFunction:
			{(arrayKey: String) -> String in
			return String(arrayKey[0])})
		
		for d in infoDict.keys {
			dictKeys.append(d)
		}
		
		dictKeys.sortInPlace({$0 < $1})
	}

}


extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate, CustomSearchControllerDelegate {
	
	// MARK: UISearchBarDelegate functions
	
	func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
		shouldShowSearchResults = true
		searchTableView.reloadData()
	}
	
	
	func searchBarCancelButtonClicked(searchBar: UISearchBar) {
		shouldShowSearchResults = false
		searchTableView.reloadData()
	}
	
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		if !shouldShowSearchResults {
			shouldShowSearchResults = true
			searchTableView.reloadData()
		}
		searchController.searchBar.resignFirstResponder()
	}
	
	// MARK: UISearchResultsUpdating delegate function
	
	func updateSearchResultsForSearchController(searchController: UISearchController) {
		let searchString = searchController.searchBar.text
		
		// Filter the data array and get only those countries that match the search text.
		filteredArray = dataArray.filter({ (info) -> Bool in
			let infoText: NSString = info
			
			return (infoText.rangeOfString(searchString!, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
		})
		
		// Reload the tableview.
		searchTableView.reloadData()
	}
	
	
	// MARK: CustomSearchControllerDelegate functions
	
	func didStartSearching() {
		shouldShowSearchResults = true
		searchTableView.reloadData()
	}
	
	
	func didTapOnSearchButton() {
		if !shouldShowSearchResults {
			shouldShowSearchResults = true
			searchTableView.reloadData()
		}
	}
	
	
	func didTapOnCancelButton() {
		shouldShowSearchResults = false
		searchTableView.reloadData()
	}
	
	
	func didChangeSearchText(searchText: String) {
		// Filter the data array and get only those countries that match the search text.
		filteredArray = dataArray.filter({ (info) -> Bool in
			let infoText: NSString = info
			
			return (infoText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
		})
		
		// Reload the tableview.
		searchTableView.reloadData()
	}

}

//MARK: delegate from chat view 

extension SearchViewController: ChatInfoSessionViewControllerDelegate {
  func tellNumberOfChats(controller: UIViewController, infoSessionEmployer employer: String, numberOfChats num: Int) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}

//MARK: table view delegate and datasource

extension SearchViewController: UITableViewDataSource {
  
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    if shouldShowSearchResults {
      return 1
    }else {
      return dictKeys.count
    }
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if shouldShowSearchResults {
			return filteredArray.count
		}
		else {
			return infoDict[dictKeys[section]]!.count
		}
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let section = indexPath.section
		let row = indexPath.row
		let cell = tableView.dequeueReusableCellWithIdentifier(SearchCell.identifier()) as! SearchCell
    cell.selectedBackgroundView = UIView.cellSelectionStyleChatBlue(UIColor.chatBule())

		if shouldShowSearchResults {
			cell.employerNameLabel.text = filteredArray[row]
		}
		else {
			cell.employerNameLabel.text = infoDict[dictKeys[section]]![row]
		}
		
		return cell
	}
}

extension SearchViewController: UITableViewDelegate {
  
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return SearchCell.estimatedRowHeight()
	}
  
  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    let cell = tableView.dequeueReusableCellWithIdentifier(SearchCell.identifier()) as! SearchCell
    cell.selectionStyle = .None
  }
  
  func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
    if shouldShowSearchResults == false {
      return dictKeys
    }
    
    return [String]()
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if shouldShowSearchResults == false {
			return dictKeys[section]
		}
		
		return " "
	}
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let section = indexPath.section
    let row = indexPath.row
    
    let chatNavVc = self.storyboard?.instantiateViewControllerWithIdentifier("ChatInfoSessionNavController") as! UINavigationController
    let chatVc = chatNavVc.topViewController as! ChatInfoSessionViewController
    
    chatVc.delegate = self
    
    if shouldShowSearchResults {
      chatVc.infoSessionChatOn = InfoSessionUnits.convertToInfoSessionUnit(chatInfoDict[filteredArray[row]]!)
    }else {
      chatVc.infoSessionChatOn = InfoSessionUnits.convertToInfoSessionUnit(chatInfoDict[infoDict[dictKeys[section]]![row]]!)
    }
    
    self.presentViewController(chatNavVc, animated: true, completion: nil)
    
    self.searchTableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
	
}









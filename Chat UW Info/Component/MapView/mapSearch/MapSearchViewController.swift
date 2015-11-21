//
//  MapSearchViewController.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-22.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit
import MapKit


class MapSearchViewController: UIViewController {
	
	@IBOutlet weak var mapSearchTableView: UITableView!
	
	weak var delegate: MapSearchViewControllerDelegate?
	var customSearchController: CustomSearchController!
	
	var buildingSpots = [BuildingSpot]()
	var dataArray = [String]()
  var codeArray = [String]()
	var filteredArray = [String]()
  
	var shouldShowSearchResults = false
	var searchController: UISearchController!
	var buildingDict = [String: CLLocationCoordinate2D]()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		buildingSpots = BuildingSpot.loadAllBuildingSpots()
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		mapSearchTableView.delegate = self
		mapSearchTableView.dataSource = self
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		configureCellOrder()
		configureCustomSearchController()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	var dictSpots = [String: Array<String>]()
	var dictKeys = [String]()
  var dictCode = [String: Array<BuildingSpot>]()
	
	private func configureCellOrder() {
		for spots in buildingSpots {
			dataArray.append(spots.buildingName)
			buildingDict[spots.buildingName] = spots.coordinate
      if !codeArray.contains(spots.buildingCode) {
        codeArray.append(spots.buildingCode)
      }
		}
		
		dictSpots = dataArray.groupBy(groupingFunction:
		{(arrayKey: String) -> String in
		return String(arrayKey[0]) })
    
    dictCode = buildingSpots.groupBy(groupingFunction:
    {(spot: BuildingSpot) -> String in
    return  spot.buildingCode})
    
		for d in dictSpots.keys {
			dictKeys.append(d)
		}
		
		dictKeys.sortInPlace({$0 < $1})
	}
	
  //MARK: configure function for custom search
  
  func configureCustomSearchController() {
    let statusView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 20.0))
    statusView.backgroundColor = UIColor.chatBule()
    self.view.addSubview(statusView)
    
    customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, mapSearchTableView.frame.size.width, 60.0), searchBarFont: UIFont(name: "Futura", size: 16.0)!, searchBarTextColor: UIColor.blackColor(), searchBarTintColor: UIColor.chatBule())
    
    customSearchController.customSearchBar.placeholder = "Search in UW Map Catalog"
    
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

//MARK: table view datasource and delegate

extension MapSearchViewController: UITableViewDataSource {
	
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
			return dictSpots[dictKeys[section]]!.count
		}
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
		let section = indexPath.section
		let row = indexPath.row
    cell.selectedBackgroundView = UIView.cellSelectionStyleChatBlue(UIColor.chatBule())
		
		if shouldShowSearchResults {
			cell.textLabel?.text = filteredArray[row]
		}
		else {
			cell.textLabel?.text = dictSpots[dictKeys[section]]![row]
		}
		
		return cell
	}
}

extension MapSearchViewController: UITableViewDelegate {
  
  func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
    if shouldShowSearchResults == false {
      return dictKeys
    }
    return [String]()
  }
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let section = indexPath.section
		let row = indexPath.row
		
		if shouldShowSearchResults {
			delegate?.providingSearchResult(self, searchResult: filteredArray[indexPath.row], buildingLocation: buildingDict[filteredArray[indexPath.row]]!)
		}else {
			let selectSpot = dictSpots[dictKeys[section]]![row]
			delegate?.providingSearchResult(self, searchResult: selectSpot, buildingLocation: buildingDict[selectSpot]!)
		}
    
    self.mapSearchTableView.deselectRowAtIndexPath(indexPath, animated: true)
	}
	
  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    cell.selectionStyle = .None
  }
  
	func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if shouldShowSearchResults == false {
			return String(dictKeys[section])
		}
		return ""
	}
	
}



extension MapSearchViewController: UISearchResultsUpdating, UISearchBarDelegate, CustomSearchControllerDelegate {
	
	// MARK: UISearchBarDelegate functions
	
	func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
		shouldShowSearchResults = true
		mapSearchTableView.reloadData()
	}
	
	
	func searchBarCancelButtonClicked(searchBar: UISearchBar) {
		shouldShowSearchResults = false
		mapSearchTableView.reloadData()
	}
	
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		if !shouldShowSearchResults {
			shouldShowSearchResults = true
			mapSearchTableView.reloadData()
		}
		searchController.searchBar.resignFirstResponder()
	}
	
	// MARK: UISearchResultsUpdating delegate function
	
	func updateSearchResultsForSearchController(searchController: UISearchController) {
		let searchString = searchController.searchBar.text
		
		// Filter the data array and get only those match the search text.
    var dataAppendix = dataArray.filter({ (info) -> Bool in
      let infoText: NSString = info
      return (infoText.rangeOfString(searchString!, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
    })
    
    let codeAppendix = codeArray.filter({ (info) -> Bool in
      let infoText: NSString = info
      return (infoText.rangeOfString(searchString!, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
    })
    
    for code in codeAppendix {
      if let spots = dictCode[code] {
        for spot in spots {
          dataAppendix.append(spot.buildingName)
        }
      }
    }
    
    filteredArray = dataAppendix
		
		// Reload the tableview.
		mapSearchTableView.reloadData()
	}
	
	
	// MARK: CustomSearchControllerDelegate functions
	
	func didStartSearching() {
		shouldShowSearchResults = true
		mapSearchTableView.reloadData()
	}
	
	
	func didTapOnSearchButton() {
		if !shouldShowSearchResults {
			shouldShowSearchResults = true
			mapSearchTableView.reloadData()
		}
	}
	
	
	func didTapOnCancelButton() {
		delegate?.cancelSearchInMap(self)
		shouldShowSearchResults = false
		mapSearchTableView.reloadData()
	}
	
	
	func didChangeSearchText(searchText: String) {
		// Filter the data array and get only those match the search text.
		
		var dataAppendix = dataArray.filter({ (info) -> Bool in
			let infoText: NSString = info
			return (infoText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
		})
    
    let codeAppendix = codeArray.filter({ (info) -> Bool in
      let infoText: NSString = info
      return (infoText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
    })
    
    for code in codeAppendix {
      if let spots = dictCode[code] {
        for spot in spots {
          dataAppendix.append(spot.buildingName)
        }
      }
    }
    
    filteredArray = dataAppendix
		
		// Reload the tableview.
		mapSearchTableView.reloadData()
	}
	
}




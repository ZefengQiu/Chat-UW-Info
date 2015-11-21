//
//  BuildingSpot.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-21.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import Foundation
import MapKit


struct BuildingSpot {
	let coordinate: CLLocationCoordinate2D
	let buildingName: String
	let buildingCode: String
}

extension BuildingSpot {
	
	static func loadAllBuildingSpots() -> [BuildingSpot] {
		return loadUWBuildingPlist("uw_building")
	}
	
	private static func loadUWBuildingPlist(plistName: String) -> [BuildingSpot] {
		
		let path = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist")
		let dictArray = NSArray(contentsOfFile: path!) as? [[String : AnyObject]]
		
		var buildingSpots = [BuildingSpot]()
		
		for dict in dictArray! {
			guard let longtitude = dict["longitude"] as? Double,
						let latitude = dict["latitude"] as? Double,
				let code = dict["building_code"] as? String,
				let buildingName = dict["building_name"] as? String else {
					fatalError("Error parsing dict \(dict)")
			}
			
			let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
			let spot = BuildingSpot(coordinate: coordinate, buildingName: buildingName, buildingCode: code)
			
			buildingSpots.append(spot)
		}
		
		return buildingSpots
	}
	
}
//
//  InfoMapViewController.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-28.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

class InfoMapViewController: UIViewController {
	
	@IBOutlet weak var mapView: GMSMapView!
	
	let locationManager = CLLocationManager()
	
	var infoLocation: String!
	
	struct infoSessionLoaction {
		static let DC = CLLocationCoordinate2DMake(43.4726266424767, -80.5422597751021)
		static let TC = CLLocationCoordinate2DMake(43.469270804792, -80.5414594709873)
		static let Fed = CLLocationCoordinate2DMake(43.4731935543136, -80.5485197156668)
		static let UClub = CLLocationCoordinate2DMake(43.4722962253136, -80.5473452433944)
		static let SLCPub = CLLocationCoordinate2DMake(43.471601, -80.545455)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = infoLocation
		
		self.mapView.layoutIfNeeded()
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		
		setDestinationMarker(infoLocation)
	}
	
	private func setDestinationMarker(location: String) {
		let marker = GMSMarker()
		
		if (location.containsMatch("DC") == true) {
			marker.position = infoSessionLoaction.DC
			marker.title = "DC"
			title = "DC"
		}else if (location.containsMatch("Fed") == true) {
			marker.position = infoSessionLoaction.Fed
			marker.title = "Fed Hall"
			title = "Fed Hall"
		}else if (location.containsMatch("TC") == true) {
			marker.position = infoSessionLoaction.TC
			marker.title = "TC"
			title = "TC"
		}else if (location.containsMatch("University Club") == true) {
			marker.position = infoSessionLoaction.UClub
			marker.title = "University Club"
			title = "University Club"
		}else if (location.containsMatch("Bombshelter") == true) {
			marker.position = infoSessionLoaction.SLCPub
			marker.title = "(SLC)Bombshelter Pub"
			title = "SLC Pub"
		}else {
			title = "Not in Campus, Tap Google😉"
		}
		marker.snippet = "UWaterloo"
		marker.map = mapView
	}

	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}


extension InfoMapViewController: CLLocationManagerDelegate {
	func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
		if status == .AuthorizedWhenInUse {
			locationManager.startUpdatingLocation()
			mapView.myLocationEnabled = true
			mapView.settings.myLocationButton = true
		}
	}
	
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first  {
			self.mapView.layoutIfNeeded()
			mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
			locationManager.stopUpdatingLocation()
		}
		
	}
}
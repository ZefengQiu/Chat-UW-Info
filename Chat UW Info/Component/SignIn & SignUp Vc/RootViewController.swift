//
//  RootViewController.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-02.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit
import MapKit

class RootViewController: UIViewController {
  
  @IBOutlet weak var tabBarControll: UITabBar!
  @IBOutlet weak var infoSessionsBarItem: UITabBarItem!
  @IBOutlet weak var accountBarItem: UITabBarItem!
	@IBOutlet weak var searchBarItem: UITabBarItem!
	@IBOutlet weak var mapBarItem: UITabBarItem!
  
  var infoSessionNavViewController: UINavigationController {return Locator.infoSessionNavigationController}
  var infoSessionViewController: InfoSessionViewController { return Locator.infoSessionViewController }
  var chatInfoSessionNavViewController: UINavigationController {return Locator.chatInfoSessionNavigationController}
  var chatInfoSessionViewController: ChatInfoSessionViewController {return Locator.chatInfoSessionViewController}
  var accountNavViewController: UINavigationController { return Locator.accountNavigationController}
  var accountViewController: AccountViewController { return Locator.accountViewController }
//	var searchNavViewController: UINavigationController { return Locator.searchNavigationController }
	var searchViewController: SearchViewController { return Locator.searchViewController }
	var mapNavViewController: UINavigationController { return Locator.mapNavigationController }
	var mapViewController: MapViewController { return Locator.mapViewController }
	
  lazy var mySplitViewController: UISplitViewController = {
    var splitController = Locator.splitViewController
    
    // Setup childViewControllers
    switch self.traitCollection.horizontalSizeClass {
    case .Compact:
      splitController.viewControllers = [self.infoSessionNavViewController]
    default:
      splitController.viewControllers = [self.infoSessionNavViewController, self.chatInfoSessionNavViewController]
    }
    
    splitController.preferredDisplayMode = UISplitViewControllerDisplayMode.AllVisible
    splitController.delegate = self
    splitController.hidesBottomBarWhenPushed = true
    
    return splitController
    }()
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
		
		//implement tab bar
		
		viewControllers = [mySplitViewController, accountNavViewController, searchViewController, mapNavViewController]
		
		self.tabBarControll.delegate = self
		self.tabBar(tabBarControll , didSelectItem: infoSessionsBarItem)
		
  }
  
  //display and hide controller for tab bar controller
  
  var viewControllers: [UIViewController] = []
  var activeController:UIViewController? = nil
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func displayContentInTabBar(contentController:UIViewController) {
    self.addChildViewController(contentController)
		
    contentController.view.translatesAutoresizingMaskIntoConstraints = false
    self.view.insertSubview(contentController.view, belowSubview: tabBarControll)
    
    NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: contentController.view, attribute: .Top, multiplier: 1.0, constant: 0.0).active = true
    NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: contentController.view, attribute: .Leading, multiplier: 1.0, constant: 0.0).active = true
    NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: contentController.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0).active = true
    NSLayoutConstraint(item: view, attribute: .Trailing, relatedBy: .Equal, toItem: contentController.view, attribute: .Trailing, multiplier: 1.0, constant: 0.0).active = true
    
    contentController.didMoveToParentViewController(self)
    self.activeController = contentController
  }
  
  func hideContentInTabBar(contentController:UIViewController) {
    contentController.willMoveToParentViewController(nil)
    contentController.view.removeFromSuperview()
    contentController.removeFromParentViewController()
  }
  
}


extension RootViewController: UITabBarDelegate {
  func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
    if let activeController = activeController {
      self.hideContentInTabBar(activeController)
    }
    
    switch item.tag {
    case 0:
      self.displayContentInTabBar(viewControllers[0])
    case 1:
      self.displayContentInTabBar(viewControllers[1])
		case 2:
			self.displayContentInTabBar(viewControllers[2])
		case 3:
			self.displayContentInTabBar(viewControllers[3])
    default:
      break;
    }
  }
}


extension RootViewController: UISplitViewControllerDelegate {
  func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
    
    if let navigationController = secondaryViewController as? UINavigationController {
      if let chatInfoSessionVC = navigationController.topViewController as? ChatInfoSessionViewController {
        return chatInfoSessionVC.shouldHide
      }
    }
    return true
  }
  
  func splitViewController(splitViewController: UISplitViewController, separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController) -> UIViewController? {
    return Locator.chatInfoSessionViewController
  }
}

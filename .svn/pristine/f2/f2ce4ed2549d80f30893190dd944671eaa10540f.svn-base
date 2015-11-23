//
//  Locator.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-03.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit
import CoreData

class Locator {
  
  static let sharedInstance = Locator()
  
  // MARK: - Root View Controller
  private lazy var _rootViewController: RootViewController = {
    var controller = UIViewController.viewControllerInStoryboard("Main", viewControllerName: "RootViewController") as! RootViewController
    return controller
    }()
  
  class var rootViewController: RootViewController {
    return sharedInstance._rootViewController
  }
  
  // MARK: - Split View Controller
  private lazy var _splitViewController: UISplitViewController = {
    var splitController = UISplitViewController()
    return splitController
    }()
  
  class var splitViewController: UISplitViewController {
    return sharedInstance._splitViewController
  }
  
  // MARK: - Info Session View Controller
  private lazy var _infoSessionNavigationController: UINavigationController = {
    var controller = UIViewController.viewControllerInStoryboard("Main", viewControllerName: "InfoSesionNavController") as! UINavigationController
    return controller
    }()
  
  class var infoSessionNavigationController: UINavigationController {
    return sharedInstance._infoSessionNavigationController
  }
  
  private lazy var _infoSessionViewController: InfoSessionViewController = {
    var controller = UIViewController.viewControllerInStoryboard("Main", viewControllerName: "InfoSessionViewController") as! InfoSessionViewController
    return controller
    }()
  
  class var infoSessionViewController: InfoSessionViewController {
    return sharedInstance._infoSessionViewController
  }
  
  // MARK: - Chat View Controller
  private lazy var _chatInfoSessionNavigationController: UINavigationController = {
    var controller = UIViewController.viewControllerInStoryboard("Main", viewControllerName: "ChatInfoSessionNavController") as! UINavigationController
    return controller
    }()
  
  class var chatInfoSessionNavigationController: UINavigationController {
    return sharedInstance._chatInfoSessionNavigationController
  }
  
  private lazy var _chatInfoSessionViewController: ChatInfoSessionViewController = {
    var controller = UIViewController.viewControllerInStoryboard("Main", viewControllerName: "ChatInfoSessionViewController") as! ChatInfoSessionViewController
    return controller
    }()
  
  class var chatInfoSessionViewController: ChatInfoSessionViewController {
    return sharedInstance._chatInfoSessionViewController
  }
  
  // MARK: - Account View Controller
  private lazy var _accountNavigationController: UINavigationController = {
    var controller = UIViewController.viewControllerInStoryboard("Main", viewControllerName: "AccountNavViewController") as! UINavigationController
    return controller
    }()
  
  class var accountNavigationController: UINavigationController {
    return sharedInstance._accountNavigationController
  }
  
  private lazy var _accountViewController: AccountViewController = {
    var controller = UIViewController.viewControllerInStoryboard("Main", viewControllerName: "AccountViewController") as! AccountViewController
    return controller
    }()
  
  class var accountViewController: AccountViewController {
    return sharedInstance._accountViewController
  }
  
  // MARK: - Sign In View Controller
  private lazy var _signInNavigationController: UINavigationController = {
    var controller = UIViewController.viewControllerInStoryboard("Main", viewControllerName: "SignInNavViewController") as! UINavigationController
    return controller
    }()
  
  class var signInNavigationController: UINavigationController {
    return sharedInstance._signInNavigationController
  }
  
  private lazy var _signInViewController: SignInViewController = {
    var controller = UIViewController.viewControllerInStoryboard("Main", viewControllerName: "SignInViewController") as! SignInViewController
    return controller
    }()
  
  class var signInViewController: SignInViewController {
    return sharedInstance._signInViewController
  }
  
  
  // MARK: - Search View Controller
//  private lazy var _searchNavigationController: UINavigationController = {
//    var controller = UIViewController.viewControllerInStoryboard("Main", viewControllerName: "SearchNavViewController") as! UINavigationController
//    return controller
//    }()
//  
//  class var searchNavigationController: UINavigationController {
//    return sharedInstance._searchNavigationController
//  }
	
  private lazy var _searchViewController: SearchViewController = {
    var controller = UIViewController.viewControllerInStoryboard("Main", viewControllerName: "SearchViewController") as! SearchViewController
    return controller
    }()
  
  class var searchViewController: SearchViewController {
    return sharedInstance._searchViewController
  }
	
	
	// MARK: - Map View Controller
	private lazy var _mapNavigationController: UINavigationController = {
		var controller = UIViewController.viewControllerInStoryboard("Main", viewControllerName: "MapNavViewController") as! UINavigationController
		return controller
	}()
	
	class var mapNavigationController: UINavigationController {
		return sharedInstance._mapNavigationController
	}
	
	private lazy var _mapViewController: MapViewController = {
		var controller = UIViewController.viewControllerInStoryboard("Main", viewControllerName: "MapViewController") as! MapViewController
		return controller
	}()
	
	class var mapViewController: MapViewController {
		return sharedInstance._mapViewController
	}
	
	//MARK: app delegate
	
	class var delegate: AppDelegate { return UIApplication.sharedApplication().delegate as! AppDelegate }
	
	// MARK: - Core Data
	class var managedObjectContext: NSManagedObjectContext {
		if let context = Locator.delegate.managedObjectContext {
			return context
		} else {
			print("managedObjectContext is nil")
			assertionFailure("")
			return NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
		}
	}
	
}












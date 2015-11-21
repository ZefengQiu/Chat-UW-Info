//
//  ExVcShowError.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-09-26.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit


extension UIViewController {
  
  func showErrorView(error: NSError) {
    if let errorMessage = error.userInfo["error"] as? String {
      let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
      presentViewController(alert, animated: true, completion: nil)
    }
  }
  
 
  class func viewControllerInStoryboard(storyboardName: String , viewControllerName: String) -> UIViewController {
    let storyboard: UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
    let viewController = storyboard.instantiateViewControllerWithIdentifier(viewControllerName)
    return viewController
  }
  
}


extension UIView {
  
  class func cellSelectionStyleChatBlue(color: UIColor) -> UIView {
    let view = UIView()
    view.backgroundColor = color
    return view
  }
  
}
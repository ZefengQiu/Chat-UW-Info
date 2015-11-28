//
//  CustomIndicatorView.swift
//  Chat UW Info
//
//  Created by Zefeng Qiu on 2015-11-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit


public class CenterIndicatorView {
  
  var container = UIView()
  var loadingView = UIView()
  var activityIndicator = UIActivityIndicatorView()
  
  private var containerBackColor: UIColor
  private var loadingBackColor: UIColor
  private var indicatorColor: UIColor
  
  init(containerBackColor: UIColor, loadingBackColor: UIColor, indicatorColor: UIColor) {
    
    self.containerBackColor = containerBackColor
    self.loadingBackColor = loadingBackColor
    self.indicatorColor = indicatorColor
  }
  
  func showActivityIndicator(View: UIView) -> UIView {
    
    container.frame = View.frame
    container.center = View.center
    container.backgroundColor = containerBackColor
    
    
    loadingView.frame = CGRectMake(0, 0, 80, 80)
    loadingView.center = View.center
    loadingView.backgroundColor = loadingBackColor
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    
    
    activityIndicator.color = indicatorColor
    activityIndicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    activityIndicator.activityIndicatorViewStyle =
      UIActivityIndicatorViewStyle.WhiteLarge
    activityIndicator.center = CGPointMake(loadingView.frame.size.width / 2,
      loadingView.frame.size.height / 2);
    loadingView.addSubview(activityIndicator)
    container.addSubview(loadingView)
    View.addSubview(container)
    activityIndicator.startAnimating()
    
    return container
  }
  
  func hideActicityIndicator() {
    activityIndicator.stopAnimating()
    container.removeFromSuperview()
  }
  
  
}

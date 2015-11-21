//
//  ExSwift.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-09-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import Foundation


public class ExSwift {
  
  internal class func regex (pattern: String, ignoreCase: Bool = false) -> NSRegularExpression? {
    
    var options = NSRegularExpressionOptions.DotMatchesLineSeparators.rawValue
    
    if ignoreCase {
      options = NSRegularExpressionOptions.CaseInsensitive.rawValue | options
    }
    
    var error: NSError? = nil
    let regex: NSRegularExpression?
    do {
      regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions(rawValue: options))
    } catch let error1 as NSError {
      error = error1
      regex = nil
    }
    
    return (error == nil) ? regex : nil
    
  }
  
}
//
//  InfoSessionUnits.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-12.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import Foundation
import CoreData

class InfoSessionUnits: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
  
  class func convertToInfoSessionUnit(coreInfo: InfoSessionUnits) -> InfoSessionUnit {
    var infosession = InfoSessionUnit()
    
    infosession.employer = coreInfo.employer!
    infosession.date = coreInfo.date!
    infosession.time = coreInfo.time!
    infosession.location = coreInfo.location!
    infosession.website = coreInfo.website!
    infosession.audience = coreInfo.audience!
    infosession.program = coreInfo.program!
    
    return infosession
  }

}
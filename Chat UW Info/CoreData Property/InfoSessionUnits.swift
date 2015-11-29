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
  
  class func fetchInfoSessionAccordingEmployer(infosession: String) -> InfoSessionUnits? {
    let fetchRequest = NSFetchRequest(entityName: "InfoSessionUnits")
    let predicate = NSPredicate(format: "employer = %@", infosession)
    fetchRequest.predicate = predicate
    
    do {
      let fetchResult = try Locator.managedObjectContext.executeFetchRequest(fetchRequest) as! [InfoSessionUnits]
      return fetchResult[0]
    }catch let error as NSError {
      print("fetch failed: \(error.localizedDescription))")
    }
    
    return nil
  }
  
  class func fetchInfoSessionReturnUnit() -> [InfoSessionUnit]? {
    let fetchRequest = NSFetchRequest(entityName: "InfoSessionUnits")
    var infoUnit = [InfoSessionUnit]()
    
    do {
      let fetchResults = try Locator.managedObjectContext.executeFetchRequest(fetchRequest) as! [InfoSessionUnits]
      
      for info in fetchResults {
        infoUnit.append(self.convertToInfoSessionUnit(info))
      }
      
      return infoUnit
    }catch let error as NSError {
      print("fetch failed: \(error.localizedDescription))")
    }
    
    return nil
  }
  
}










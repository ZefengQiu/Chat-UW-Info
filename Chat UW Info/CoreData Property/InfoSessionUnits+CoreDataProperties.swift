//
//  InfoSessionUnits+CoreDataProperties.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-12.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension InfoSessionUnits {
  
  @NSManaged var employer: String?
  @NSManaged var date: String?
  @NSManaged var time: String?
  @NSManaged var location: String?
  @NSManaged var website: String?
  @NSManaged var audience: String?
  @NSManaged var program: String?
  
}

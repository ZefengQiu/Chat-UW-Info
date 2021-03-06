//
//  InfoSessionSourceHTMLParser.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-09-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import Foundation

import Ji
import SwiftyJSON

struct InfoSessionSourceHTMLParser {
  let kEmployer = "Employer"
  let kDate = "Date"
  let kTime = "Time"
  let kLocation = "Location"
  let kWebSite = "Web Site"
  let kAudience = "Audience"
  let kProgram = "Program"
  let kDescription = "Description"
  let kId = "id"
  
  var result = [String: AnyObject]()
  
  func parserHTMLString(string: String) {
//    print("Parsing info session information from website")
    
    let doc: Ji! = Ji(htmlString: string)
    if doc == nil {
      print("Setup Ji doc failed")
    }
    
    let nodes = doc.xPath("//*[@id='tableform']")
    if let tableNode = nodes?.first where tableNode.name == "table" {
      // Divide trs into different sessions
      // Each session is a list of tr Ji node
      var trSessionGroups = [[JiNode]]()
      var trSessionGroup: [JiNode]?
      for tr in tableNode {
        if let tdContent = tr.firstChildWithName("td")?.content {
          if tdContent.hasPrefix("\(kEmployer):") {
            if let trSessionGroup = trSessionGroup { trSessionGroups.append(trSessionGroup) }
            trSessionGroup = [tr]
            continue
          }
          trSessionGroup!.append(tr)
        }
      }
      
      // Process each session group to a dictionary
      _ = JSON(trSessionGroups.map { self.processTrSessionGroupToDict($0) })
//      print(json)
    }
  }
  
  private func processTrSessionGroupToDict(trSession: [JiNode]) -> [[String: String]] {
    var resultUnit = [[String: String]]()
    var unit = InfoSessionUnit()
    
    var webSiteIndex: Int?
    for (index, tr) in trSession.enumerate() {
      if let firstString = tr.firstChild?.content?.trimmed() where firstString.hasPrefix("\(kEmployer):") {
        let secondString = tr.firstChild?.nextSibling?.content?.trimmed()
        resultUnit.append([kEmployer: secondString ?? "null"])
        unit.employer = secondString!
      } else if let firstString = tr.firstChild?.content?.trimmed() where firstString.hasPrefix("\(kDate):") {
        let secondString = tr.firstChild?.nextSibling?.content?.trimmed()
        resultUnit.append([kDate: secondString ?? "null"])
        unit.longDate = secondString!
				unit.date = InfoSessionUnit.changeDateFormat(secondString!)
      } else if let firstString = tr.firstChild?.content?.trimmed() where firstString.hasPrefix("\(kTime):") {
        let secondString = tr.firstChild?.nextSibling?.content?.trimmed()
        resultUnit.append([kTime: secondString ?? "null"])
        unit.time = secondString!
      } else if let firstString = tr.firstChild?.content?.trimmed() where firstString.hasPrefix("\(kLocation):") {
        let secondString = tr.firstChild?.nextSibling?.content?.trimmed()
        resultUnit.append([kLocation: secondString ?? "null"])
        unit.location = secondString!
      } else if let firstString = tr.firstChild?.content?.trimmed() where firstString.hasPrefix("\(kWebSite):") {
        var secondString = tr.firstChild?.nextSibling?.content?.trimmed()
        if secondString == "http://" { secondString = "" }
        resultUnit.append([kWebSite: secondString ?? "null"])
        webSiteIndex = index
        unit.website = secondString!
      }
      else if let webSiteIndex = webSiteIndex where index == webSiteIndex + 1 {
        // Audience + Programs
        if let rawContent = tr.xPath("./td/i").first?.rawContent?.replaceMatches("<(i|/i)>", withString: "", ignoreCase: false) {
          let components = rawContent.componentsSeparatedByString("<br>")
          if components.count == 3 {
            let levelString = (components[0].hasPrefix("For ") ? components[0].stringByReplacingOccurrencesOfString("For ", withString: "", options: NSStringCompareOptions(rawValue: 0), range: nil) : components[0]).trimmed()
            let studentString = components[1].replaceMatches(", ", withString: ",", ignoreCase: true)?.stringByReplacingOccurrencesOfString(",", withString: ", ", options: NSStringCompareOptions(rawValue: 0), range: nil).trimmed() ?? ""
            let programString = components[2].trimmed()
            resultUnit.append([kAudience: "\(levelString) \(studentString)".trimmed()])
            resultUnit.append([kProgram: programString])
            unit.audience = "\(levelString) \(studentString)".trimmed()
            unit.program = programString
          } else {
            print("Parsing Audient and Program failed.")
          }
        } else {
          print("Get raw text for Audience failed.")
        }
      }
    }
    
    if unit.employer != "" && unit.employer != "No info sessions" && unit.employer != "Closed info session" && unit.employer != "Closed Info Session"{
      Info.shareInstance.InfoSessions.append(unit)
    }
    
    return resultUnit
  }
}

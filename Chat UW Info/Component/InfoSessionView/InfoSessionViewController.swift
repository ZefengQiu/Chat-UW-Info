//
//  InfoSessionViewController.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-09-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit
import Parse
import Bolts
import CoreData

class InfoSessionViewController: UIViewController {
  
  @IBOutlet weak var infoSessionTableView: UITableView!
  
  var infoSessionBegin = Client()
  var termlyInfoSessions = [InfoSessionUnit()]
  var date = NSDate()
	var dataTermArray = [NSManagedObject]()
	var finishParsing = false
	var grayObsolete = 0
  
  var userName: String!
//  var userEmail = ChatUser.shareInstance.userEmail
  var cellDict = [String: Int]()
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    userName = ChatUser.shareInstance.userName
    title = "\(userName)"
  
  }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
		
    fetchFromUniversityWebForTermInfoSessions()
    
    let todayButton = UIBarButtonItem(title: "\(NSDate.getTodayStr("MMM d"))", style: UIBarButtonItemStyle.Plain,  target: self, action: "scrolltoToday")
    navigationItem.leftBarButtonItem = todayButton
	}
  
  @IBAction func refreshContent() {
    termlyInfoSessions = []
    Info.shareInstance.InfoSessions = []
    finishParsing = false
    grayObsolete = 0
    infoSessionTableView.reloadData()
    
    self.fetchFromUniversityWebForTermInfoSessions()
    self.checkUserEmail()
  }
  
  //MARK: fetch from internet and database operation 
  
  private func fetchFromUniversityWebForTermInfoSessions() {
    infoSessionBegin.getTermInfoSession(2015, term: .Fall){
      (result: Bool) in
      print("got back: \(result)")
      if result {
        self.finishParsing = result
        
        self.termlyInfoSessions = Info.shareInstance.InfoSessions
        self.infoSessionTableView.reloadData()
        
        self.scrolltoToday()
        
        if self.checkTermStored() {
          self.storeInfoSessionToCoreData(result)
        }
      }else {
        print("cannot fetch from the website, load it from the website")
        let errorMessage = "connect to UW website got problem, load data from core data storage"
        self.showAlertSheet("Error", message: errorMessage)
        if let infos = InfoSessionUnits.fetchInfoSessionReturnUnit() {
          self.termlyInfoSessions = infos
        }else {
          let message = "nothing in core data"
          self.showAlertSheet("Error", message: message)
        }
      }
    }
  }
  
  private func checkUserEmail() {
    if let user = PFUser.currentUser() {
      user.fetchInBackgroundWithBlock({ (object, error) -> Void in
        user.fetchIfNeededInBackgroundWithBlock({ (result, error) -> Void in
          let emailVerified = user["emailVerified"] as! Bool
          ChatUser.shareInstance.emailVerified = emailVerified
        })
      })
    }else {
      let alertController = UIAlertController(title: "Error", message: "Sorry, could not fetch user information", preferredStyle: .Alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
      self.presentViewController(alertController, animated: true, completion: nil)
    }    
  }
  
  //MARK: configure function
  
  private func setupTableView(){
    LoadingCell.registerInTableView(infoSessionTableView)
    InfoSessionCell.registerInTableView(infoSessionTableView)
    
    infoSessionTableView.delegate = self
    infoSessionTableView.dataSource = self
    
    infoSessionTableView.rowHeight = UITableViewAutomaticDimension
  }
	
	func scrolltoToday() {
		grayObsolete = findDate(termlyInfoSessions)
		let indexPath = NSIndexPath(forRow: grayObsolete, inSection: 0)
		infoSessionTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
	}
	
	private func findDate(infosessions: [InfoSessionUnit]) -> Int{
		let taget = NSDate()
		var n = 0
		
		for info in infosessions {
			if InfoSessionUnit.changeToNSDate("MMMM d, yyyy", dateStr: info.longDate).isGreater(taget) {
				return n
			}
			n += 1
		}
		return 0
	}
	
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

//MARK: core data

extension InfoSessionViewController {
	
	func storeInfoSessionToCoreData(processStoring: Bool) {
		if processStoring {
			for unit in termlyInfoSessions {
				let infoSessionUnits = NSEntityDescription.entityForName("InfoSessionUnits", inManagedObjectContext: Locator.managedObjectContext)
				let isUnit = InfoSessionUnits(entity: infoSessionUnits!, insertIntoManagedObjectContext: Locator.managedObjectContext)
				
				isUnit.employer = unit.employer
				isUnit.date = unit.date
				isUnit.time = unit.time
				isUnit.location = unit.location
				isUnit.website = unit.website
				isUnit.audience = unit.audience
				isUnit.program = unit.program
			}
			
			do {
				try Locator.managedObjectContext.save()
			}catch let error as NSError {
				print("could not save \(error), \(error.userInfo)")
			}
		}
	}
  
	
	//check whether the info sessoin monthly have been store
	func checkTermStored() -> Bool {

		let fetchRequest = NSFetchRequest(entityName:"TermDataManager")
		do {
			let fetchedResults = try Locator.managedObjectContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
			dataTermArray = fetchedResults
		}catch let error as NSError{
			print("Fetch failed :\(error.localizedDescription)")
		}
		
		if dataTermArray.isEmpty {
			saveToDateManager("2015-Fall")
			return true
		}else{
			for d in dataTermArray {
				let month = d.valueForKey("isTerm") as! String
				if month == "2015-Fall" {
					print("this term data has been saved")
					return false
				}
			}
			saveToDateManager("2015-Fall")
			return true
		}
		
	}
	
	func saveToDateManager(termString: String) {
		let entity = NSEntityDescription.entityForName("TermDataManager", inManagedObjectContext: Locator.managedObjectContext)
		let data = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: Locator.managedObjectContext)
		data.setValue(termString, forKey: "isTerm")
		
		do{
			try Locator.managedObjectContext.save()
		}catch let error as NSError {
			print("could not save \(error), \(error.userInfo)")
		}
		
		print("----------\(termString)----is being saving in core data")
		dataTermArray.append(data)
	}
  
	
}

//MARK: delegate from chat view

extension InfoSessionViewController: ChatInfoSessionViewControllerDelegate {
  func tellNumberOfChats(controller: UIViewController, infoSessionEmployer employer: String, numberOfChats num: Int) {
    cellDict.updateValue(num, forKey: employer)
    infoSessionTableView.reloadData()
    dismissViewControllerAnimated(true, completion: nil)
  }
}

//MARK: table view delegate and datasource

extension InfoSessionViewController: UITableViewDataSource{
	
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if finishParsing {
      return termlyInfoSessions.count
    }else {
      return 1
    }
  }
   
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if finishParsing {
      let cell = tableView.dequeueReusableCellWithIdentifier(InfoSessionCell.identifier()) as! InfoSessionCell
      let InfoSession = termlyInfoSessions[indexPath.row]
			
			if indexPath.row < grayObsolete {
				cell.configureCellForInfoSession(InfoSession, grayInfoSession: true)
			}else {
				cell.configureCellForInfoSession(InfoSession, grayInfoSession: false)
			}
			
			
      return cell
      
    }else {
      let cell = tableView.dequeueReusableCellWithIdentifier(LoadingCell.identifier()) as! LoadingCell
      return cell
    }
  }
	
}


extension InfoSessionViewController: UITableViewDelegate {
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    if finishParsing {
      return InfoSessionCell.estimatedRowHeight()
    }else {
      return LoadingCell.estimatedRowHeight()
    }
  }
  
	
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    let chatNavVc = self.storyboard?.instantiateViewControllerWithIdentifier("ChatInfoSessionNavController") as! UINavigationController
    let chatVc = chatNavVc.topViewController as! ChatInfoSessionViewController
    let infoSession = termlyInfoSessions[indexPath.row]
    
    chatVc.delegate = self
    chatVc.infoSessionChatOn = infoSession
    
    Locator.chatInfoSessionViewController.shouldHide = false
    Locator.splitViewController.presentViewController(chatNavVc, animated: true, completion: nil)
  }
	
	
}












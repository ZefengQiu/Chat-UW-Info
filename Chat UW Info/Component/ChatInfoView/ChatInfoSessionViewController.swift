//
//  ChatInfoSessionViewController.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-09-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit
import SafariServices
import Parse
import Bolts


class ChatInfoSessionViewController: UIViewController {
  
  var shouldHide: Bool = true
  
  @IBOutlet weak var chatInfoSessionTableView: UITableView!
  weak var delegate: ChatInfoSessionViewControllerDelegate?
  
  var infoSessionChatOn: InfoSessionUnit!
  var user: String!
  
  var doneUploadingFromParse = false
  var doneDownloadingFromParse = false
  
  var parseResult = [[String]]()
  var chatsNumber = 0
  var updatingComment = false
  var comment = ""
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    user = ChatUser.shareInstance.userName
    setUpTableView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = infoSessionChatOn.employer
    getUsedChats()
	
  }
  
  @IBAction func addToFavorite() {
    let query = PFQuery(className: "ParseChatUser")
    query.whereKey("userName", equalTo: ChatUser.shareInstance.userName)
    query.whereKey("userEmail", equalTo: ChatUser.shareInstance.userEmail)
    
    query.getFirstObjectInBackgroundWithBlock({ (object: PFObject?, error: NSError?) -> Void in
      if error != nil {
        self.showErrorView(error!)
      }else if let chatUserObject = object {
        var infosessions = chatUserObject["infoSessionFollowed"] as! [String]
        infosessions.append(self.infoSessionChatOn.employer)
        chatUserObject["infoSessionFollowed"] = infosessions
        chatUserObject.saveInBackgroundWithBlock{ (succeeded: Bool, error: NSError?) -> Void in
          if succeeded {
            //secceed upload favorite info session information
          }else if let error = error {
            self.showErrorView(error)
          }
        }
      }
    })
  }
  
  
  @IBAction func backToInfoSession(sender: UIBarButtonItem) {
    delegate?.tellNumberOfChats(self, infoSessionEmployer: infoSessionChatOn.employer, numberOfChats: chatsNumber)
  }
  
  //configuration function
  
  private func setUpTableView() {
		TimeCell.registerInTableView(chatInfoSessionTableView)
    AudienceInfoCell.registerInTableView(chatInfoSessionTableView)
    ProgramCell.registerInTableView(chatInfoSessionTableView)
    LocationWebsiteCell.registerInTableView(chatInfoSessionTableView)
		AddChatsCell.registerInTableView(chatInfoSessionTableView)
    ChatsCell.registerInTableView(chatInfoSessionTableView)
    SofaCell.registerInTableView(chatInfoSessionTableView)
    
    chatInfoSessionTableView.delegate = self
    chatInfoSessionTableView.dataSource = self
    
    chatInfoSessionTableView.rowHeight = UITableViewAutomaticDimension
  }
	

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}


//MARK: inherit protocol delegation from commend view controller 

extension ChatInfoSessionViewController: CommendViewControllerDelegate {
	func commendCancel(controller: UIViewController) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func providingCommendFromViewController(controller: UIViewController, commendToSubmit commend: NSString) {
		updatingComment = true
		chatsNumber = chatsNumber + 1
		comment = commend as String
		
		parseResult.append([user, comment, getTime()])
		self.uploadingComment()
		doneUploadingFromParse = true
		chatInfoSessionTableView.reloadCertainSection(2)
		
		dismissViewControllerAnimated(true, completion: nil)
	}
}


//MARK: deal with Parse database
extension ChatInfoSessionViewController {
  
  //for Parse uploading
  
  func uploadingComment() {
    
		let chatObject = CommendToParse(user: user, commend: comment, createDate: NSDate())
    let chatArrayData: NSData = NSKeyedArchiver.archivedDataWithRootObject(chatObject)
    let file = PFFile(name: "comments", data: chatArrayData)
    
    file!.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
      if succeeded {
        //2
        self.saveIntoChats(file!)
      } else if let error = error {
        //3
        self.showErrorView(error)
      }
      }, progressBlock: { percent in
        //4
        print("Uploaded: \(percent)%")
    })
  }
  
  func saveIntoChats(file: PFFile)
  {
    //1
    let chatsPost = ParseInfoSessionUnit(userName: user, infoSession: infoSessionChatOn.employer, chats: file)
    //2
    chatsPost.saveInBackgroundWithBlock{ succeeded, error in
      if succeeded {
        //3, do something to upload the table view
      } else {
        //4
        if let _ = error?.userInfo["error"] as? String {
          self.showErrorView(error!)
        }
      }
    }
  }
  
  //for parse downloading
  
  func getUsedChats() {
    let query = ParseInfoSessionUnit.query()!
    query.whereKey("oneInfoSession", equalTo: infoSessionChatOn.employer)
    query.findObjectsInBackgroundWithBlock{ objects, error in
      if error == nil {
        if let objects = objects as? [ParseInfoSessionUnit] {
          self.loadChats(objects){
            (resultNumberOfRow: Int) in
            self.chatsNumber = resultNumberOfRow
            self.doneDownloadingFromParse = true
            self.chatInfoSessionTableView.reloadCertainSection(2)
          }
        }
      }else if let error = error {
        self.showErrorView(error)
      }
    }
  }
  
  
  func loadChats(objects: [ParseInfoSessionUnit], completionHandler: (resultNumberOfRow: Int) -> Void) {
    var n = 0
		var tmpObjects = [CommendToParse]()
    for infosession in objects {
      infosession.chats.getDataInBackgroundWithBlock{ data, error in
        if let chatsData = data {
          let chatObject = NSKeyedUnarchiver.unarchiveObjectWithData(chatsData) as! CommendToParse
					tmpObjects.append(chatObject)
					n = n + 1
        }
				
				if n  == objects.count {
					tmpObjects.sortInPlace({$0.createDate.isLess($1.createDate)})
					for item in tmpObjects {
						let dateFormatter = NSDateFormatter()
						dateFormatter.dateFormat = "MMM.dd HH:m"
						self.parseResult.append([item.user, item.commend, dateFormatter.stringFromDate(item.createDate)])
					}
					completionHandler(resultNumberOfRow: n)
				}
      }
    }
  }
	
	private func getTime() -> String {
		let date = NSDate()
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "MMM.dd HH:m"
		return dateFormatter.stringFromDate(date)
	}
  
}

//MARK: table view delegate and datasource
extension ChatInfoSessionViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return 5
		case 1:
			return 1
		default:
			if doneDownloadingFromParse {
				return chatsNumber
			}else {
				return 1
			}
		}
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let timeCell = tableView.dequeueReusableCellWithIdentifier(TimeCell.identifier()) as! TimeCell
    let audiCell = tableView.dequeueReusableCellWithIdentifier(AudienceInfoCell.identifier()) as! AudienceInfoCell
    let proCell = tableView.dequeueReusableCellWithIdentifier(ProgramCell.identifier()) as! ProgramCell
    let locationWebCell = tableView.dequeueReusableCellWithIdentifier(LocationWebsiteCell.identifier()) as! LocationWebsiteCell
		let addChatCell = tableView.dequeueReusableCellWithIdentifier(AddChatsCell.identifier()) as! AddChatsCell
		let chatsCell = tableView.dequeueReusableCellWithIdentifier(ChatsCell.identifier()) as! ChatsCell
    let sofaCell = tableView.dequeueReusableCellWithIdentifier(SofaCell.identifier()) as! SofaCell

    let section = indexPath.section
    let row = indexPath.row
    
    if section == 0 {
      switch row {
			case 0:
				timeCell.timeLabel.text = "\(infoSessionChatOn.date) \(infoSessionChatOn.time)"
				return timeCell
			case 1:
				locationWebCell.locationWebsiteLabel.text = infoSessionChatOn.location
        locationWebCell.selectedBackgroundView = UIView.cellSelectionStyleChatBlue(UIColor.chatBule())
				return locationWebCell
      case 2:
        if infoSessionChatOn.website != "" {
          locationWebCell.selectedBackgroundView = UIView.cellSelectionStyleChatBlue(UIColor.chatBule())
          locationWebCell.locationWebsiteLabel.text = infoSessionChatOn.website
        }else {
          locationWebCell.locationWebsiteLabel.text = "No Website Provided"
        }
        return locationWebCell
      case 3:
        audiCell.selectionStyle = .None
        audiCell.audienceLabel.text = infoSessionChatOn.audience
        return audiCell
      default:
        proCell.selectionStyle = .None
        proCell.programLabel.text = infoSessionChatOn.program
        return proCell
      }
    }else if section == 1{
      addChatCell.selectedBackgroundView = UIView.cellSelectionStyleChatBlue(UIColor.whiteColor())
			return addChatCell
		}else {
			if !doneDownloadingFromParse && !doneUploadingFromParse{
        sofaCell.selectionStyle = .None
				return sofaCell
			}else {
				doneUploadingFromParse = false
				let tmpResult = parseResult[row]
				chatsCell.personName.setTitle("\(tmpResult[0]):", forState: UIControlState.Normal)
				chatsCell.chatContentLabel.text = tmpResult[1]
				chatsCell.chatTimeLabel.text = tmpResult[2]
				return chatsCell
			}
		}
  }
	
}


extension ChatInfoSessionViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    let chatsCell = tableView.dequeueReusableCellWithIdentifier(ChatsCell.identifier()) as! ChatsCell
    let addChatCell = tableView.dequeueReusableCellWithIdentifier(AddChatsCell.identifier()) as! AddChatsCell
    let locationWebCell = tableView.dequeueReusableCellWithIdentifier(LocationWebsiteCell.identifier()) as! LocationWebsiteCell

    locationWebCell.selectionStyle = .None
    addChatCell.selectionStyle = .None
    chatsCell.selectionStyle = .None
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let section = indexPath.section
		let row = indexPath.row
		
		if section == 0 {
			if row == 1 {
				if infoSessionChatOn.location != "" {
					let infoMapNav = self.storyboard?.instantiateViewControllerWithIdentifier("InfoMapNavViewController") as! UINavigationController
					let infoMapVc = infoMapNav.topViewController as! InfoMapViewController
					infoMapVc.infoLocation = infoSessionChatOn.location
					self.showViewController(infoMapVc, sender: nil)
				}
			}
			
			if row == 2 {
				if infoSessionChatOn.website != "" {
					let svc = SFSafariViewController(URL: NSURL(string: infoSessionChatOn.website)!, entersReaderIfAvailable: true)
					svc.delegate = self
					self.presentViewController(svc, animated: true, completion: nil)
				}
			}
		}
    
		
		if section == 1 {
			if row == 0 {
				let commendNavVc = self.storyboard?.instantiateViewControllerWithIdentifier("CommmendNavViewController") as! UINavigationController
				let cVc = commendNavVc.topViewController as! CommendViewController
				cVc.commendDelegate = self
				self.showViewController(commendNavVc, sender: nil)
			}
		}
    
    self.chatInfoSessionTableView.deselectRowAtIndexPath(indexPath, animated: true)
		
  }
}

//MARK:  safar view controller delegate
extension ChatInfoSessionViewController: SFSafariViewControllerDelegate {
  func safariViewControllerDidFinish(controller: SFSafariViewController)
  {
    controller.dismissViewControllerAnimated(true, completion: nil)
  }
}



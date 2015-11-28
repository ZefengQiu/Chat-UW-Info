//
//  IndividualViewController.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-09-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit
import Parse
import Bolts
import CoreData

class AccountViewController: UIViewController {
  
  @IBOutlet weak var accoutTableView: UITableView!
  
  var favoriteInfoSessions = [InfoSessionUnits]()
  var numOfFav = 0
  
  let centerIndicator = CenterIndicatorView(containerBackColor: UIColor.semiClearGray(aplha: 0.3), loadingBackColor: UIColor.chatBule(), indicatorColor: UIColor.lightGrayColor())
  var refreshControl: UIRefreshControl!

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
		
		self.fetchFavoriteInfoSessionFromParse()
    self.numOfFav = ChatUser.shareInstance.userFollowedInfoSessions.count
    self.accoutTableView.reloadData()
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
		
		title = "Chat UW Info"
    
    setupTableView()
    self.fetchFavoriteInfoSessionFromParse()
    loadFavoriteInfoSessionFromCoreData(ChatUser.shareInstance.userFollowedInfoSessions)
    
    //add refresh controll
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: "fetchBoth", forControlEvents: .ValueChanged)
    accoutTableView.addSubview(refreshControl)
  }
	
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
	private func setupTableView() {
		HeaderViewCell.registerInTableView(accoutTableView)
		AccountCell.registerInTableView(accoutTableView)
		SettingCell.registerInTableView(accoutTableView)
    UserPrivacyCell.registerInTableView(accoutTableView)
    FavoriteInfoCell.registerInTableView(accoutTableView)
		
		accoutTableView.delegate = self
		accoutTableView.dataSource = self
		
		accoutTableView.rowHeight = UITableViewAutomaticDimension
	}
  
}

//MARK: downloading favorite info sessions from data base


extension AccountViewController {
  
  func fetchBoth() {
    checkUserEmail()
    fetchFavoriteInfoSessionFromParse()
  }
  
  func fetchFavoriteInfoSessionFromParse() {
    let query = PFQuery(className: "ParseChatUser")
    query.whereKey("userName", equalTo: ChatUser.shareInstance.userName)
    query.whereKey("userEmail", equalTo: ChatUser.shareInstance.userEmail)
    
    query.getFirstObjectInBackgroundWithBlock({ (object: PFObject?, error: NSError?) -> Void in
      if error != nil {
        self.showErrorView(error!)
      }else if let chatObject = object {
        let infosessions = chatObject["infoSessionFollowed"] as! [String]
        ChatUser.shareInstance.userFollowedInfoSessions = infosessions
        self.loadFavoriteInfoSessionFromCoreData(infosessions)
      }
    })
    
  }
  
  func loadFavoriteInfoSessionFromCoreData(infoSessions: [String]) {
    for infosession in infoSessions {
      if let info = InfoSessionUnits.fetchInfoSessionAccordingEmployer(infosession) {
        if !favoriteInfoSessions.contains(info) {
          favoriteInfoSessions.append(info)
        }
      }
    }
    
    if numOfFav != infoSessions.count {
      self.accoutTableView.reloadCertainSection(1)
    }
  }
  
  
  func checkUserEmail() {
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
    
    refreshControl.endRefreshing()
    self.accoutTableView.reloadData()
    
  }
}


//MARK: table view datasource and delegate

extension AccountViewController: UITableViewDataSource {
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 4
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return 3
		case 1:
			return 1 + favoriteInfoSessions.count
    case 2:
      return 4
		default:
			return 1
		}
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let headerViewCell = tableView.dequeueReusableCellWithIdentifier(HeaderViewCell.identifier()) as! HeaderViewCell
		let accountCell = tableView.dequeueReusableCellWithIdentifier(AccountCell.identifier()) as! AccountCell
		let settingCell = tableView.dequeueReusableCellWithIdentifier(SettingCell.identifier()) as! SettingCell
    let userPrivacyCell = tableView.dequeueReusableCellWithIdentifier(UserPrivacyCell.identifier()) as! UserPrivacyCell
    let favInfoCell = tableView.dequeueReusableCellWithIdentifier(FavoriteInfoCell.identifier()) as! FavoriteInfoCell
		
		let section = indexPath.section
		let row = indexPath.row
		
		switch section {
		case 0:
			if row == 0 {
        headerViewCell.configureHeader(ChatUser.shareInstance.userName, image: "userNameIcon.png")
				return headerViewCell
			}else if row == 1 {
				accountCell.configureCell("UW email: ", value: ChatUser.shareInstance.userEmail)
				return accountCell
			}else {
				accountCell.configureCell("Department: ", value: ChatUser.shareInstance.userDepartment)
				return accountCell
			}

		case 1:
      if row == 0 {
        headerViewCell.configureHeader("My Favorite Info Session", image: "favInfoIcon.png")
        return headerViewCell
      }else {
        if let info = favoriteInfoSessions[row - 1].employer {
          favInfoCell.favoriteInfoLabel.text = "\(info)"
        }
        favInfoCell.selectedBackgroundView = UIView.cellSelectionStyleChatBlue(UIColor.chatBule())
        return favInfoCell
      }
     
    case 2:
			if row == 0 {
				headerViewCell.configureHeader("Settings", image: "settingIcon.png")
				return headerViewCell
      }else if row == 1 {
        if ChatUser.shareInstance.emailVerified {
          settingCell.selectionStyle = .None
          settingCell.configureSettingButton("email verified", titleColor: UIColor.lightGrayColor())
        }else {
          settingCell.selectionStyle = .Gray
          settingCell.configureSettingButton("please verify your UW email", titleColor: UIColor.blackBlue())
        }
        return settingCell
      }else if row == 2 {
        userPrivacyCell.selectionStyle = .None
        userPrivacyCell.delegate = self
        userPrivacyCell.chatUserName = ChatUser.shareInstance.userName
        return userPrivacyCell
      }else {
        settingCell.selectionStyle = .Gray
				settingCell.configureSettingButton("reset password", titleColor: UIColor.blackBlue())
				return settingCell
			}
      
		default:
      settingCell.selectionStyle = .Gray
			settingCell.configureSettingButton("account log out", titleColor: UIColor.redColor())
			return settingCell
		}
		
	}
}

extension AccountViewController: UITableViewDelegate{
	func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
  
  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    let settingCell = tableView.dequeueReusableCellWithIdentifier(SettingCell.identifier()) as! SettingCell
    
    settingCell.selectionStyle = .None
  }
  
  func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
    let section = indexPath.section
    let row = indexPath.row
    
    let delete = UITableViewRowAction(style: .Normal, title: "delete") { action in
      if let info = self.favoriteInfoSessions[row - 1].employer {
        self.deleteFavInfoInParse(info)
        self.centerIndicator.showActivityIndicator(self.view)
      }
    }
    delete.backgroundColor = UIColor.redColor()
    
    if section == 1 {
      return [delete]
    }
    
    return nil
  }
  
  //delete favorite info session from parse chat user 
  
  func deleteFavInfoInParse(infosession: String) {
    let query = PFQuery(className: "ParseChatUser")
    query.whereKey("userName", equalTo: ChatUser.shareInstance.userName)
    query.whereKey("userEmail", equalTo: ChatUser.shareInstance.userEmail)
    
    query.getFirstObjectInBackgroundWithBlock({ (object: PFObject?, error: NSError?) -> Void in
      if error != nil {
        self.centerIndicator.hideActicityIndicator()
        self.showErrorView(error!)
      }else if let chatObject = object {
        var infosessionArray = chatObject["infoSessionFollowed"] as! [String]
        infosessionArray = infosessionArray.filter(){$0 != "\(infosession)"}
        chatObject["infoSessionFollowed"] = infosessionArray
        chatObject.saveInBackgroundWithBlock({ succeed, error in
          if succeed {
            self.centerIndicator.hideActicityIndicator()
            self.favoriteInfoSessions = self.favoriteInfoSessions.filter(){$0.employer != infosession}
            self.accoutTableView.reloadCertainSection(1)
          }else if let error = error {
            self.centerIndicator.hideActicityIndicator()
            self.showErrorView(error)
          }
        })
      }
    })
    
  }
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let section = indexPath.section
		let row = indexPath.row
		
    if section == 1 {
      let chatNavVc = self.storyboard?.instantiateViewControllerWithIdentifier("ChatInfoSessionNavController") as! UINavigationController
      let chatVc = chatNavVc.topViewController as! ChatInfoSessionViewController
      chatVc.delegate = self
      
      let infosession = InfoSessionUnits.convertToInfoSessionUnit(favoriteInfoSessions[row - 1])
      chatVc.infoSessionChatOn = infosession
      
      self.presentViewController(chatNavVc, animated: true, completion: nil)
    }
    
    if section == 2 {
      if row == 1 {
        if !ChatUser.shareInstance.emailVerified {
          self.emailSendToReVerify()
        }
      }
      
      if row == 4 {
        PFUser.requestPasswordResetForEmailInBackground(ChatUser.shareInstance.userEmail, block: {
          succeeded, error -> Void in
          if succeeded {
            self.emailSendToResetPassword()
          }else if let error = error {
            self.showErrorView(error)
          }
        })
      }
    }
    
		if section == 3 {
			if row == 0 {
				logOut()
			}
		}
    
    self.accoutTableView.deselectRowAtIndexPath(indexPath, animated: true)
    
	}
  
  
  private func logOut() {
    PFUser.logOutInBackground()
//    chatUser = ChatUser()
    favoriteInfoSessions = [InfoSessionUnits]()
    dismissViewControllerAnimated(true, completion: nil)
  }
	
//MARK: reset parse chat user email
  
  private func emailSendToResetPassword() {
    let alertController = UIAlertController(title: "Password Reset",
      message: "An email has been sent to reset your user password",
      preferredStyle: UIAlertControllerStyle.Alert
    )
    
    alertController.addAction(UIAlertAction(title: "OKAY",
      style: UIAlertActionStyle.Default,
      handler: { alertController in self.logOut() }))
    
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  
  
  private func emailSendToReVerify() {
    let alertController = UIAlertController(title: "Verify Email",
      message: "Another email has been sent to verify",
      preferredStyle: UIAlertControllerStyle.Alert
    )
    
    alertController.addAction(UIAlertAction(title: "OKAY",
      style: UIAlertActionStyle.Default,
      handler: { alertController in self.resendEmailToVerified() }))
    
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  
  private func resendEmailToVerified() {
    let user = PFUser.currentUser()
    let email = user?.email
    user?.email = ""
    
    user?.saveInBackgroundWithBlock{ result, error in
      if let error = error {
        self.showErrorView(error)
        return
      }
      user!.email = email
      user!.saveInBackgroundWithBlock {result, error in
        if let error = error {
          self.showErrorView(error)
          return
        }
      }
    }
  }
  
}

extension AccountViewController: UserPrivacyCellDelegate {
  
  func changeUserPrivacyError(error: NSError) {
    centerIndicator.hideActicityIndicator()
    self.showErrorView(error)
  }
  
  func succeedChangeUserPrivacy() {
    centerIndicator.hideActicityIndicator()
  }
  
  func inChangingState() {
    centerIndicator.showActivityIndicator(self.view)
  }
}


extension AccountViewController: ChatInfoSessionViewControllerDelegate{
  func tellNumberOfChats(controller: UIViewController, infoSessionEmployer employer: String, numberOfChats num: Int) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}



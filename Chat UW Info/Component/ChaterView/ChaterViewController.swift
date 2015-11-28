//
//  ChaterViewController.swift
//  Chat UW Info
//
//  Created by Zefeng Qiu on 2015-11-23.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit
import Parse
import Bolts


class ChaterViewController: UIViewController {
  
  @IBOutlet weak var chaterTableView: UITableView!
  
  var chater: ChatUser!
  weak var delegate: ChaterViewControllerDelegate?
  
  var favoriteInfoSessions = [InfoSessionUnits]()
  var numOfFav = 0
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    fetchFavoriteInfoSessionFromCoreData(chater.userFollowedInfoSessions)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Chat User"
    setUpTableView()
    
  }
  
  @IBAction func doneInspectChater() {
    delegate?.doneInspectChatUser(self)
  }
  
  private func setUpTableView() {
    HeadCell.registerInTableView(chaterTableView)
    AccountCell.registerInTableView(chaterTableView)
    FavoriteInfoCell.registerInTableView(chaterTableView)
    SettingCell.registerInTableView(chaterTableView)
    
    chaterTableView.delegate = self
    chaterTableView.dataSource = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //MARK: fetch from core data according user favorite info session array string
  
  private func fetchFavoriteInfoSessionFromCoreData(infosessions: [String]) {
    for infosession in infosessions {
      if let info = InfoSessionUnits.fetchInfoSessionAccordingEmployer(infosession) {
        if !favoriteInfoSessions.contains(info) {
          favoriteInfoSessions.append(info)
        }
      }
    }
    
    self.chaterTableView.reloadCertainSection(1)
  }
  
}


//MARK: table view datasource and table view

extension ChaterViewController: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 3
    default:
      return 1 + favoriteInfoSessions.count
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let headCell = tableView.dequeueReusableCellWithIdentifier(HeadCell.identifier()) as! HeadCell
    let accountCell = tableView.dequeueReusableCellWithIdentifier(AccountCell.identifier()) as! AccountCell
    let favInfoCell = tableView.dequeueReusableCellWithIdentifier(FavoriteInfoCell.identifier()) as! FavoriteInfoCell
    
    let section = indexPath.section
    let row = indexPath.row
    
    switch section {
    case 0:
      if row == 0 {
        headCell.selectionStyle = .None
        headCell.configureHeader("\(chater.userName)", image: "userNameIcon.png")
        return headCell
      }else if row == 1 {
        accountCell.selectionStyle = .None
        accountCell.configureCell("Email: ", value: "\(chater.userEmail)")
        return accountCell
      }else {
        accountCell.selectionStyle = .None
        accountCell.configureCell("Department", value: "\(chater.userDepartment)")
        return accountCell
      }
    default:
      if row == 0 {
        headCell.selectionStyle = .None
        headCell.configureHeader("User's Favorite Info Session", image: "favInfoIcon.png")
        return headCell
      }else {
        if let info = favoriteInfoSessions[row - 1].employer {
          favInfoCell.favoriteInfoLabel.text = "\(info)"
        }
        favInfoCell.selectedBackgroundView = UIView.cellSelectionStyleChatBlue(UIColor.chatBule())
        return favInfoCell
      }
    }
    
  }
  
}

extension ChaterViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    let section = indexPath.section
    let row = indexPath.row
    
    switch section {
    case 0:
      if row == 0 {
        return HeaderCell.estimatedRowHeight()
      }else if row == 3 {
        return SettingCell.estimatedRowHeight()
      }else {
        return AccountCell.estimatedRowHeight()
      }
    default:
      if row == 0 {
        return HeaderCell.estimatedRowHeight()
      }else {
        return FavoriteInfoCell.estimatedRowHeight()
      }
    }
  }
  
  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    let favInfoCell = tableView.dequeueReusableCellWithIdentifier(FavoriteInfoCell.identifier()) as! FavoriteInfoCell
    favInfoCell.selectionStyle = .None
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let section = indexPath.section
    let row = indexPath.row
    
    if section == 1 {
      if row != 0 {
        let chatNavVc = self.storyboard?.instantiateViewControllerWithIdentifier("ChatInfoSessionNavController") as! UINavigationController
        let chatVc = chatNavVc.topViewController as! ChatInfoSessionViewController
        chatVc.delegate = self
        
        let infosession = InfoSessionUnits.convertToInfoSessionUnit(favoriteInfoSessions[row - 1])
        chatVc.infoSessionChatOn = infosession
        
        self.presentViewController(chatNavVc, animated: true, completion: nil)

      }
    }
    
    
    chaterTableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
}


extension ChaterViewController: ChatInfoSessionViewControllerDelegate {
  func tellNumberOfChats(controller: UIViewController, infoSessionEmployer employer: String, numberOfChats num: Int) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}


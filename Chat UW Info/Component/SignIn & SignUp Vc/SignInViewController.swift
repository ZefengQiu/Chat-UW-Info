//
//  SignInViewController.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-09-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit
import Parse
import Bolts

class SignInViewController: UIViewController {
  
  @IBOutlet weak var userNameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  var securePassword = true
  let centerIndicator = CenterIndicatorView(containerBackColor: UIColor.semiClearGray(aplha: 0.3), loadingBackColor: UIColor.chatBule(), indicatorColor: UIColor.lightGrayColor())
  
  @IBAction func showPassword(sender: UIBarButtonItem) {
    if securePassword {
      securePassword = false
    }else {
      securePassword = true
    }
    passwordTextField.secureTextEntry = securePassword
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    userNameTextField.placeholder = "User"
    passwordTextField.placeholder = "password"
    passwordTextField.secureTextEntry = securePassword
    
    if let user = PFUser.currentUser() {
      centerIndicator.showActivityIndicator(self.view)
      if user.isAuthenticated() {
        self.cometoChats(user)
      }
    }
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    view.addGestureRecognizer(tap)
    
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //MARK: pfuser log in
  
  @IBAction func logIn(sender: UIButton) {
		let userLogin = userNameTextField.text!
		let trimmedUserName = userLogin.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    centerIndicator.showActivityIndicator(self.view)
    
    PFUser.logInWithUsernameInBackground(trimmedUserName, password: passwordTextField.text!) { user, error in
      if user != nil {
        if user!["emailVerified"] as! Bool == false {
          self.alertEmailNotVerify(user!)
        }
        self.cometoChats(user!)
      }else if let errors = error {
        self.centerIndicator.hideActicityIndicator()
        self.showErrorView(errors)
      }
    }
    
  }
  
  func cometoChats(user: PFUser) {
    let rootVC = self.storyboard?.instantiateViewControllerWithIdentifier("RootViewController") as! RootViewController
    
    ChatUser.shareInstance.userName = user.username!
    ChatUser.shareInstance.userEmail = user.email!
    ChatUser.shareInstance.userDepartment = user["department"] as! String
    ChatUser.shareInstance.emailVerified = user["emailVerified"] as! Bool
    
    let query = PFQuery(className: "ParseChatUser")
    query.whereKey("userName", equalTo: ChatUser.shareInstance.userName)
    query.whereKey("userEmail", equalTo: ChatUser.shareInstance.userEmail)
    
    query.getFirstObjectInBackgroundWithBlock({(object: PFObject?, error: NSError?) -> Void in
      if error != nil {
        self.showErrorView(error!)
      }else if let chatObject = object {
        ChatUser.shareInstance.userFollowedInfoSessions = chatObject["infoSessionFollowed"] as! [String]
        self.navigationController?.showDetailViewController(rootVC, sender: nil)
      }
      self.centerIndicator.hideActicityIndicator()
    })
    
  }

  
  //MARK: go to sign up a pfuser
  
  @IBAction func SignUp(sender: UIButton) {
    let signUpNav = self.storyboard?.instantiateViewControllerWithIdentifier("SignUpNavController") as! UINavigationController
    let signUpVc = signUpNav.topViewController as! SignUpViewController
    signUpVc.delegate = self
    self.navigationController?.presentViewController(signUpNav, animated: true, completion: nil)
  }
  
  private func alertEmailNotVerify(user: PFUser) {
    let alertController = UIAlertController(title: "UW Email Verification",
      message: "please verify your UW email before Chat with others",
      preferredStyle: UIAlertControllerStyle.Alert
    )
    
    alertController.addAction(UIAlertAction(title: "OKAY",
      style: UIAlertActionStyle.Default,
      handler: { alertController in self.cometoChats(user) } ))
    
    self.presentViewController(alertController, animated: true, completion: nil)
  }

  
}

extension SignInViewController: SignUpViewControllerDelegate {
  
  func signUpCancel(controller: UIViewController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func providingSignUpInformation(controller: UIViewController, signUpUserName userName: String, signUpPassword password: String) {
    userNameTextField.text = userName
    passwordTextField.text = password
    dismissViewControllerAnimated(true, completion: nil)
  }
  
}



//MARK: get the user information from the parse chat user pfobject
//use singletom model to make sure that user are consistent in program, especially in different views, for there may be a parse bug

//  func getUserInfoFromParseChatUser(pfuser: PFUser) {
//    let userName = pfuser.username
//    let userEmail = pfuser.email
//
//    let query = PFQuery(className: "ParseChatUser")
//    query.whereKey("userName", equalTo: userName!)
//    query.whereKey("userEmail", equalTo: userEmail!)
//
//    query.getFirstObjectInBackgroundWithBlock({(object: PFObject?, error: NSError?) -> Void in
//      if error == nil {
//        if let chatObject = object as? ParseChatUser {
//          ChatUser.shareInstance.userName = chatObject.userName
//          ChatUser.shareInstance.userEmail = chatObject.userEmail
//          ChatUser.shareInstance.userDepartment = chatObject.userDepartment
//
//        }
//      }else if let error = error {
//        self.showErrorView(error)
//      }
//    })
//  }







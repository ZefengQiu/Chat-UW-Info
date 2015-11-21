//
//  SignUpViewController.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-09-25.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit
import Parse
import Bolts


class SignUpViewController: UIViewController {
  
  weak var delegate: SignUpViewControllerDelegate?
  
  @IBOutlet weak var userNameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var confirmPasswordTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var departmentTextField: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configPlaceholder()
    
    //secure the password text field
    passwordTextField.secureTextEntry = true
    confirmPasswordTextField.secureTextEntry = true
    
    let cancelButton = UIBarButtonItem(title: "cancel", style: UIBarButtonItemStyle.Plain,  target: self, action: "CancelSignUp")
    navigationItem.leftBarButtonItem = cancelButton
  }
  
  private func configPlaceholder() {
    userNameTextField.becomeFirstResponder()
    
    userNameTextField.placeholder = "enter your user name"
    passwordTextField.placeholder = "password"
    confirmPasswordTextField.placeholder = "confirm password"
    emailTextField.placeholder = "UW email"
    departmentTextField.placeholder = "user department"
  }
  
  //MARK: protocol method communication with signInViewController
  
  func backToSignIn() {
    self.delegate?.providingSignUpInformation(self, signUpUserName: self.userNameTextField.text!, signUpPassword: self.passwordTextField.text!)
  }
  
  func CancelSignUp() {
    delegate?.signUpCancel(self)
  }
  
  //MARK: perform sign up for PFUser
  
  @IBAction func preSignUp() {

    let alertController = UIAlertController(title: "Agree to terms and conditions",
      message: "Click I AGREE to signal that you agree to the End User Licence Agreement.",
      preferredStyle: UIAlertControllerStyle.Alert
    )
    
    alertController.addAction(UIAlertAction(title: "I AGREE",
      style: UIAlertActionStyle.Default,
      handler: { alertController in self.signUpPFUser() } ))
    
    alertController.addAction(UIAlertAction(title: "I do NOT agree", style: UIAlertActionStyle.Default, handler: nil))
  
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  
  func signUpPFUser() {
//    var userEmail = emailTextField.text
    let userPassword = passwordTextField.text
    let userConfirmPassword = confirmPasswordTextField.text
    
    // Ensure username is lowercase
//    userEmail = userEmail!.lowercaseString
    
    if userPassword == userConfirmPassword {
      
      let user = PFUser()
      user.username = userNameTextField.text
      user.password = passwordTextField.text
      user.email = emailTextField.text
      user["department"] = departmentTextField.text
  
      
      user.signUpInBackgroundWithBlock{ (succeeded: Bool, error: NSError?) -> Void in
        if error == nil {
          self.verifyEmail()
          self.creatingParseChatUser(user)
        } else {
          //Something bad has occurred
          self.showErrorView(error!)
        }
      }
    }else {
      self.passwordNotMatch()
    }
    
  }
  
  
  
  //MARK: perform creating a parse chat user class 
  
  func creatingParseChatUser(user: PFUser) {
    
    let parseChatUser = ParseChatUser(user: user, userName: userNameTextField.text!, userEmail: emailTextField.text!, userDepartment: departmentTextField.text!)
    
    parseChatUser.saveInBackgroundWithBlock({succeeded, error in
      if succeeded {
        
        // succeeded in creating a parse chat user pfobject in parse database 
        
      }else if let error = error {
        self.showErrorView(error)
      }
    })
  }
  
  
  //MARK: storing succeeded sign up/ creatring parse chat user in core data
  
  
  
  //MARK: method check sign up process
  
  private func verifyEmail() {
    // User needs to verify email address before continuing
    let alertController = UIAlertController(title: "UW Email Verification",
      message: "an email that contains a link - you must click this link before you can continue.",
      preferredStyle: UIAlertControllerStyle.Alert
    )
    
    alertController.addAction(UIAlertAction(title: "OKAY",
      style: UIAlertActionStyle.Default,
      handler: { alertController in self.backToSignIn()}))
   
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  
  
  private func passwordNotMatch() {
    let alertController = UIAlertController(title: "Password Not Match",
      message: "please confirm you password again",
      preferredStyle: UIAlertControllerStyle.Alert
    )
    
    alertController.addAction(UIAlertAction(title: "OKAY",
      style: UIAlertActionStyle.Default,
      handler: { alertController in self.clearPasswordField() } ))
    
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  
  
  private func clearPasswordField() {
    passwordTextField.placeholder = "password"
    confirmPasswordTextField.placeholder = "confirm password"
    passwordTextField.secureTextEntry = false
    confirmPasswordTextField.secureTextEntry = false
  }
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}









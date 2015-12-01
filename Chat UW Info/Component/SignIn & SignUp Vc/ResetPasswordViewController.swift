//
//  ResetPasswordViewController.swift
//  Chat UW Info
//
//  Created by Zefeng Qiu on 2015-11-29.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit
import Parse
import Bolts


protocol ResetPasswordViewControllerDelegate: class {
  func doneResetPassword(controller: ResetPasswordViewController)
}

class ResetPasswordViewController: UIViewController {
  
  @IBOutlet weak var userEmailTextField: UITextField!
  
  weak var delegate: ResetPasswordViewControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    userEmailTextField.placeholder = "Please enter your email to reset Password"
    userEmailTextField.becomeFirstResponder()
    userEmailTextField.returnKeyType = UIReturnKeyType.Done
    userEmailTextField.delegate = self
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    view.addGestureRecognizer(tap)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
  //MARK: navigation bar item control function 
  
  @IBAction func cancel() {
    delegate?.doneResetPassword(self)
  }
  
  @IBAction func done() {
    checkEmailExistence()
  }
  
  // check whether the email has exist
  
  func checkEmailExistence() {
    let query = PFQuery(className: "ParseChatUser")
    query.whereKey("userEmail", equalTo: userEmailTextField.text!)
    
    query.findObjectsInBackgroundWithBlock({ object, error -> Void in
      if error != nil {
        self.showErrorView(error!)
      }else if let _ = object {
        PFUser.requestPasswordResetForEmailInBackground(self.userEmailTextField.text!, block: {
          succeeded, error -> Void in
          if succeeded {
            self.emailSetAlert()
          }else if let error = error {
            self.showErrorView(error)
          }
          
        })
      }
    })
  }
  
  private func emailSetAlert() {
    let message = "An email has sent to you to reset the password ~"
    let alertController = UIAlertController(title: "Reset Password", message: message, preferredStyle: .Alert)
    
    alertController.addAction(UIAlertAction(title: "OKAY", style: .Default,
      handler: { alertController in self.delegate?.doneResetPassword(self) }))
    
    presentViewController(alertController, animated: true, completion: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

extension ResetPasswordViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    self.done()
    return true
  }
}

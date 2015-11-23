//
//  CommentCell.swift
//  Char UW Info
//
//  Created by Qiu Zefeng on 2015-09-24.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit

protocol CommentCellDelegate: class {
	func providingTextInTextView(cell: UITableViewCell, contentInTextView content: NSString, contentColor color: UIColor)
}


class CommentCell: UITableViewCell {
  
  @IBOutlet var textView: UITextView!
	
	weak var commentCellDelegate: CommentCellDelegate?
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  var textString: String {
    get {
      return textView?.text ?? ""
    }
    set {
      textView?.text = newValue
      textView.textColor = UIColor.blackColor()
      textViewDidChange(textView!)
    }
  }
	
  override func awakeFromNib() {
    super.awakeFromNib()
    
    // Disable scrolling inside the text view so we enlarge to fitted size
    textView?.scrollEnabled = false
    textView?.delegate = self
    textView.text = "your point of view towards the Info Session"
    textView.textColor = UIColor.lightGrayColor()
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
    if selected {
      textView?.becomeFirstResponder()
      
    } else {
      textView?.resignFirstResponder()
    }
  }
  
}


extension CommentCell: UITextViewDelegate {
  
  func textViewDidEndEditing(textView: UITextView) {
    if textView.text.isEmpty {
      textView.text = "your point of view towards the Info Session"
      textView.textColor = UIColor.lightGrayColor()
    }
  }
  
  func textViewDidBeginEditing(textView: UITextView) {
    if textView.textColor == UIColor.lightGrayColor() {
      textView.text = nil
      textView.textColor = UIColor.blackColor()
    }
  }
  
  func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    let oldText: NSString = textView.text
		let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: text)
		
		commentCellDelegate?.providingTextInTextView(self, contentInTextView: newText, contentColor: textView.textColor!)
    
    return true
  }
  
  func textViewDidChange(textView: UITextView) {
    
    let size = textView.bounds.size
    let newSize = textView.sizeThatFits(CGSize(width: size.width, height: CGFloat.max))
    
    // Resize the cell only when cell's size is changed
    if size.height != newSize.height {
      UIView.setAnimationsEnabled(false)
      tableView?.beginUpdates()
      tableView?.endUpdates()
      UIView.setAnimationsEnabled(true)
      
      if let thisIndexPath = tableView?.indexPathForCell(self) {
        tableView?.scrollToRowAtIndexPath(thisIndexPath, atScrollPosition: .Bottom, animated: false)
      }
    }
  }
}

extension CommentCell: TableViewInfo {
  class func identifier() -> String {
    return NSStringFromClass(CommentCell.self)
  }
  
  class func estimatedRowHeight() -> CGFloat {
    return 150
  }
  
  class func registerInTableView(tableView: UITableView) {
    let cellnib = UINib(nibName: "CommentCell", bundle: NSBundle(forClass: CommentCell.self))
    tableView.registerNib(cellnib, forCellReuseIdentifier: CommentCell.identifier())
  }
}

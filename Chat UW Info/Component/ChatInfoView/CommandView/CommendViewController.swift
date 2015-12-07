//
//  CommandViewController.swift
//  Chat UW Info
//
//  Created by Qiu Zefeng on 2015-10-20.
//  Copyright © 2015 Qiu Zefeng. All rights reserved.
//

import UIKit



class CommendViewController: UIViewController {
	
	@IBOutlet weak var commendTableView: UITableView!
	
	var commendContent: NSString?
	var commendColor: UIColor?
	weak var commendDelegate: CommendViewControllerDelegate?
	
	@IBAction func cancelCommand() {
		commendDelegate?.commendCancel(self)
	}
	
	@IBAction func submitCommmand() {
		if commendColor == UIColor.blackColor() {
			commendDelegate?.providingCommendFromViewController(self, commendToSubmit: commendContent!)
		}
	}
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		setUpTableView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
		view.addGestureRecognizer(tap)
	}
	
	private func setUpTableView() {
		CommentCell.registerInTableView(commendTableView)
		
		commendTableView.dataSource = self
		commendTableView.delegate = self
	}
	
	func DismissKeyboard(){
		//Causes the view (or one of its embedded text fields) to resign the first responder status.
		view.endEditing(true)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
}

extension CommendViewController: CommentCellDelegate {
	func providingTextInTextView(cell: UITableViewCell, contentInTextView content: NSString, contentColor color: UIColor) {
		commendContent = content
		commendColor = color
	}
}

extension CommendViewController: UITableViewDataSource {
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let commendCell = tableView.dequeueReusableCellWithIdentifier(CommentCell.identifier()) as! CommentCell
		commendCell.commentCellDelegate = self
		return commendCell
	}
}

extension CommendViewController: UITableViewDelegate {
	func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return CommentCell.estimatedRowHeight()
	}
}

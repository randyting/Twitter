//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Randy Ting on 10/3/15.
//  Copyright © 2015 Randy Ting. All rights reserved.
//

import UIKit

@objc protocol NewTweetViewControllerDelegate {
  optional func newTweetViewController(newTweetViewController: NewTweetViewController, didPostTweetText: String)
}

class NewTweetViewController: UIViewController {
  
  // MARK: - Storyboard Objects
  
  @IBOutlet private weak var userScreennameLabel: UILabel!
  @IBOutlet private weak var userNameLabel: UILabel!
  @IBOutlet private weak var profileImageView: UIImageView!
  @IBOutlet private weak var tweetTextView: UITextView!
  @IBOutlet private weak var tweetTextViewBottomToSuperHeightConstraint: NSLayoutConstraint!
  
  // MARK: - Properties
  weak var delegate: AnyObject?
  var currentUser: TwitterUser!

  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAppearance()
    setupInitialValues()
    setupTextView(tweetTextView)
  }
  
  // MARK: - Initial Setup

  private func setupAppearance(){
    // Alignes text to top in text view
    automaticallyAdjustsScrollViewInsets = false
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "willShowKeyboard:", name: UIKeyboardWillShowNotification, object: nil)
  }
  
  private func setupTextView(textView: UITextView) {
    textView.keyboardType = .Twitter
    textView.becomeFirstResponder()
  }
  
  private func setupInitialValues(){
    profileImageView.setImageWithURL(currentUser.profileImageURL())
    userNameLabel.text = currentUser.name
    userScreennameLabel.text = "@" + currentUser.screenname
  }
  
  // MARK: - Behavior
  
  func willShowKeyboard(notification: NSNotification) {
    if let userInfo = notification.userInfo {
      let kbSize = ((userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue().size)!
      tweetTextViewBottomToSuperHeightConstraint.constant = kbSize.height
    }
  }

  @IBAction func onTapCancelBarButton(sender: UIBarButtonItem) {
    navigationController?.popViewControllerAnimated(true)
  }

  @IBAction func onTapTweetBarButton(sender: UIBarButtonItem) {
    if tweetTextView.text.characters.count > 0 {
      TwitterUser.tweetText(tweetTextView.text, completion:
        {(success: Bool?, error: NSError?) -> () in
          if let error = error {
            print(error.localizedDescription)
          } else {
            self.delegate?.newTweetViewController!(self, didPostTweetText: self.tweetTextView.text)
            self.navigationController?.popViewControllerAnimated(true)
          }
      })
    }
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}


//
//  TwitterLoginViewController.swift
//
//
//  Created by Randy Ting on 9/29/15.
//
//

import UIKit

class TwitterLoginViewController: UIViewController {
  
  let loginSegueIdentifier = "loginSegue"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    attemptToLogin()
  }
  
  func attemptToLogin() {
    TwitterUser.loginWithCompletion { (user: TwitterUser?, error: NSError?) -> () in
      if let error = error {
        print(error.localizedDescription)
        let alert = UIAlertController.init(title: nil, message: error.localizedDescription, preferredStyle: .Alert)
        let tryAgainAction = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Cancel, handler: { (action: UIAlertAction) -> Void in
          self.attemptToLogin()
        })
        alert.addAction(tryAgainAction)
        self.presentViewController(alert, animated: true, completion: nil)
      } else {
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLoginNotification, object: self)
        self.performSegueWithIdentifier(self.loginSegueIdentifier, sender: self)
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

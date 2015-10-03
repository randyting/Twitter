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
    
    TwitterUser.loginWithCompletion { (user: TwitterUser?, error: NSError?) -> () in
      if let error = error {
        print(error.localizedDescription)
        let alert = UIAlertView.init(title: nil, message: error.localizedDescription, delegate: self, cancelButtonTitle: "OK")
        alert.show()
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

//
//  TwitterUser.swift
//  Twitter
//
//  Created by Randy Ting on 9/30/15.
//  Copyright © 2015 Randy Ting. All rights reserved.
//

import UIKit
import SwiftyJSON

let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class TwitterUser: NSObject {
  
  // MARK: - Constants
  static let currentUserKey = "kCurrentUserKey"
  
  // MARK: - Instance Properties
  let name: String!
  let screenname: String!
  let profileImageURL: String!
  
  // MARK: - Initialization
  init(dictionary: [String: JSON]){
    
    self.name = dictionary["name"]?.string
    self.screenname = dictionary["screen_name"]?.string
    self.profileImageURL = dictionary["profile_image_url"]?.string
    
    super.init()
    TwitterUser.currentUser = self
  }
  
  // MARK: - NSCoding
  
  required init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObjectForKey("name") as! String
    self.screenname = aDecoder.decodeObjectForKey("screenname") as! String
    self.profileImageURL = aDecoder.decodeObjectForKey("profileImageURL") as! String
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(name, forKey: "name")
    aCoder.encodeObject(screenname, forKey: "screenname")
    aCoder.encodeObject(profileImageURL, forKey: "profileImageURL")
  }
  
  // MARK: - Instance Methods
  func logout() {
    TwitterUser.currentUser = nil
    TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
    NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
  }
  
  // MARK: - Class Methods
  
  class func loginWithCompletion(completion: (user: TwitterUser?, error: NSError?) -> ()) {
    TwitterClient.sharedInstance.loginWithCompletion(completion)
  }
  
  
  // MARK: - Class Variables
  class var currentUser: TwitterUser?{
    get {
      if let archivedUser = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) {
        return NSKeyedUnarchiver.unarchiveObjectWithData(archivedUser as! NSData) as? TwitterUser
      }
      return nil
    }
    set(user) {
      if let user = user {
        let archivedUser = NSKeyedArchiver.archivedDataWithRootObject(user)
        NSUserDefaults.standardUserDefaults().setObject(archivedUser, forKey: currentUserKey)
      } else {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
      }
      NSUserDefaults.standardUserDefaults().synchronize()
    }
  }
  
}

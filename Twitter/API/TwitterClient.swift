//
//  TwitterClient.swift
//  Twitter
//
//  Created by Randy Ting on 9/29/15.
//  Copyright © 2015 Randy Ting. All rights reserved.
//

import UIKit
import SwiftyJSON

let twitterConsumerKey = "k1czNm79JKV5T5WLd8lPSSDBB"
let twitterConsumerSecret = "kJzE1C4Giq4MTHNVshWRgJqLDL7Mx4ShHSjS7ZmxzyQWvIoGLw"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
  
  private var loginCompletion: ((user: TwitterUser?, error: NSError?) -> ())?
  
  class var sharedInstance: TwitterClient {
    struct Static {
      static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
    }
    return Static.instance
  }
  
  // MARK: - Login
  
  func loginWithCompletion(completion: (user: TwitterUser?, error: NSError?) -> ()){
    loginCompletion = completion
    
    requestSerializer.removeAccessToken()
    fetchRequestTokenWithPath("oauth/request_token",
      method: "GET",
      callbackURL: NSURL(string: "randytwitterdemo://oauth"),
      scope: nil,
      success: {
        (requestToken: BDBOAuth1Credential!) -> Void in
        let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
        UIApplication.sharedApplication().openURL(authURL!)
      }) {
        (error: NSError!) -> Void in
        print(error.localizedDescription)
        self.loginCompletion?(user: nil, error: error)
    }
  }
  
  func openURL(url: NSURL) {
    fetchAccessTokenWithPath("oauth/access_token",
      method: "POST",
      requestToken: BDBOAuth1Credential(queryString: url.query),
      success: {
        (accessToken: BDBOAuth1Credential!) -> Void in
        print("Received Access Token")
        self.requestSerializer.saveAccessToken(accessToken)
        self.getLoggedInUser(self.loginCompletion)
      }) {
        (error: NSError!) -> Void in
        self.loginCompletion?(user: nil, error: error)
    }
  }
  
  private func getLoggedInUser(completion: ((user: TwitterUser?, error: NSError?) -> ())?){
    GET("/1.1/account/verify_credentials.json",
      parameters: nil,
      success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
        let userDetails = JSON.init(response)
        let currentUser = TwitterUser.init(dictionary: userDetails.dictionary!)
        completion?(user: currentUser, error: nil)
        
      }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
        completion?(user: nil, error: error)
    }
  }
  
  // MARK: - Access
  func homeTimelineWithParams(parameters: TwitterHomeTimelineParameters?, completion: (tweets: [Tweet]?, error: NSError? ) -> () ){
    
    self.GET("/1.1/statuses/home_timeline.json",
      parameters: parameters?.dictionary,
      success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
        let tweetsAsJSON  = JSON.init(response).array!
        let tweets = Tweet.tweets(array: tweetsAsJSON)
        completion(tweets: tweets, error: nil)
      }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
        completion(tweets: nil, error: error)
    }
    
  }
  
}

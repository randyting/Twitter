//
//  Tweet.swift
//  Twitter
//
//  Created by Randy Ting on 9/30/15.
//  Copyright © 2015 Randy Ting. All rights reserved.
//

import UIKit
import SwiftyJSON

class Tweet: NSObject {
  
  let createdAt: String!
  let favoriteCount: Int!
  let idString: String!
  let retweetCount: Int!
  let text: String!
  let userName: String!
  let userScreenname: String!
  
  var favorited: Bool!
  var retweeted: Bool!
  
  init(dictionary: [String: JSON]) {
    
    createdAt = dictionary["created_at"]!.string
    favoriteCount = dictionary["favorite_count"]?.int
    idString = dictionary["id_str"]?.string
    retweetCount = dictionary["retweet_count"]?.int
    text = dictionary["text"]?.string
    userName = dictionary["user"]!["name"].string
    userScreenname = dictionary["user"]!["screen_name"].string

    favorited = dictionary["favorited"]?.bool
    retweeted = dictionary["retweeted"]?.bool
    
    super.init()
  }
  
}

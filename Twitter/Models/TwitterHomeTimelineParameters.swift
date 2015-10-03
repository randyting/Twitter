//
//  TwitterHomeTimelineParameters.swift
//  Twitter
//
//  Created by Randy Ting on 10/2/15.
//  Copyright © 2015 Randy Ting. All rights reserved.
//

import UIKit

class TwitterHomeTimelineParameters: NSObject {
  
  var count: Int?
  var sinceId: Int?
  var maxId: Int?
  
  override init() {
    super.init()
  }
  
  func namesAndValues() -> [String:AnyObject?] {
    let dictionary: [String: AnyObject?] =
    [
      "count"   : self.count,
      "since_id": self.sinceId,
      "max_id"  : self.maxId
    ]
    
    return dictionary
  }
  


}

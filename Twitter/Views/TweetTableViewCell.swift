//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Randy Ting on 10/3/15.
//  Copyright © 2015 Randy Ting. All rights reserved.
//

import UIKit

@objc protocol TweetTableViewCellDelegate {
  optional func tweetTableViewCell(tweetTableViewCell: TweetTableViewCell, didLoadMediaImage: Bool) -> ()
}


class TweetTableViewCell: UITableViewCell {
  
  // MARK: - Storyboard Objects
  
  @IBOutlet private weak var profileImageView: UIImageView!
  @IBOutlet private weak var mediaImageView: UIImageView!
  @IBOutlet private weak var tweetTextLabel: UILabel!
  @IBOutlet private weak var timeSinceCreatedDXTimestampLabel: DXTimestampLabel!
  @IBOutlet private weak var userNameLabel: UILabel!
  @IBOutlet private weak var userScreenNameLabel: UILabel!
  
  @IBOutlet private weak var replyButton: UIButton!
  @IBOutlet private weak var retweetButton: UIButton!
  @IBOutlet private weak var retweetCountLabel: UILabel!
  
  @IBOutlet private weak var favoriteButton: UIButton!
  @IBOutlet private weak var favoriteCountLabel: UILabel!
  
  @IBOutlet private weak var followButton: UIButton!
  

  // MARK: - Properties
  weak var delegate: AnyObject?
  
  var tweet: Tweet! {
    didSet{
      profileImageView.setImageWithURL(tweet.profileImageURL)
      
//      if let mediaURL = tweet.mediaURL {
//        let mediaURLRequest = NSURLRequest(URL: mediaURL)
//        mediaImageView.setImageWithURLRequest(mediaURLRequest, placeholderImage: nil, success: { (request: NSURLRequest!, response: NSHTTPURLResponse!, image: UIImage!) -> Void in
//          dispatch_async(dispatch_get_main_queue(), { () -> Void in
////            self.mediaImageView.contentMode = UIViewContentMode.ScaleAspectFill
//            self.mediaImageView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,
////                                                      UIViewAutoresizing.FlexibleBottomMargin,
////                                                    UIViewAutoresizing.FlexibleLeftMargin,
////                                                    UIViewAutoresizing.FlexibleRightMargin,
////                                                    UIViewAutoresizing.FlexibleTopMargin,
////                                                    UIViewAutoresizing.FlexibleWidth
//            ]
//            
//            self.mediaImageView.image = image
////            self.mediaImageHeightConstraint.constant = image.size.height
////            self.setNeedsUpdateConstraints()
////            UIView.animateWithDuration(0.4, animations: {
////              self.layoutIfNeeded()
////            })
//            self.delegate?.tweetTableViewCell?(self, didLoadMediaImage: true)
//          })
//          }, failure: { (request: NSURLRequest!, response: NSHTTPURLResponse!, error: NSError!) -> Void in
//            print(error.localizedDescription)
//        })
//      }
      
      tweetTextLabel.text = tweet.text
      userNameLabel.text = tweet.userName
      userScreenNameLabel.text = "@" + tweet.userScreenname
      favoriteCountLabel.text = String(tweet.favoriteCount)
      retweetCountLabel.text = String(tweet.retweetCount)
      timeSinceCreatedDXTimestampLabel.timestamp = TwitterDateFormatter.sharedInstance.dateFromString(tweet.createdAt)
      
    }
  }
  
  // MARK: - Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  
}
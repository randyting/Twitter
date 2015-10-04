//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Randy Ting on 10/3/15.
//  Copyright © 2015 Randy Ting. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
  
  // MARK: - Storyboard Objects
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var mediaImageView: UIImageView!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var timeSinceCreationLabel: UILabel!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var userScreenNameLabel: UILabel!
  
  @IBOutlet weak var replyButton: UIButton!
  @IBOutlet weak var retweetButton: UIButton!
  @IBOutlet weak var retweetCountLabel: UILabel!
  
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var favoriteCountLabel: UILabel!
  
  @IBOutlet weak var followButton: UIButton!
  
  // MARK: - Properties
  var tweet: Tweet! {
    didSet{
      profileImageView.setImageWithURL(tweet.profileImageURL)
      if let mediaURL = tweet.mediaURL {
        mediaImageView.setImageWithURL(mediaURL)
      }
      tweetTextLabel.text = tweet.text
      
      userNameLabel.text = tweet.userName
      userScreenNameLabel.text = "@" + tweet.userScreenname
      favoriteCountLabel.text = String(tweet.favoriteCount)
      retweetCountLabel.text = String(tweet.retweetCount)
      
    }
  }
  
  // MARK: - Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}

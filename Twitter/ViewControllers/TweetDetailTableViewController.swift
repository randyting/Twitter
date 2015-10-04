//
//  TweetDetailTableViewController.swift
//
//
//  Created by Randy Ting on 10/4/15.
//
//

import UIKit

class TweetDetailTableViewController: UITableViewController {
  
  @IBOutlet private weak var tweetTextLabel: UILabel!
  @IBOutlet private weak var userScreennameLabel: UILabel!
  @IBOutlet private weak var profileImageView: UIImageView!
  @IBOutlet private weak var userNameLabel: UILabel!
  @IBOutlet private weak var createdTimeLabel: UILabel!
  
  @IBOutlet private weak var mediaImageView: UIImageView!
  @IBOutlet private weak var retweetCountLabel: UILabel!
  @IBOutlet private weak var favoriteCountLabel: UILabel!
  
  @IBOutlet private weak var favoriteButton: UIButton!
  @IBOutlet private weak var replyButton: UIButton!
  @IBOutlet private weak var retweetButton: UIButton!
  
  var tweet: Tweet!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    profileImageView.setImageWithURL(tweet.profileImageURL)
    tweetTextLabel.text = tweet.text
    userNameLabel.text = tweet.userName
    userScreennameLabel.text = "@" + tweet.userScreenname
    favoriteCountLabel.text = String(tweet.favoriteCount)
    retweetCountLabel.text = String(tweet.retweetCount)
    
//    self.tableView.estimatedRowHeight = 100
//    self.tableView.rowHeight = UITableViewAutomaticDimension

    
//    view.setNeedsUpdateConstraints()
//    UIView.animateWithDuration(0.4, animations: {
//      self.view.layoutIfNeeded()
//    })
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

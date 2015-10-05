//
//  TweetDetailTableViewController.swift
//
//
//  Created by Randy Ting on 10/4/15.
//
//

import UIKit

class TweetDetailTableViewController: UITableViewController {
  
  // MARK: - Constants
  private let replyToTweetSegueIdentifier = "ReplyToTweetSegue"
  
  // MARK: - Storyboard Objects
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
  
  // MARK: - Properties
  var tweet: Tweet!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    updateContent()
  }
  
  // MARK: - Setup
  private func updateContent() {
    profileImageView.setImageWithURL(tweet.profileImageURL)
    tweetTextLabel.text = tweet.text
    userNameLabel.text = tweet.userName
    userScreennameLabel.text = "@" + tweet.userScreenname
    favoriteCountLabel.text = String(tweet.favoriteCount)
    retweetCountLabel.text = String(tweet.retweetCount)
    createdTimeLabel.text = TwitterDetailDateFormatter.sharedInstance.stringFromDate(TwitterDateFormatter.sharedInstance.dateFromString(tweet.createdAt)!)
    if tweet.favorited == true {
      favoriteButton.setImage(UIImage(named: "favorite_on"), forState: UIControlState.Normal)
    } else {
      favoriteButton.setImage(UIImage(named: "favorite"), forState: UIControlState.Normal)
    }
    if tweet.retweeted == true {
      retweetButton.setImage(UIImage(named: "retweet_on"), forState: UIControlState.Normal)
    } else {
      retweetButton.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
    }
  }
  
  // MARK: - Behavior
  @IBAction func onTapFavoriteButton(sender: AnyObject) {
    if tweet.favorited == true{
      TwitterUser.unfavorite(tweet) { (response, error) -> () in
        if let error = error {
          print("Unfavorite Error: \(error.localizedDescription)")
        } else {
          self.updateContent()
        }
      }
    } else {
      TwitterUser.favorite(tweet) { (response, error) -> () in
        if let error = error {
          print("Favorite Error: \(error.localizedDescription)")
        } else {
          self.updateContent()
        }
      }
    }
  }

  @IBAction func onTapRetweet(sender: AnyObject) {
    if tweet.retweeted == true{
      TwitterUser.unretweet(tweet) { (response, error) -> () in
        if let error = error {
          print("Unretweet Error: \(error.localizedDescription)")
        } else {
          self.updateContent()
        }
      }
    } else {
      TwitterUser.retweet(tweet) { (response, error) -> () in
        if let error = error {
          print("Retweet Error: \(error.localizedDescription)")
        } else {
          self.updateContent()
        }
      }
    }
  }
  
  @IBAction func onTapReplyButton(sender: AnyObject) {
    performSegueWithIdentifier(replyToTweetSegueIdentifier, sender: self)
  }

  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == replyToTweetSegueIdentifier {
      let vc = segue.destinationViewController as? NewTweetViewController
      vc?.inReplyToUserScreenname = tweet.userScreenname
      vc?.inReplyToStatusID = tweet.idString
    }
  }
  
}

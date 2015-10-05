//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Randy Ting on 10/2/15.
//  Copyright © 2015 Randy Ting. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
  
  // MARK: - Constants
  private let tweetsCellReuseIdentifier = "tweetsCellReuseIdentifier"
  private let newTweetSegueIdentifier = "NewTweetSegue"
  private let tweetDetailSegueIdentifier = "TweetDetailTableViewControllerSegue"
  private let replyFromTweetsViewSegueIdentifier = "ReplyFromTweetsViewSegue"
  
  // MARK: - Properities
  private var currentUser: TwitterUser!
  private var tweets: [Tweet]?
  private let refreshControl = UIRefreshControl()
  
  // MARK: - Storyboard
  @IBOutlet weak var tweetsTableView: UITableView!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTweetsTableView(tweetsTableView)
    setupRefreshControl(refreshControl)
    setupInitialValues()
    
  }
  
  override func viewWillAppear(animated: Bool) {
    refreshTweets()
  }
  
  // MARK: - Initial Setup
  private func setupTweetsTableView(tableView: UITableView){
    tableView.dataSource = self
    tableView.delegate = self
    tableView.estimatedRowHeight = 300
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  private func setupInitialValues(){
    title = "Home"
    currentUser = TwitterUser.currentUser
    refreshTweets()
  }
  
  private func loadFiveTweets() {
    currentUser = TwitterUser.currentUser
    let params = TwitterHomeTimelineParameters()
    params.count = 5
    currentUser.homeTimelineWithParams(params) { (tweets, error) -> () in
      self.tweets = tweets
      self.tweetsTableView.reloadData()
    }
  }
  
  private func setupRefreshControl(refreshControl: UIRefreshControl) {
    refreshControl.addTarget(self, action: "refreshTweets", forControlEvents: .ValueChanged)
    tweetsTableView.insertSubview(refreshControl, atIndex: 0)
  }
  
  // MARK: - Behavior
  
  @IBAction func onLogoutButtonTapped(sender: UIBarButtonItem) {
    TwitterUser.currentUser?.logout()
  }
  
  func refreshTweets(){
    currentUser.homeTimelineWithParams(nil) { (tweets, error) -> () in
      self.tweets = tweets
      self.tweetsTableView.reloadData()
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        self.refreshControl.endRefreshing()
      })
    }
  }
  
  // MARK: - Navigation
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == newTweetSegueIdentifier {
      let vc = segue.destinationViewController as? NewTweetViewController
      vc?.currentUser = currentUser
      vc?.delegate = self
    } else if segue.identifier == tweetDetailSegueIdentifier{
      let cell = sender as? TweetTableViewCell
      let vc = segue.destinationViewController as? TweetDetailTableViewController
      vc?.tweet = tweets![tweetsTableView.indexPathForCell(cell!)!.row]
    } else if segue.identifier == replyFromTweetsViewSegueIdentifier {
      print("from reply button in table view")
      let replyButton = sender as? UIButton
      let cell = replyButton?.superview?.superview as? TweetTableViewCell
      let vc = segue.destinationViewController as? NewTweetViewController
      vc?.inReplyToUserScreenname = cell?.tweet.userScreenname
      vc?.inReplyToStatusID = cell?.tweet.idString      
    }
  }
  
}

  // MARK: - UITableView Delegate and Datasource

extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tweetsTableView.dequeueReusableCellWithIdentifier(tweetsCellReuseIdentifier, forIndexPath: indexPath) as! TweetTableViewCell
    
    cell.tweet = tweets?[indexPath.row]
    cell.delegate = self
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let tweets = tweets {
      return tweets.count
    } else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
}

  // MARK: - TweetTableViewCell Delegate

extension TweetsViewController: TweetTableViewCellDelegate {
  func tweetTableViewCell(tweetTableViewCell: TweetTableViewCell, didLoadImage: Bool) {
    tweetsTableView.reloadData()
//    dispatch_async(dispatch_get_main_queue()) { () -> Void in
//      self.tweetsTableView.setNeedsUpdateConstraints()
//      UIView.animateWithDuration(0.4, animations: {
//        self.tweetsTableView.layoutIfNeeded()
//      })
//    }

  }
}

  // MARK: - NewTweetViewController Delegate

extension TweetsViewController: NewTweetViewControllerDelegate {
  func newTweetViewController(newTweetViewController: NewTweetViewController, didPostTweetText: String) {
    //
  }
}

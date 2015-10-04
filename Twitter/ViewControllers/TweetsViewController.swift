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
  
  // MARK: - Properities
  var currentUser: TwitterUser!
  var tweets: [Tweet]?
  
  // MARK: - Storyboard
  @IBOutlet weak var tweetsTableView: UITableView!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTweetsTableView(tweetsTableView)
    setupInitialValues()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
    currentUser.homeTimelineWithParams(nil) { (tweets, error) -> () in
      self.tweets = tweets
      self.tweetsTableView.reloadData()
    }
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
  
  // MARK: - Behavior
  
  @IBAction func onLogoutButtonTapped(sender: UIBarButtonItem) {
    TwitterUser.currentUser?.logout()
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

// MARK: - UITableView Delegate and Datasource

extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tweetsTableView.dequeueReusableCellWithIdentifier(tweetsCellReuseIdentifier, forIndexPath: indexPath) as! TweetTableViewCell
    
    cell.tweet = tweets?[indexPath.row]
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let tweets = tweets {
      return tweets.count
    } else {
      return 0
    }
  }
  
  
}

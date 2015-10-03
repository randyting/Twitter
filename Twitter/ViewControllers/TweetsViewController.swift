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
  
  // MARK: - Storyboard
  @IBOutlet weak var tweetsTableView: UITableView!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTweetsTableView(tweetsTableView)
    title = "Home"
    currentUser = TwitterUser.currentUser

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Initial Setup
  private func setupTweetsTableView(tableView: UITableView){
    tableView.dataSource = self
    tableView.delegate = self
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
    let cell = tweetsTableView.dequeueReusableCellWithIdentifier(tweetsCellReuseIdentifier, forIndexPath: indexPath)
    
    cell.textLabel!.text = currentUser.name
    
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  
}

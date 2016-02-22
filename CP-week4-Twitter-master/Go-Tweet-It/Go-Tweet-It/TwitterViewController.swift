//
//  TwitterViewController.swift
//  Go-Tweet-It
//
//  Created by Tyler Anthony on 2/22/16.
//  Copyright © 2016 FlyGuy. All rights reserved.
//

import UIKit

class TwitterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets : [Tweet]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 250
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets {
                print(tweet.text)
                self.tableView.reloadData()
            }
            }, failure: {(error: NSError!) -> () in
                print(error.localizedDescription)
        })
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row]
        
        // Profile image
        cell.profileImageView.setImageWithURL(tweet.profileImageView!)
        cell.profileImageView.layer.cornerRadius = 3
        cell.profileImageView.clipsToBounds = true
        
        // User name
        cell.userNameLabel.text = tweet.userNameLabel
        
        // Twitter handle
        cell.userHandle.text = "@\(tweet.tweeterHandle)"
        
        // tweet message (Tweet text)
        cell.tweetTextLabel.text = tweet.text as? String
        cell.tweetTextLabel.sizeToFit()
        
        
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
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

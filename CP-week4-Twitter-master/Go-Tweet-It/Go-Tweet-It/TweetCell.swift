//
//  TweetCell.swift
//  Go-Tweet-It
//
//  Created by Tyler Anthony on 2/22/16.
//  Copyright © 2016 FlyGuy. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    var tweet: Tweet?
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userHandle: UILabel!

    @IBOutlet weak var timeStampLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favoritesCountLabel: UILabel!
    
    @IBOutlet weak var retweetImageView: UIButton!
    
    @IBOutlet weak var favoriteTweetLabel: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    @IBAction func retweetAction(sender: AnyObject) {
        if(tweet?.retweeted == 0){
            retweetCountLabel.textColor = UIColor.greenColor()
            tweet?.retweeted = 1
            
            var previousRetweetCount  = Int(self.retweetCountLabel.text!)
            previousRetweetCount = previousRetweetCount! + 1
            self.retweetCountLabel.text = String(previousRetweetCount!)
            
        }
        else{
            retweetCountLabel.textColor = UIColor.grayColor()
            tweet?.retweeted = 0
            
            var previousRetweetCount = Int(self.retweetCountLabel.text!)
            previousRetweetCount = previousRetweetCount! - 1
            self.retweetCountLabel.text = String(previousRetweetCount!)
            
        }
    
    }
    
}




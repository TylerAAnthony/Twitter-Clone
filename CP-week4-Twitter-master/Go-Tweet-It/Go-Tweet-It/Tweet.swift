//
//  Tweet.swift
//  Go-Tweet-It
//
//  Created by Tyler Anthony on 2/20/16.
//  Copyright © 2016 FlyGuy. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profileImageView : NSURL?
    var userNameLabel : String?
    var tweeterHandle: String?
    
    var favorited: Int = 0
    var retweeted: Int = 0
    
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let user = dictionary["user"]
        print(user)
        
   
        profileImageView = NSURL(string: (user!["profile_image_url"] as! String))
        
        userNameLabel = user!["name"] as? String
        

        tweeterHandle = user!["screen_name"] as? String
        

        favorited = dictionary["favorited"] as! Int
        retweeted = dictionary["retweeted"] as! Int
        
     
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
    
}

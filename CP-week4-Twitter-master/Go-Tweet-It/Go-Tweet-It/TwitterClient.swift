//
//  TwitterClient.swift
//  Go-Tweet-It
//
//  Created by Tyler Anthony on 2/22/16.
//  Copyright © 2016 FlyGuy. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class TwitterClient: BDBOAuth1SessionManager {
   
        
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "2aECfkwjz58HxlgeLHbWNzH2E", consumerSecret: "My3Yudfagckxu8OpFMa0xKcL1ceIguOiMRxUeGNTDPDUn8TRWB")
        var loginSuccess: (() -> ())?
        var loginFailure: ((NSError) -> ())?
        func login(success: () -> (), failure: (NSError) -> ()) {
            loginSuccess = success
            loginFailure = failure
            TwitterClient.sharedInstance.deauthorize()
            TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "Go-Tweet-It://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
                print("I got a token!")
                
                let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
                UIApplication.sharedApplication().openURL(url)
                
                }) {( error: NSError!) -> Void in
                    print("error: \(error.localizedDescription)")
                    self.loginFailure?(error)
            }
            
        }
        
        func logout() {
            User._currentUser = nil
            deauthorize()
            NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
            
        }
        
        func handleOpenUrl(url: NSURL) {
            let requestToken = BDBOAuth1Credential(queryString: url.query)
            fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (
                accessToken: BDBOAuth1Credential!) -> Void in
                print("I got the access token!")
                
                self.currentAccount({ (user: User) -> () in
                    User.currentUser = user
                    }, failure: { (error: NSError) -> () in
                        self.loginFailure?(error)
                })
                self.loginSuccess?()
                
                
                }) { (error: NSError!) -> Void in
                    print("error: \(error.localizedDescription)")
                    self.loginFailure?(error)
            }    }
        
        
    
        func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
            GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil,
                success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                    let dictionaries = response as! [NSDictionary]
                    
                    let tweets = Tweet.tweetsWithArray(dictionaries)
                    
                    success(tweets)
                }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                    failure(error)
            })
            
        }
        
        
        
        // Get current user
        func currentAccount(success: (User) -> (), failure: (NSError)->()) {
            GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("account: \(response)")
                let userDictionary = response as! NSDictionary
                let user = User(dictionary: userDictionary)
                
                success(user)
                
                }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                    failure(error)
            })
        }
        
        
}


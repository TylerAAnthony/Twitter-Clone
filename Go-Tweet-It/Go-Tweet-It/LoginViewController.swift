//
//  LoginViewController.swift
//  Go-Tweet-It
//
//  Created by Tyler Anthony on 2/20/16.
//  Copyright © 2016 FlyGuy. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(sender: AnyObject) {
        let twitterClient = BDBOAuth1SessionManager(baseURL:NSURL(string: "https://api.twitter.com")!, consumerKey: "2aECfkwjz58HxlgeLHbWNzH2E", consumerSecret:"My3Yudfagckxu8OpFMa0xKcL1ceIguOiMRxUeGNTDPDUn8TRWB")
        
        twitterClient.deauthorize()//Clears key chain of all previous sessions
        
        // Code to to get request token and let user authorize app
        twitterClient.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "Go-Tweet-It://oauth"), scope: nil, success: {(requestToken:BDBOAuth1Credential!) -> Void in
            print("Got Request Token")
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url) //tell program to open the link in something else in this case it is a url so it opens in safari
            
            })
            { (error:NSError!) -> Void in
            print("error: \(error.localizedDescription)")
        }
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

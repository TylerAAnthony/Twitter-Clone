//
//  User.swift
//  Go-Tweet-It
//
//  Created by Tyler Anthony on 2/20/16.
//  Copyright © 2016 FlyGuy. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        screenname = dictionary["screen"] as? String
        
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
        
        tagline = dictionary["description"] as? String
    }
    
    
}




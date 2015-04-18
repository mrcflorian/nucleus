//
//  HomeViewController.swift
//  Nucleus
//
//  Created by Florian Marcu on 4/7/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

import UIKit
import NucleusFramework

class HomeViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        self.setupHomeScreenForFacebookUser();
    }
    
    func setupHomeScreenForFacebookUser()
    {
        if FBSDKAccessToken.currentAccessToken() == nil {
            return
        }

        NLFNucleusAPI.getRequest("http://www.hickery.net/api/likes.php?user_id=99100000181006895")

        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
            }
            else
            {
                println("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as NSString
                println("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as NSString
                println("User Email is: \(userEmail)")
            }
        })
    }
}

//
//  LoginViewController.swift
//  Nucleus
//
//  Created by Florian Marcu on 4/7/15.
//  Copyright (c) 2015 Florian Marcu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let permissions: [AnyObject] = ["email", "public_profile", "user_friends", "user_location"]
    
    @IBAction func didPressFbLoginButton(sender: UIButton) {
        FBSDKLoginManager().logInWithReadPermissions(permissions, handler: handleFacebookLoginResponse)
    }
    
    func handleFacebookLoginResponse(result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if error != nil {
            self.handleFacebookLoginError(error)
        } else if (result.isCancelled) {
            self.handleFacebookLoginCancellation(result)
        } else {
            self.handleFacebookLoginSuccess(result);
        }
    }
    
    func handleFacebookLoginError(error: NSError!)
    {
    }
    
    func handleFacebookLoginCancellation(result: FBSDKLoginManagerLoginResult!)
    {
    }
    
    func handleFacebookLoginSuccess(result: FBSDKLoginManagerLoginResult!)
    {
        if result.grantedPermissions.containsObject("email") {
            let homeVC = HomeViewController()
            self.presentViewController(homeVC, animated: true, completion: nil)
        }
    }
}


//
//  LoginViewController.swift
//  On The Map
//
//  Created by Suvam Paul on 1/4/16.
//  Copyright © 2016 Suvam Paul. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!

    //still need a label
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /* Get the shared URL session */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonTouch(sender: AnyObject) {
        
        UdacityClient.sharedInstance().authenticateWithUdacityServer(self.emailTextField!.text!, password: self.passwordTextField!.text!) {(success, errorString) in
            if success {
                self.completeLogin()
            } else {
                self.displayError(errorString)
            }
        }
    }
    
    
//    func completeLogin() {
//        dispatch_async(dispatch_get_main_queue(), {
//            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MapViewController")
//            self.presentViewController(controller, animated: true, completion: nil)
//        })
//    }
//    
    
    func completeLogin() {
        dispatch_async(dispatch_get_main_queue(), {
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
            self.presentViewController(controller, animated: true, completion: nil)
        })
    }
    
    func displayError(errorString: NSError?) {
        dispatch_async(dispatch_get_main_queue(), {
            if let errorString = errorString {
                print(errorString)
            }
        })
    }
}
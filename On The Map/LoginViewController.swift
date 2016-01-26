//
//  LoginViewController.swift
//  On The Map
//
//  Created by Suvam Paul on 1/4/16.
//  Copyright © 2016 Suvam Paul. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!

    //still need a label
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }


    
    @IBAction func loginButtonTouch(sender: AnyObject) {
        
        UdacityClient.sharedInstance().authenticateWithUdacityServer(self.emailTextField!.text!, password: self.passwordTextField!.text!) {(success, errorString) in
            
            if success {
                self.completeLogin()
                
            } else {
                
                self.presentAlert(errorString)

            }
            
        }
        
    }
    
    
    @IBAction func signupUdacity(sender: AnyObject) {
        let app = UIApplication.sharedApplication()
        app.openURL(NSURL(string: "https://www.udacity.com/account/auth#!/signup")!)
    }
    
    
    func completeLogin() {
        dispatch_async(dispatch_get_main_queue(), {
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
            self.presentViewController(controller, animated: true, completion: nil)
        })
    }
    
    
    func presentAlert(errorString: NSError?) {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            let action: UIAlertController = UIAlertController(title: "Login Failed", message: "\(errorString?.description)", preferredStyle: .ActionSheet)
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                //Dismiss the action sheet
            }
            
            action.addAction(cancelAction)
            
            self.presentViewController(action, animated: true, completion: nil)
            
        })
    
    }
    
    
    //functions for textfield
    
    //keyboard disappears when return button is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    //dismiss keyboard
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
}
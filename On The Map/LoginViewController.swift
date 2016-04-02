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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }


    
    @IBAction func loginButtonTouch(sender: AnyObject) {

        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            self.presentAlertString("Please enter valid e-mail or password")
        }
        
        if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
            UdacityClient.sharedInstance().authenticateWithUdacityServer(self.emailTextField!.text!, password: self.passwordTextField!.text!)
            {(success, error) in
                
                
                if success {
                   
                    self.completeLogin()
                
                } else {
                    dispatch_async(dispatch_get_main_queue()) {
                        let alert = UIAlertController(title: "Udacity login failed", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                            // Do nothing
                        }))
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    
    
    @IBAction func signupUdacity(sender: AnyObject) {
        let app = UIApplication.sharedApplication()
        app.openURL(NSURL(string: "https://www.udacity.com/account/auth#!/signup")!)
    }

    
    
    func completeLogin() {
        
        if StudentInfo.userID == "" {
            
            self.presentAlertString("Login attempt failed- please try again")
            
        } else {

            dispatch_async(dispatch_get_main_queue(), {
                let controller = self.storyboard!.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
                self.presentViewController(controller, animated: true, completion: nil)
            })

        }
        
    }
    
    
    
    
    func presentAlertString(errorString: String?) {
        
        dispatch_async(dispatch_get_main_queue()) {
            let alert = UIAlertController(title: "Udacity login failed", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                // Do nothing
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
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
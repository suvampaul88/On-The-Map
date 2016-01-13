//
//  ViewWhenLoginSuccessfulController.swift
//  On The Map
//
//  Created by Suvam Paul on 1/5/16.
//  Copyright © 2016 Suvam Paul. All rights reserved.
//

import Foundation
import UIKit

class ViewWhenLoginSuccessfulController: UIViewController {

    
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func logoutUdacity(sender: AnyObject) {
        UdacityClient.sharedInstance().logoutUdacity() {(success, ID, error) in
            if success {
                self.completeLogout()
                //alternatives
                //self.dismissViewControllerAnimated(true, completion: nil)
                //http://stackoverflow.com/questions/25962693/dismissviewcontrolleranimated-does-not-dismiss-view-controller
            } else {
                self.displayError(error)
            }
        }
    }
        
    
    func completeLogout() {
        dispatch_async(dispatch_get_main_queue(), {
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("SigninPage") as! ViewController
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
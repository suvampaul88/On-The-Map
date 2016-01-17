//
//  UdacityConvenience.swift
//  On The Map
//
//  Created by Suvam Paul on 1/6/16.
//  Copyright © 2016 Suvam Paul. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    
    func authenticateWithUdacityServer(username: String, password: String, completionHandler: (success: Bool, errorString: NSError?) -> Void) {
        
        self.loginThroughUdacity(username, password: password) { (success, userID, error) in

            if success {
 
                if let userID = userID {

                    self.userID = userID
                    print(self.userID)
                    self.getPublicUserData() {(success, address, error) in
                        
                        if success {
                            self.emailAddress = address
                            print(address)
                        } else {
                            completionHandler(success: success, errorString: error)
                        }
                    }
                        completionHandler(success: success, errorString: error)
                    }
            } else {
                completionHandler(success: success, errorString: error)
            }
            
        }
    }
    

    
    func loginThroughUdacity(username: String, password: String, completionHandler: (Success: Bool, userID: String?, error: NSError?) -> Void)  {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let userinfo : [String: String] =  [UdacityClient.JSONBodyKeys.Username : username, UdacityClient.JSONBodyKeys.Password : password]
        let jsonBody : [String:AnyObject] = [UdacityClient.JSONBodyKeys.Domain: userinfo]
        
//        let jsonBody : [String: AnyObject] = ["udacity": ["username": "\(username)", "password": "\(password)"]]

        /* 2. Make the request */
        taskForPOSTMethod(Methods.Session, parameters: nil, jsonBody: jsonBody) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(Success: false, userID: nil, error: error)
            } else {
                if let results = JSONResult[UdacityClient.JSONResponseKeys.Account] as? [String: AnyObject] {
                    let userID = results[UdacityClient.JSONResponseKeys.UserKey] as? String
                    completionHandler(Success: true, userID: userID, error: nil)
                    print(userID)
                } else {
                    completionHandler(Success: false, userID: nil, error: NSError(domain: "Login parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse loginThroughUdacity"]))
                }
            }
        }
    }
    
    
    
    func logoutUdacity(completionHandler: (Success: Bool, ID: String?, error: NSError?) -> Void) {
        
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        //There are none

        
        /* 2. Make the request */
        taskForDELETEMethod(Methods.Session, parameters: nil) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(Success: false, ID: nil, error: error)
            } else {
                if let results = JSONResult[UdacityClient.JSONResponseKeys.Session] as? [String: AnyObject] {
                    let ID = results[UdacityClient.JSONResponseKeys.ID] as? String
                    completionHandler(Success: true, ID: ID, error: nil)
                    print(ID)
            } else {
                completionHandler(Success: false, ID: nil, error: NSError(domain: "Logout Parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse logout Udacity"]))
                }
            }
        }
    }
    
    
    
    func getPublicUserData(completionHandler: (success: Bool, address: String?, error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        var mutableMethod : String = Methods.Users
        mutableMethod = UdacityClient.subtituteKeyInMethod(mutableMethod, key: UdacityClient.URLKeys.UserID, value: String(UdacityClient.sharedInstance().userID!))!
        
        /* 2. Make the request */
        taskForGETMethod(mutableMethod, parameters: nil) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(success: false, address: nil, error: error)
            } else {
                
                if let results = JSONResult[UdacityClient.JSONResponseKeys.User] as? [String : AnyObject] {
                    
                    if let email = results[UdacityClient.JSONResponseKeys.Email] as? [String : AnyObject] {
                        let address = email[UdacityClient.JSONResponseKeys.Address] as? String
                        completionHandler(success: true, address: address, error: error)
                        print(address)
                    } else {
                        completionHandler(success: false, address: nil, error: NSError(domain: "getPublicUserData parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse email"]))
                    }
                    
                    //getting email didn't work
                } else {
                    completionHandler(success: false, address: nil, error: NSError(domain: "getPublicUserData parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse results"]))
                }
            }
        }
    }
}
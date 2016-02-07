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
                    
                    StudentInfo.userID = userID
        
                    self.getPublicUserData() {(success, firstName, lastName, error) in
                        
                        if success {
                            
                            StudentInfo.firstName = firstName!
                            StudentInfo.lastName = lastName!
                        
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
        

        /* 2. Make the request */
        taskForPOSTMethod(UdacityClient.Methods.Session, parameters: nil, jsonBody: jsonBody) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(Success: false, userID: nil, error: error)
            } else {
                if let results = JSONResult[UdacityClient.JSONResponseKeys.Account] as? [String: AnyObject] {
                    let userID = results[UdacityClient.JSONResponseKeys.UserKey] as? String
                    completionHandler(Success: true, userID: userID, error: nil)
                } else {
                    completionHandler(Success: false, userID: nil, error: NSError(domain: "Login parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse loginThroughUdacity"]))
                }
            }
        }
    }
    
    
    
    func logoutUdacity(completionHandler: (success: Bool, ID: String?, error: NSError?) -> Void) {
        
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        //There are none

        
        /* 2. Make the request */
        taskForDELETEMethod(UdacityClient.Methods.Session, parameters: nil) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(success: false, ID: nil, error: error)
            } else {
                if let results = JSONResult[UdacityClient.JSONResponseKeys.Session] as? [String: AnyObject] {
                    let ID = results[UdacityClient.JSONResponseKeys.ID] as? String
                    completionHandler(success: true, ID: ID, error: nil)
            } else {
                completionHandler(success: false, ID: nil, error: NSError(domain: "Logout Parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse logout Udacity"]))
                }
            }
        }
    }
    
    
    
    func getPublicUserData(completionHandler: (success: Bool, firstName: String?, lastName: String?, error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        var mutableMethod : String = UdacityClient.Methods.Users
        mutableMethod = UdacityClient.subtituteKeyInMethod(mutableMethod, key: UdacityClient.URLKeys.UserID, value: String(StudentInfo.userID))!
        
        /* 2. Make the request */
        taskForGETMethod(mutableMethod, parameters: nil) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(success: false, firstName: nil, lastName: nil, error: error)
            } else {
                
                if let results = JSONResult[UdacityClient.JSONResponseKeys.User] as? [String : AnyObject] {

                    let firstName =  results[UdacityClient.JSONResponseKeys.FirstName] as? String
                    let lastName = results[UdacityClient.JSONResponseKeys.LastName] as? String
                    completionHandler(success: true, firstName: firstName, lastName: lastName, error: nil)

                } else {
                    completionHandler(success: false, firstName: nil, lastName: nil, error: NSError(domain: "getPublicUserData parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse results"]))
                }
            }
        }
    }
}
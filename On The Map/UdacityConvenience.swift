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
                }
                
                completionHandler(success: success, errorString: error)
            }
        }
    }
    
    
    func loginThroughUdacity(username: String, password: String, completionHandler: (Success: Bool, userID: String?, error: NSError?) -> Void)  {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let userinfo : [String: String] =  [UdacityClient.JSONBodyKeys.Username : username, UdacityClient.JSONBodyKeys.Password : password]
        let jsonBody : [String:AnyObject] = [
            UdacityClient.JSONBodyKeys.Domain: userinfo]
        
//        let jsonBody : [String: AnyObject] = ["udacity": ["username": "\(username)", "password": "\(password)"]]

        /* 2. Make the request */
        taskForPOSTMethod(Methods.Session, parameters: nil, jsonBody: jsonBody) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(Success: false, userID: nil, error: error)
            } else {
                if let results = JSONResult[UdacityClient.JSONResponseKeys.Account] as? [String: AnyObject] {
                    let userID = results[UdacityClient.JSONResponseKeys.userKey] as? String
                    completionHandler(Success: true, userID: userID, error: nil)
                } else {
                    completionHandler(Success: false, userID: nil, error: NSError(domain: "Login parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse loginThroughUdacity"]))
                }
            }
        }
    }
}
//
//  ParseConvenience.swift
//  On The Map
//
//  Created by Suvam Paul on 1/20/16.
//  Copyright © 2016 Suvam Paul. All rights reserved.
//

import Foundation

import Foundation

extension ParseClient {

    // MARK: GET Convenience Methods
    func getStudentLocations(completionHandler: (result: [StudentLocations]?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        
        /* 2. Make the request */
        let task = taskForGETMethod(ParseClient.Methods.StudentLocation, parameters: nil) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                
                if let results = JSONResult[ParseClient.JSONResponseKeys.Results] as? [[String : AnyObject]] {
                    
                    let locations =  StudentLocations.locationsFromResults(results)
                    completionHandler(result: locations, error: nil)
                } else {
                    completionHandler(result: nil, error: NSError(domain: "getStudentLocations parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocations parsing"]))
                }
            }
        }
        
        return task
    }

    
//    // MARK: POST Convenience Methods
//    func postStudentLocations(completionHandler: (Success: Bool, createdAT: String?, error: NSError?) -> Void)  {
//        
//        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
//        let jsonBody : [String:AnyObject] = [UdacityClient.JSONBodyKeys.Domain: userinfo]
//        
////        request.HTTPBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Cupertino, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.322998, \"longitude\": -122.032182}".dataUsingEncoding(NSUTF8StringEncoding)
//        
//        
//        /* 2. Make the request */
//        taskForPOSTMethod(UdacityClient.Methods.Session, parameters: nil, jsonBody: jsonBody) { JSONResult, error in
//            
//            /* 3. Send the desired value(s) to completion handler */
//            if let error = error {
//                completionHandler(Success: false, userID: nil, error: error)
//            } else {
//                if let results = JSONResult[UdacityClient.JSONResponseKeys.Account] as? [String: AnyObject] {
//                    let userID = results[UdacityClient.JSONResponseKeys.UserKey] as? String
//                    completionHandler(Success: true, userID: userID, error: nil)
//                    print(userID)
//                } else {
//                    completionHandler(Success: false, userID: nil, error: NSError(domain: "Login parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse loginThroughUdacity"]))
//                }
//            }
//        }
//    }
//    



}
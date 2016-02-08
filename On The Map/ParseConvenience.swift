//
//  ParseConvenience.swift
//  On The Map
//
//  Created by Suvam Paul on 1/20/16.
//  Copyright © 2016 Suvam Paul. All rights reserved.
//

import Foundation

extension ParseClient {

    // MARK: GET Convenience Methods
    func getStudentLocations(completionHandler: (success: Bool, result: [StudentLocations]?, error: NSError?) -> Void) -> NSURLSessionDataTask? {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [ParseClient.JSONBodyKeys.Limit: ParseClient.Constants.Number]
        
        /* 2. Make the request */
        let task = taskForGETMethod(ParseClient.Methods.StudentLocation, parameters: parameters) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(success: false, result: nil, error: error)
            } else {
                
                if let results = JSONResult[ParseClient.JSONResponseKeys.Results] as? [[String : AnyObject]] {
                    
                    let locations =  StudentLocations.locationsFromResults(results)
                    completionHandler(success: true, result: locations, error: nil)
                } else {
                    completionHandler(success: false, result: nil, error: NSError(domain: "getStudentLocations parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocations parsing"]))
                }
            }
        }
        
        return task
    }

    
    // MARK: POST Convenience Methods
    func postStudentLocations(mapString: String, mediaURL: String, latitude: Double, longitude: Double, completionHandler: (Success: Bool, createdAt: String?, error: NSError?) -> Void)  {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let jsonBody : [String:AnyObject] = [ParseClient.JSONBodyKeys.UniqueKey: StudentInfo.userID, ParseClient.JSONBodyKeys.FirstName: StudentInfo.firstName, ParseClient.JSONBodyKeys.LastName: StudentInfo.lastName, ParseClient.JSONBodyKeys.MapString: mapString, ParseClient.JSONBodyKeys.MediaURL: mediaURL, ParseClient.JSONBodyKeys.Latitude: latitude, ParseClient.JSONBodyKeys.Longitude: longitude]

    
        /* 2. Make the request */
        taskForPOSTMethod(ParseClient.Methods.StudentLocation, parameters: nil, jsonBody: jsonBody) { JSONResult, error in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandler(Success: false, createdAt: nil, error: error)
            } else {
                if let createdAt = JSONResult[ParseClient.JSONResponseKeys.CreatedAt] as? String {
                    completionHandler(Success: true, createdAt: createdAt, error: nil)
                } else {
                    completionHandler(Success: false, createdAt: nil, error: NSError(domain: "postStudentLocations parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postStudentLocations"]))
                }
            }
        }
    }
    



}
//
//  StudentLocations.swift
//  On The Map
//
//  Created by Suvam Paul on 1/22/16.
//  Copyright © 2016 Suvam Paul. All rights reserved.
//

import Foundation

struct StudentLocations {
    
    // MARK: Properties
    
    var objectID = ""
    var uniqueKey = ""
    var firstName = ""
    var lastName = ""
    var mapString = ""
    var mediaURL = ""
    var latitude: Float = 0
    var longitude: Float = 0
    var createdAt = ""


    // MARK: Initializers
    
    /* Construct a database from a dictionary */
    init(dictionary: [String : AnyObject]) {
        
        objectID = dictionary[ParseClient.JSONResponseKeys.ObjectId] as! String
        uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as! String
        firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as! String
        lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as! String
        mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as! String
        mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaURL] as! String
        latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as! Float
        longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as! Float
        createdAt = dictionary[ParseClient.JSONResponseKeys.CreatedAt] as! String
        
    }
    
    /* Helper: Given an array of dictionaries, convert them to an array of TMDBMovie objects */
    static func locationsFromResults(results: [[String : AnyObject]]) -> [StudentLocations] {
        var studentlocations = [StudentLocations]()
        
        for result in results {
            studentlocations.append(StudentLocations(dictionary: result))
        }
        return studentlocations
    }
}

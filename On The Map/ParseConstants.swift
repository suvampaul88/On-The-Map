//
//  ParseConstants.swift
//  On The Map
//
//  Created by Suvam Paul on 1/20/16.
//  Copyright © 2016 Suvam Paul. All rights reserved.
//

import Foundation

extension ParseClient {

    // MARK: Constants
    struct Constants {
        
        static let ParseAPIKey: String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ParseApplicationID: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
        static let BaseURLSecure: String =  "https://api.parse.com/1/classes/"
        
        static let Number: Int = 100
        
        static let OrderFormat: String = "-updatedAt"
    }
    
    // MARK: Methods
    struct Methods {
        
        //MARK: Student Locations 
        static let StudentLocation = "StudentLocation"
    }
    
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {

        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let Limit = "limit"
        static let Order = "order"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        
        static let Results = "results"
        static let ObjectId = "objectId"
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let CreatedAt = "createdAt"
        static let UpdatedAt = "updatedAt"
        static let ACL = "ACL"
    }
    
}
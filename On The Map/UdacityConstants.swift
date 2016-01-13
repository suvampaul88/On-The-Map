//
//  UdacityConstants.swift
//  On The Map
//
//  Created by Suvam Paul on 1/6/16.
//  Copyright © 2016 Suvam Paul. All rights reserved.
//

import Foundation


extension UdacityClient {
    
    // MARK: Constants
    struct Constants {
        
        static let BaseURL : String = "http://www.udacity.com/api/"
        static let BaseURLSecure : String = "https://www.udacity.com/api/"
        
    }
    
    // MARK: Methods
    struct Methods {
        
        // MARK: Session
        static let Session = "session"
        
        //MARK: Public User Data
        static let Users =  "users/{user_id}"

    }
    
    // MARK: URL Keys
    struct URLKeys {
        static let UserID = "user_id"
    }
    
    
    // MARK: JSON Body Keys
    struct JSONBodyKeys {

        static let Domain = "udacity"
        static let Password = "password"
        static let Username = "username"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: Login
        static let UserKey = "key"
        static let Account = "account"
        static let Session = "session"
        static let ID = "id"
        static let User = "user"
        static let Email =  "email"

    }
    
}
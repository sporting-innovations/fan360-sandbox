//
//  Constants.swift
//  Spider
//
//  Created by Bryan Stober on 1/5/16.
//  Copyright © 2016 Bryan Stober Design. All rights reserved.
//

import Foundation


class Constants {
    
    struct WEBSERVICES {
        static let BASE_URL = "https://raw.githubusercontent.com/sporting-innovations/fan360-sandbox/master/service/"
        static let DATA_URL = BASE_URL + "events.json"
        static let IMAGE_URL = BASE_URL + "images/"
    }
    
    struct PATH {
        static let BUNDLE = NSBundle.mainBundle()
        static let DOCUMENTS = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        static let TEMP = NSTemporaryDirectory()
        static let IMAGES_FOLDER = PATH.DOCUMENTS.stringByAppendingString("/images/")
    }
    
    struct DEFAULT_KEYS {
        static let RUN_COUNT = "runcount"
        static let DATA_READY = "DataReady"
        static let TOKEN = "ABmsLgpyv3oHoovLMFnqkt-HUbSkmV0hks5WWMktwA%3D%3D"
    }
    
    struct PREDICATE {
        static let FEATURED = "featured == 1"
        static let ALL = "featured == 1 || featured == 0"
    }
}
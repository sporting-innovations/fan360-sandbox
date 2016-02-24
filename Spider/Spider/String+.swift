//
//  String+.swift
//  Wordpress
//
//  Created by Bryan Stober on 10/27/15.
//  Copyright © 2015 bryan stober. All rights reserved.
//

import Foundation

extension String
{
    func toDateTime() -> NSDate
    {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFromString : NSDate = dateFormatter.dateFromString(self)!
        
        return dateFromString
    }
    
    func split(regex: String) -> Array<String> {
        do{
            let regEx = try NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions())
            let stop = "<SomeStringThatYouDoNotExpectToOccurInSelf>"
            let modifiedString = regEx.stringByReplacingMatchesInString (self, options: NSMatchingOptions(), range: NSMakeRange(0, characters.count), withTemplate:stop)
            return modifiedString.componentsSeparatedByString(stop)
        } catch {
            return []
        }
    }
}
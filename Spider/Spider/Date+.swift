//
//  Date+.swift
//  Spider
//
//  Created by Bryan Stober on 1/5/16.
//  Copyright © 2016 Bryan Stober Design. All rights reserved.
//

import Foundation

extension NSDate {
    func stringFromDate( format: String?) -> String {
        let formatter = NSDateFormatter()
        let locale = NSLocale(localeIdentifier: "en_US_POSIX")
        
        formatter.locale = locale
        
        if(format != nil){
            formatter.dateFormat = format
        }else{
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            formatter.timeStyle = .MediumStyle
        }
        return formatter.stringFromDate(self)
    }
}

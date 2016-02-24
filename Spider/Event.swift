//
//  Event.swift
//  Spider
//
//  Created by Bryan Stober on 1/5/16.
//  Copyright © 2016 Bryan Stober Design. All rights reserved.
//

import UIKit
import CoreData

class Event: NSManagedObject {

    func processEvent(data:[String:AnyObject]){
        
        //string
        id = data["id"] as? String
        desc = data["description"] as? String
        primaryName = data["primaryName"]?["en-US"] as? String
        secondaryName = data["secondaryName"]?["en-US"] as? String
        shortName = data["shortName"]?["en-US"] as? String
        venueId = data["venueId"] as? String
        
        if let assets = data["assets"] as? NSArray {
            imageName = assets[0]["externalId"] as? String
            
            if let type = assets[0]["contentType"] as? String {
                
                imageType = type.split("/")[1]

                ImageHelper.sharedInstance.downloadImage("\(Constants.WEBSERVICES.IMAGE_URL)\(imageName!).\(imageType!)")
            }
        }
        
        //bool
        ownedByMe =  data["ownedByMe"] as? NSNumber
        featured = data["featured"] as? NSNumber
        
        //date
        if let _startDate = data["startDate"] as? String {
            startDate = _startDate.toDateTime()
        }
        
        if let _endDateTime = data["endDateTime"] as? String {
            endDateTime = _endDateTime.toDateTime()
        }
        
        if let _startDateTime = data["startDateTime"] as? String{
            startDateTime = _startDateTime.toDateTime()
        }
        
        if let _startDate = data["startDate"] as? String{
            startDate = _startDate.toDateTime()
        }
    
        timeStamp = NSDate()

    }

}

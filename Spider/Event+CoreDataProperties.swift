//
//  Event+CoreDataProperties.swift
//  Spider
//
//  Created by Bryan Stober on 1/6/16.
//  Copyright © 2016 Bryan Stober Design. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Event {

    @NSManaged var desc: String?
    @NSManaged var endDateTime: NSDate?
    @NSManaged var featured: NSNumber?
    @NSManaged var id: String?
    @NSManaged var imageName: String?
    @NSManaged var ownedByMe: NSNumber?
    @NSManaged var primaryName: String?
    @NSManaged var secondaryName: String?
    @NSManaged var shortName: String?
    @NSManaged var startDate: NSDate?
    @NSManaged var startDateTime: NSDate?
    @NSManaged var timeStamp: NSDate?
    @NSManaged var venueId: String?
    @NSManaged var imageType: String?

}

//
//  StartupTask.swift
//  Spider
//
//  Created by Bryan Stober on 1/5/16.
//  Copyright © 2016 Bryan Stober Design. All rights reserved.
//

import UIKit
import SwiftHTTP
import CoreData

class StartupTask {
    static let sharedInstance = StartupTask()
    var managedObjectContext: NSManagedObjectContext? = AppDelegate().managedObjectContext
    
    func run(){
        
        getData()
        
    }
    
    func getData(){
        
        do {
            let opt = try HTTP.GET(Constants.WEBSERVICES.DATA_URL)
            opt.start { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return //also notify app of failure as needed
                }
                print("opt finished: \(response.description)")
                print("data \(response.data)")
                
                do {
                    let jsonArray = try NSJSONSerialization.JSONObjectWithData(response.data, options: NSJSONReadingOptions(rawValue: 0)) as? NSArray
                    if let jsonArray = jsonArray {
                        print(jsonArray)
                        
                        for item in jsonArray as! [NSDictionary]{
                            
                            if(!self.updateCurrentEntity(item as! [String : AnyObject])){
                                self.insertNewEntity(item as! [String : AnyObject])
                            }
                        }
                                                
                    } else {
                        print("No JSON array set!")
                        
                    }
                } catch let error as NSError {
                    print("\(error.localizedDescription)")
                }
                
                NSNotificationCenter.defaultCenter().postNotificationName(Constants.DEFAULT_KEYS.DATA_READY, object: nil)
            }
        } catch let error {
            print("got an error creating the request: \(error)")
        }
        
    }

    func updateCurrentEntity(item:[String:AnyObject]) -> Bool{
        
        let predicate = NSPredicate(format: "id == %@", item["id"] as! String)
        
        let fetchRequest = NSFetchRequest(entityName: "Event")
        
        fetchRequest.predicate = predicate
        
        do {
            let fetchedEntities = try self.managedObjectContext!.executeFetchRequest(fetchRequest) as! [Event]
            
            if(fetchedEntities.count > 0){
                fetchedEntities[0].processEvent(item)
                saveEntity()
                return true
            }
        } catch {
            print("Error performing fetch!")
        }
        
        return false
        
    }
    
    func saveEntity(){
        
        do {
            try self.managedObjectContext!.save()
            
        } catch {
            print("Error updating Event!")
        }
        
    }
    
    func insertNewEntity(item:[String:AnyObject]){
        
        let event = NSEntityDescription.insertNewObjectForEntityForName("Event", inManagedObjectContext: self.managedObjectContext!) as! Event
        
        event.processEvent(item)
        
        saveEntity()
    }
    
    func saveImage (image:UIImage?, path: String ){
        
//        if let image = image {
//            
//            let fileURL = getDocumentsURL().URLByAppendingPathComponent("")
//            
//            if let pngImageData = UIImagePNGRepresentation(image) {
//                pngImageData.writeToURL(fileURL, atomically: false)
//            }
//        }
//       
        
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        
        let image = UIImage(contentsOfFile: path)
        
        if image == nil {
            
            print("missing image at: \(path)")
        }
        print("Loading image from path: \(path)") // this is just for you to see the path in case you want to go to the directory, using Finder.
        return image
        
    }
    
}
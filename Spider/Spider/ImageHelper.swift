//
//  imageHelper.swift
//  Wordpress
//
//  Created by Bryan Stober on 11/1/15.
//  Copyright © 2015 bryan stober. All rights reserved.
//

import UIKit
import CoreData

class ImageHelper: NSObject {

    let fileManager = NSFileManager.defaultManager()
    var tempDestUrl:NSURL!
    static let sharedInstance = ImageHelper()
    
    func downloadImage(url:String)-> Bool {
        
        if let imageUrl = NSURL(string:url) {
            
            if (!fileManager.fileExistsAtPath(Constants.PATH.IMAGES_FOLDER)) {
                do {
                    try fileManager.createDirectoryAtPath(Constants.PATH.IMAGES_FOLDER, withIntermediateDirectories: true, attributes: nil)
                }
                catch let error as NSError {
                    print("\(error.localizedDescription)")
                    return false
                }
            }
            
            self.tempDestUrl = NSURL(fileURLWithPath: Constants.PATH.IMAGES_FOLDER + imageUrl.lastPathComponent!)
            
            if fileManager.fileExistsAtPath(self.tempDestUrl.path!) {
                
                print("The file already exists at path: \(url)")
                
                return false
                
            }
                
            else {
                
                if let img = NSData(contentsOfURL: imageUrl){
                    if img.writeToURL(self.tempDestUrl, atomically: true) {
                        
                        print("\(url) downloaded to path")
                        
                        return true
                        
                    } else {
                        
                       print("error saving file: \(url)")
                        
                        return false
                    }
                }
            }
            
        }
        else {
            
            return false
        }
        
        return false
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        
//        let aPath = path.stringByAppendingString("?token=\(Constants.DEFAULT_KEYS.TOKEN)")
        let image = UIImage(contentsOfFile: Constants.PATH.IMAGES_FOLDER.stringByAppendingString(path))
        
        if image == nil {
            
            print("missing image at: \(path)")
        }
        print("Loading image from path: \(path)") // this is just for you to see the path in case you want to go to the directory, using Finder.
        return image
    }
}

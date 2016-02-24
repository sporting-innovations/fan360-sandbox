//
//  MasterViewController.swift
//  Spider
//
//  Created by Bryan Stober on 1/5/16.
//  Copyright © 2016 Bryan Stober Design. All rights reserved.
//

import UIKit
import CoreData
import SwiftHTTP

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    var filter:String = Constants.PREDICATE.FEATURED
    
    @IBOutlet weak var currentSelectedIndex: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refreshData:")
        self.navigationItem.rightBarButtonItem = addButton
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: "refreshData:", forControlEvents: UIControlEvents.ValueChanged)
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        setNotifications()
        
        StartupTask.sharedInstance.run()
        
        self.delay(0.2) { () -> () in
            self.pleaseWait()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Async Notications selectors
    
    func setNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "dataReady:", name:Constants.DEFAULT_KEYS.DATA_READY, object: nil)
    }
    
    func dataReady(sender:NSNotification?){
        
        do {
            
            try self.fetchedResultsController.performFetch()
            
            self.refreshControl!.endRefreshing()
            
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
            
        } catch{
            print("Failed to perform fetch!")
        }
        
        self.delay(1) { () -> () in
            self.clearAllNotice()
        }
    }
    
    func refreshData(sender: AnyObject){
        
        if(sender.isKindOfClass(UIBarItem)){
            self.pleaseWait()
        }
        
        
        StartupTask.sharedInstance.getData()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = self.fetchedResultsController.objectAtIndexPath(indexPath)
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object as? Event
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomTableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex
        {
        case 0:
            self.filter = Constants.PREDICATE.FEATURED
            print(sender.selectedSegmentIndex)
            break;
        case 1:
            self.filter = Constants.PREDICATE.ALL
            print(sender.selectedSegmentIndex)
            break;
        default:
            self.filter = Constants.PREDICATE.FEATURED
            break;
        }
        
        do {
            
            let resultPredicate1 = NSPredicate(format: "\(filter)")
            
            
            self.fetchedResultsController.fetchRequest.predicate = resultPredicate1
            
            try self.fetchedResultsController.performFetch()
            
            self.refreshControl!.endRefreshing()
            dispatch_async(dispatch_get_main_queue()) {
                
                self.tableView.reloadData()
            }
            
        } catch{
            print("Failed to perform fetch!")
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
            
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                //print("Unresolved error \(error), \(error.userInfo)")
                abort()
            }
        }
    }
    
    func configureCell(cell: CustomTableViewCell, atIndexPath indexPath: NSIndexPath) {
        
        let event = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Event
        
        if let pName = event.primaryName {
            cell.titleLabel.text = pName
        }
        if let sName = event.secondaryName {
            cell.subTitleLabel.text = sName
        }
        
        if let sTime = event.startDateTime {
            cell.startDateLabel.text = sTime.stringFromDate(nil)
        }
        
        if let iName = event.imageName {
            if let iType = event.imageType{
                cell.customImageView.image = ImageHelper.sharedInstance.loadImageFromPath("\(iName).\(iType)")
            }
        }
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        // Edit the entity name as appropriate.
        let entity = NSEntityDescription.entityForName("Event", inManagedObjectContext: self.managedObjectContext!)
        fetchRequest.entity = entity
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        let resultPredicate1 = NSPredicate(format: "\(filter)")
        
        
        fetchRequest.predicate = resultPredicate1
        
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "startDateTime", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            abort()
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            if let indexPath = indexPath {
                self.configureCell(tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell, atIndexPath: indexPath)
            }
            
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}


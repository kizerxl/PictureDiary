//
//  PhotosTableViewController.swift
//  PictureDiary
//
//  Created by Flatiron School on 7/5/16.
//  Copyright © 2016 theMan. All rights reserved.
//

import UIKit
import CoreData

class PhotosTableViewController: UITableViewController {
    
    var entries: [NSManagedObject]!
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!
    
    let cellIdentifier = "photoCell"
//    var dateFormatter: NSDateFormatter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.rowHeight = 350
//        dateFormatter = NSDateFormatter()
//        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        tableView.registerNib(UINib(nibName: "PhotoEntryCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        managedContext = appDelegate.managedObjectContext
        entries = []
        fetchEntries()
        title = "Entries"
        print("There are \(entries.count) in the entries array")
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        fetchEntries()
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("photoEntryScreen", sender: nil)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: PhotoEntryCell = (tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? PhotoEntryCell)!
        cell = (NSBundle.mainBundle().loadNibNamed("PhotoEntryCell", owner: self, options: nil)[0] as? PhotoEntryCell)!
        
        let currentEntry = entries[indexPath.row]
        cell.configureWithEntry(currentEntry)
        
        return cell
    }
    
    func fetchEntries() {
        let fetchRequest = NSFetchRequest(entityName: "PhotoEntry")
        
            do{
                let results = try managedContext.executeFetchRequest(fetchRequest)
                entries = results as! [NSManagedObject]
                
                if entries.count == 0 {
                    print("FETCHING")
                    loadTestData()
                }
                
            }catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
            }
        
    }
    
    func loadTestData() {
        //will load dummy data for table view
        
        let entity1 =  NSEntityDescription.entityForName("PhotoEntry", inManagedObjectContext: managedContext)
        let entry1 = NSManagedObject(entity: entity1!, insertIntoManagedObjectContext: managedContext)
        entry1.setValue("Stars and Stripes!", forKey: "entry")
        entry1.setValue(NSDate(), forKey: "date")
        
        //convert Captain image to NSData
        let captainImage = UIImage(named: "captainAmerica")
        let convertedImg = UIImagePNGRepresentation(captainImage!)
        entry1.setValue(convertedImg, forKey: "image")
        
        let entity2 =  NSEntityDescription.entityForName("PhotoEntry", inManagedObjectContext: managedContext)
        let entry2 = NSManagedObject(entity: entity2!, insertIntoManagedObjectContext: managedContext)
        entry2.setValue("I am IronMan", forKey: "entry")
        entry2.setValue(NSDate(), forKey: "date")
        
        //convert Iron Man image to NSData
        let ironImage = UIImage(named: "ironMan")
        let convertedImg2 = UIImagePNGRepresentation(ironImage!)
        entry2.setValue(convertedImg2, forKey: "image")
        
        do {
            try managedContext.save()
            entries.append(entry1)
            entries.append(entry2)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }

    }
    
//    func niceDateString(date: NSDate) -> String {
//        return dateFormatter.stringFromDate(date)
//    }
//    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "photoEntryScreen" {
            print("passing stuff to the destination VC ")
            let idxPath = tableView.indexPathForSelectedRow
            let destinationVC = segue.destinationViewController as? EntryViewController
            destinationVC?.entry = entries[(idxPath?.row)!]
        
        }
        else if segue.identifier == "addEntry" {
            let destinationVC = segue.destinationViewController as? AddEntryViewController
        }
    }
    
}


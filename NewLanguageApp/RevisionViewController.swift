//
//  RevisionViewController.swift
//  NewLanguageApp
//
//  Created by chr1 on 11/05/2015.
//  Copyright (c) 2015 chr1. All rights reserved.
//

import UIKit
import CoreData

class RevisionViewController: UITableViewController {
    
    var managedContext: NSManagedObjectContext! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //http://stackoverflow.com/questions/24470656/fail-to-hide-empty-cells-in-uitableview-swift
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getTags()!.count;
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tagCell", forIndexPath: indexPath) as UITableViewCell
        
        let tags = getTags()!
        
        var tag = tags[indexPath.row]
        
        cell.textLabel!.text = tag.name
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select a Tag to revise"
    }
    
    func getTags() -> [Tag]?{
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        managedContext = appDelegate.managedObjectContext!
        
        let tagFetch = NSFetchRequest(entityName: "Tag")
        
        var error: NSError?
        let result = managedContext.executeFetchRequest(tagFetch,
            error: &error) as [Tag]?
        
        if let tags = result {
            return tags
        } else {
            NSLog("Could not save \(error)")
            return nil
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nextViewController = segue.destinationViewController as? ReviseController {
            
            let tag = getTags()![tableView.indexPathForSelectedRow()!.row]
            nextViewController.tag = tag
        }
    }
}

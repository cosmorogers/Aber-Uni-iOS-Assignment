//
//  WordTagsSelectionController.swift
//  NewLanguageApp
//
//  Created by chr1 on 11/05/2015.
//  Copyright (c) 2015 chr1. All rights reserved.
//

import UIKit
import CoreData

class WordTagsSelectionController: UITableViewController {
    
    var managedContext: NSManagedObjectContext! = nil
    
    var selected = Set<Tag>()
    
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
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            
            // Option 2: if statement
            if cell.accessoryType == .Checkmark {
                cell.accessoryType = .None
            }
            else {
                cell.accessoryType = .Checkmark
            }
            
            // Also - you need to add some lines here to remember which ones are actually selected.
            // That information is necessary in tableView:cellForRowAtIndexPath, above.
            print(indexPath)
            
            // This next line clears the coloured selection that is applied to the whole of the cell.
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
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
}
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
    
    var selected: NSMutableSet? {
        didSet {
            self.tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //http://stackoverflow.com/questions/24470656/fail-to-hide-empty-cells-in-uitableview-swift
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        if selected === nil {
            selected = NSMutableSet()
        }
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
        
        if selected!.containsObject(tag) {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            
            let tags = getTags()!
            let tag = tags[indexPath.row]
            
            if cell.accessoryType == .Checkmark {
                cell.accessoryType = .None
                selected!.removeObject(tag)
            }
            else {
                cell.accessoryType = .Checkmark
                selected!.addObject(tag)
            }
            
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
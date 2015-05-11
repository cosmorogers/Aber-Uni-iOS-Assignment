//
//  WordsController.swift
//  NewLanguageApp
//
//  Created by chr1 on 11/05/2015.
//  Copyright (c) 2015 chr1. All rights reserved.
//
import UIKit
import CoreData

class WordViewController: UITableViewController {
    
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
        return getWordPairs()!.count;
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("wordCell", forIndexPath: indexPath) as UITableViewCell
        
        let words = getWordPairs()!
        
        var word = words[indexPath.row]
        
        cell.textLabel!.text = word.original
        return cell
    }
    
    func getWordPairs() -> [WordPair]?{
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        managedContext = appDelegate.managedObjectContext!
        
        let wordpairFetch = NSFetchRequest(entityName: "WordPair")
        
        var error: NSError?
        let result = managedContext.executeFetchRequest(wordpairFetch,
            error: &error) as [WordPair]?
        
        if let words = result {
            return words
        } else {
            NSLog("Could not save \(error)")
            return nil
        }
    }
    
    
    @IBAction func cancel(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
        if let controller = segue.sourceViewController as? WordFormController {
            let wordpairEntity = NSEntityDescription.entityForName("WordPair",
                inManagedObjectContext: managedContext)
            var error: NSError?
            
            let awordpair = WordPair(entity: wordpairEntity!,
                insertIntoManagedObjectContext: managedContext)
            awordpair.original = controller.word!.text
            awordpair.translated = controller.translation!.text
            awordpair.type = controller.type!.text
            awordpair.note = controller.note!.text
            
            if controller.selected !== nil {
                awordpair.tags = controller.selected!
            }
            
            if !managedContext.save(&error) {
                NSLog("Could not save \(error)")
            }
            
            self.tableView.reloadData()
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nextViewController = segue.destinationViewController as? WordDetailController {
            
            let word = getWordPairs()![tableView.indexPathForSelectedRow()!.row]
            nextViewController.word = word
        }
    }
    
    
}
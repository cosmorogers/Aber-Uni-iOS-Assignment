//
//  WordsController.swift
//  NewLanguageApp
//
//  Created by chr1 on 11/05/2015.
//  Copyright (c) 2015 chr1. All rights reserved.
//
import UIKit
import CoreData

class SearchController: UITableViewController, UISearchBarDelegate {
    //http://shrikar.com/swift-ios-tutorial-uisearchbar-and-uisearchbardelegate/

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var managedContext: NSManagedObjectContext! = nil
    
    var searchController: UISearchController! = nil
    
    var searchTerm: String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set the UISearchController and add it into the header
        /*
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = self.searchController.searchBar;
        */
        // the next line is used to hide the search controller when you push to another view
        self.definesPresentationContext = true
        
        /* Setup delegates */

        searchBar.delegate = self
        

    }
    var searchActive : Bool = false

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchText
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }

    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        // run the search and then reload the data
        tableView.reloadData()
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
        cell.detailTextLabel!.text = word.translated
        return cell
    }
    
    func getWordPairs() -> [WordPair]?{
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        managedContext = appDelegate.managedObjectContext!
        
        let wordpairFetch = NSFetchRequest(entityName: "WordPair")
        
        if searchTerm != nil {
        
            wordpairFetch.predicate = NSPredicate(format: "original like[cd] %@", searchTerm + "*")
        
        }
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
    
}
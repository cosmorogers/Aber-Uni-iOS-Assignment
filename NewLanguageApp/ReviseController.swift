//
//  ReviseController.swift
//  NewLanguageApp
//
//  Created by chr1 on 11/05/2015.
//  Copyright (c) 2015 chr1. All rights reserved.
//

import UIKit
import CoreData

class ReviseController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //http://stackoverflow.com/questions/24470656/fail-to-hide-empty-cells-in-uitableview-swift
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        configureView()
    }
    
    var tag: Tag? {
        didSet {
            self.configureView()
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tag!.wordpairs.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tag!.name + " (click to reveal answer)"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("revisionCell", forIndexPath: indexPath) as UITableViewCell
        let word = tag!.wordpairs.allObjects[indexPath.row] as WordPair
        cell.textLabel!.text = word.translated
        cell.detailTextLabel!.text = word.original
        cell.detailTextLabel!.textColor = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(0))
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            
            cell.detailTextLabel!.textColor = UIColor(red: CGFloat(0), green: CGFloat(0), blue: CGFloat(1), alpha: CGFloat(1))
            // This next line clears the coloured selection that is applied to the whole of the cell.
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }

    
    func configureView() {
        self.tableView.reloadData()
    }
    
}

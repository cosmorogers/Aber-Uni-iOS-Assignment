//
//  WordDetailController.swift
//  NewLanguageApp
//
//  Created by chr1 on 11/05/2015.
//  Copyright (c) 2015 chr1. All rights reserved.
//

import UIKit
import CoreData

class WordDetailController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    var word: WordPair? {
        didSet {
            print(word)
            //if titleCell != nil {
                self.configureView()
            //}
            //
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 { //tags
            return 3
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Word";
        case 1:
            return "Translation"
        case 2:
            return "Notes"
        case 3:
            return "Tags";
        default:
            return "";
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("viewWordCell", forIndexPath: indexPath) as UITableViewCell
        
        switch indexPath.section {
        case 0:
            cell.textLabel!.text = word?.original
        case 1:
            cell.textLabel!.text = word?.translated
        case 2:
            cell.textLabel!.text = word?.note
        case 3:
            //Tags
            cell.textLabel!.text = "here goeth tags"
        default:
            //do nothing
            return cell;
        }
        
        
        return cell
    }
    
    func configureView() {
        self.tableView.reloadData()
        //titleCell!.textLabel!.text = "\(speaker!.forename) \(speaker!.surname)"
       // titleCell!.detailTextLabel!.text = speaker?.email
        //bioCell!.textLabel!.text = speaker?.biography
    }
}
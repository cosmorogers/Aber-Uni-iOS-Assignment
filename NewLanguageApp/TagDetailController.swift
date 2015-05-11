//
//  TagDetailController.swift
//  NewLanguageApp
//
//  Created by chr1 on 11/05/2015.
//  Copyright (c) 2015 chr1. All rights reserved.
//

import UIKit
import CoreData

class TagDetailController: UITableViewController {
    
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
        return 5
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 { //words
            return tag!.wordpairs.count
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Tag";
        case 1:
            return "Words"
        default:
            return ""
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("viewTagCell", forIndexPath: indexPath) as UITableViewCell
        
        switch indexPath.section {
        case 0:
            cell.textLabel!.text = tag?.name
        case 1:
            //words
            let cell = tableView.dequeueReusableCellWithIdentifier("viewWordCell", forIndexPath: indexPath) as UITableViewCell
            let word = tag!.wordpairs.allObjects[indexPath.row] as WordPair
            cell.textLabel!.text = word.original
            cell.detailTextLabel!.text = word.translated
        default:
            //do nothing
            return cell;
        }
        
        
        return cell
    }
    
    func configureView() {
        self.tableView.reloadData()
    }

}
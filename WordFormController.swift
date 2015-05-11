//
//  WordFormController.swift
//  NewLanguageApp
//
//  Created by chr1 on 11/05/2015.
//  Copyright (c) 2015 chr1. All rights reserved.
//

import UIKit
import CoreData

class WordFormController: UITableViewController {
    
    @IBOutlet weak var word: UITextField!
    @IBOutlet weak var translation: UITextField!
    @IBOutlet weak var note: UITextField!
    @IBOutlet weak var type: UITextField!
    
    @IBOutlet weak var selectedTags: UITableViewCell!
    
    var selected : NSMutableSet! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //http://stackoverflow.com/questions/24470656/fail-to-hide-empty-cells-in-uitableview-swift
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
    }
    
    @IBAction func selectedTags(segue:UIStoryboardSegue) {
        if let controller = segue.sourceViewController as? WordTagsSelectionController {
            selected = controller.selected;
            
            var msg  = " tag selected"
            
            if selected.count > 1 {
                msg = " tags selected"
            }
            
            selectedTags.textLabel?.text = String(selected.count) + msg
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nextViewController = segue.destinationViewController as? WordTagsSelectionController {
            if selected !== nil {
                nextViewController.selected = selected
            }
            
        }
    }
    
    
    
}
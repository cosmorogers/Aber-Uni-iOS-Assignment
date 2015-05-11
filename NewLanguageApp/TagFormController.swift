//
//  TagFormController.swift
//  NewLanguageApp
//
//  Created by chr1 on 11/05/2015.
//  Copyright (c) 2015 chr1. All rights reserved.
//
import UIKit
import CoreData

class TagFormController: UITableViewController {

    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //http://stackoverflow.com/questions/24470656/fail-to-hide-empty-cells-in-uitableview-swift
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
    }
}
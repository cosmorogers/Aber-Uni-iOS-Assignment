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
        configureView()
    }
    
    var tag: Tag? {
        didSet {
            //if titleCell != nil {
            self.configureView()
            //}
            //
        }
        
    }
    
    
    func configureView() {
        self.tableView.reloadData()
    }

}
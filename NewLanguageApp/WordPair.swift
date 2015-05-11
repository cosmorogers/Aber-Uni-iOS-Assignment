//
//  WordPair.swift
//  NewLanguageApp
//
//  Created by chr1 on 11/05/2015.
//  Copyright (c) 2015 chr1. All rights reserved.
//

import Foundation
import CoreData

class WordPair: NSManagedObject {

    @NSManaged var created: NSDate
    @NSManaged var note: String
    @NSManaged var original: String
    @NSManaged var translated: String
    @NSManaged var type: String
    @NSManaged var tags: NSSet

}

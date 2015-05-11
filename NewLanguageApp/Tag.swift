//
//  Tag.swift
//  NewLanguageApp
//
//  Created by chr1 on 11/05/2015.
//  Copyright (c) 2015 chr1. All rights reserved.
//

import Foundation
import CoreData

class Tag: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var wordpairs: WordPair

}

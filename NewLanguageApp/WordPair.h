//
//  WordPair.h
//  NewLanguageApp
//
//  Created by chr1 on 11/05/2015.
//  Copyright (c) 2015 chr1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface WordPair : NSManagedObject

@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * original;
@property (nonatomic, retain) NSString * translated;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSManagedObject *tags;

@end

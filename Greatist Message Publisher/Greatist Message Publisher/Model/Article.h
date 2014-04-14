//
//  Article.h
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Section;

@interface Article : NSManagedObject

@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSString * pictureLarge;
@property (nonatomic, retain) NSString * nid;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Section *section;

@end

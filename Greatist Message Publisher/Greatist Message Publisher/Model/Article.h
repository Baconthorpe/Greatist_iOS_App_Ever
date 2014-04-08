//
//  Article.h
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/8/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Section;

@interface Article : NSManagedObject

@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * headline;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * articleURL;
@property (nonatomic, retain) Section *section;

@end

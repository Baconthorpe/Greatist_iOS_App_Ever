//
//  GRTMainTableViewCell.h
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Post;

@interface GRTtableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *postLabel;

@property (strong, nonatomic) Post *post;

+ (instancetype) cellConfiguredWithPost: (Post *)post;
- (instancetype) configureWithPost: (Post *)post;

@end

//
//  GRTPostTableViewCell.h
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/3/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Post;

@interface GRTPostTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) GRTPostTableViewCell *cell;


+ (instancetype) cellConfiguredWithPost: (Post *)post;
- (instancetype) configureWithPost: (Post *)post;
- (void)setupResponseButtons;

@end

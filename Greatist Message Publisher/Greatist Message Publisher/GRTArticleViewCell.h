//
//  GRTArticleViewCell.h
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/7/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post+Methods.h"

@class Article;

@interface GRTArticleViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) Article *article;
@property (strong, nonatomic) GRTArticleViewCell *cell;


+ (instancetype) cellConfiguredWithPost: (Post *)post;
- (instancetype) configureWithPost: (Post *)post;
- (void)setupResponseButtons;


@end

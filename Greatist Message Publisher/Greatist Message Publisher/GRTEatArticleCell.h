//
//  GRTEatArticleCell.h
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/7/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post+Methods.h"

@interface GRTEatArticleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *postLabel;
@property (strong, nonatomic) Post *post;
@property (strong, nonatomic) GRTEatArticleCell *cell;


+ (instancetype) cellConfiguredWithPost: (Post *)post;
- (instancetype) configureWithPost: (Post *)post;
- (void)setupResponseButtons;
@end

//
//  GRTEatArticleCell.m
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/7/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTEatArticleCell.h"


@implementation GRTEatArticleCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype) configureWithPost: (Post *)post
{
    
    //self.postLabel.text = self.post.content;
    self.postLabel.font = [UIFont fontWithName:@"ArcherPro-Medium" size:18];
    NSLog(@"checking configurewithpost");
    
    return self;
}

+ (instancetype) cellConfiguredWithPost: (Post *)post
{
    GRTEatArticleCell *cell = [GRTEatArticleCell new];
    [cell configureWithPost:nil];
    return cell;
}




@end

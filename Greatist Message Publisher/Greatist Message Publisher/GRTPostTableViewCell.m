//
//  GRTPostTableViewCell.m
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/3/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTPostTableViewCell.h"
#import "Post+Methods.h"

@implementation GRTPostTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype) cellConfiguredWithPost: (Post *)post
{
    GRTPostTableViewCell *cell = [GRTPostTableViewCell new];
    [cell configureWithPost:post];
    
    return cell;
}

- (instancetype) configureWithPost: (Post *)post
{
    self.post = post;
    self.postLabel.text = self.post.content;
    
    return self;
}


@end

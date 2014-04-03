//
//  GRTMainTableViewCell.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTMainTableViewCell.h"
#import "Post+Methods.h"

@interface GRTMainTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@end

@implementation GRTMainTableViewCell

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

+ (instancetype) cellConfiguredWithPost: (Post *)post
{
    GRTMainTableViewCell *cell = [GRTMainTableViewCell new];
    [cell configureWithPost:post];
    
    return cell;
}

- (instancetype) configureWithPost: (Post *)post
{
    self.post = post;
    self.messageLabel.text = self.post.content;
    
    return self;
}

@end

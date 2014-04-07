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

-(void)layoutSubviews
{
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor greatistBlueColor];
    self.cell.backgroundView = blueView;
    
    FAKFontAwesome *flagIcon = [FAKFontAwesome flagIconWithSize:10];
    [flagIcon addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]];
    UIImage *flagImage = [flagIcon imageWithSize:CGSizeMake(10,10)];
    
    UIButton *flagButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [flagButton setFrame:CGRectMake(50, 110, 15, 15)];
    [flagButton setBackgroundImage:flagImage forState:UIControlStateNormal];
    
    [self addSubview:flagButton];

    FAKFontAwesome *heartIcon = [FAKFontAwesome heartIconWithSize:10];
    [heartIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistBlueColor]];
    UIImage *heartImage = [heartIcon imageWithSize:CGSizeMake(10,10)];
    
    UIButton *heartButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [heartButton setFrame:CGRectMake(100, 110, 15, 15)];
    [heartButton setBackgroundImage:heartImage forState:UIControlStateNormal];
    
    [self addSubview:heartButton];
    
    
    FAKFontAwesome *glassIcon = [FAKFontAwesome glassIconWithSize:10];
    [glassIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistBlueColor]];
    UIImage *glassImage = [glassIcon imageWithSize:CGSizeMake(10,10)];
    
    UIButton *glassButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [glassButton setFrame:CGRectMake(150, 110, 15, 15)];
    [glassButton setBackgroundImage:glassImage forState:UIControlStateNormal];
    
    [self addSubview:glassButton];
    
    
    FAKFontAwesome *smileIcon = [FAKFontAwesome smileOIconWithSize:10];
    [smileIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistBlueColor]];
    UIImage *smileImage = [smileIcon imageWithSize:CGSizeMake(10,10)];
    
    UIButton *smileButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [smileButton setFrame:CGRectMake(200, 110, 15, 15)];
    [smileButton setBackgroundImage:smileImage forState:UIControlStateNormal];
    
    [self addSubview:smileButton];
    
    FAKFontAwesome *frownIcon = [FAKFontAwesome frownOIconWithSize:10];
    [frownIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistBlueColor]];
    UIImage *frownImage = [frownIcon imageWithSize:CGSizeMake(10,10)];
    
    UIButton *frownButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [frownButton setFrame:CGRectMake(250, 110, 15, 15)];
    [frownButton setBackgroundImage:frownImage forState:UIControlStateNormal];
    
    [self addSubview:frownButton];


}


    
@end


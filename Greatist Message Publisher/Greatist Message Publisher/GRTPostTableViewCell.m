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
    self.postLabel.font = [UIFont fontWithName:@"ArcherPro-Medium" size:20];
    
    return self;
}

-(void)layoutSubviews
{
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor greatistBlueColor];
    self.cell.backgroundView = blueView;
    

//    FAKFontAwesome *flagIcon = [FAKFontAwesome flagIconWithSize:15];
//    [flagIcon addAttribute:NSForegroundColorAttributeName value:[UIColor redColor]];
//    UIImage *flagImage = [[flagIcon imageWithSize:CGSizeMake(20, 20)] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
//    flagIcon.iconFontSize = 15;
//    [flagButton setBackgroundImage:flagImage forState:UIControlStateNormal];
//
    //    UIButton *flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [flagButton setFrame:CGRectMake(170, 280, 140, 20)];
    //    [flagButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //    [flagButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:8]];
    //    flagButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //    flagButton.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    
//    [self addSubview:flagButton];

    
    FAKFontAwesome *heartIcon = [FAKFontAwesome heartIconWithSize:15];
    [heartIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistBlueColor]];
    UIImage *heartImage = [[heartIcon imageWithSize:CGSizeMake(15,15)] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    heartIcon.iconFontSize = 15;
    
    UIButton *heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [heartButton setFrame:CGRectMake(55, 110, 15, 15)];
    
    [heartButton setBackgroundImage:heartImage forState:UIControlStateNormal];
    [self addSubview:heartButton];
    
    
    
    FAKFontAwesome *glassIcon = [FAKFontAwesome glassIconWithSize:15];
    [glassIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistBlueColor]];
    UIImage *glassImage = [[glassIcon imageWithSize:CGSizeMake(15,15)] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    glassIcon.iconFontSize = 15;
    
    UIButton *glassButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [glassButton setFrame:CGRectMake(120, 110, 15, 15)];
    
    [glassButton setBackgroundImage:glassImage forState:UIControlStateNormal];
    [self addSubview:glassButton];
    
    
    
    FAKFontAwesome *smileIcon = [FAKFontAwesome smileOIconWithSize:15];
    [smileIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistBlueColor]];
    UIImage *smileImage = [[smileIcon imageWithSize:CGSizeMake(15,15)] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    
    UIButton *smileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [smileButton setFrame:CGRectMake(185, 110, 15, 15)];
    
    [smileButton setBackgroundImage:smileImage forState:UIControlStateNormal];
    [self addSubview:smileButton];
    
    
    
    FAKFontAwesome *frownIcon = [FAKFontAwesome frownOIconWithSize:15];
    [frownIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistBlueColor]];
    UIImage *frownImage = [[frownIcon imageWithSize:CGSizeMake(15,15)] stretchableImageWithLeftCapWidth:15 topCapHeight:15];
    
    UIButton *frownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [frownButton setFrame:CGRectMake(250, 110, 15, 15)];
    
    [frownButton setBackgroundImage:frownImage forState:UIControlStateNormal];
    [self addSubview:frownButton];

}


    
@end


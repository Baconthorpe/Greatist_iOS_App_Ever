//
//  GRTStepTwoComposePost.m
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTStepTwoComposePost.h"
#import "Section+Methods.h"
#import "GRTDataStore.h"

@interface GRTStepTwoComposePost ()
@property (weak, nonatomic) IBOutlet UITextView *postContentTextView;
@property (weak, nonatomic) IBOutlet UIView *postView;
- (IBAction)backButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *leftQuoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightQuoteLabel;
@property (strong, nonatomic) Section *verticalSelected;
@property (strong, nonatomic) UIButton *eatButton;
@property (strong, nonatomic) NSArray *verticalButtons;

@property (strong, nonatomic) NSMutableArray *selectedCells;
@property (weak, nonatomic) IBOutlet UILabel *stepTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;
@property (strong, nonatomic) GRTDataStore *dataStore;
@end

@implementation GRTStepTwoComposePost
// in this view the user writes thier post, info concerning coloring gets passed from previous view controllers

-(void) awakeFromNib
{
    NSLog(@"I have awoken");
    
    
    self.directionLabel.font = [UIFont fontWithName:@"DINOT-Medium" size:14];
    self.directionLabel.textColor = [UIColor greatistPlayColorSecondary];
    self.directionLabel.text = @"Please share your thoughts";
    
    self.stepTwoLabel.font = [UIFont fontWithName:@"DINOT-Bold" size:24];
    self.stepTwoLabel.textColor = [UIColor greatistPlayColor];
    self.stepTwoLabel.text = @"Step Two...";
    
    self.postContentTextView.delegate = self;
    [self.postContentTextView setTextColor:[UIColor greatistLightGrayColor]];
    [[self.postContentTextView layer] setBorderColor:[[UIColor greatistLightGrayColor] CGColor]];
    [[self.postContentTextView layer] setBorderWidth:2];
    [[self.postContentTextView layer] setCornerRadius:2];
    self.postContentTextView.textContainerInset = UIEdgeInsetsMake(10.0, 15.0, 15.0, 10.0);
    
    self.leftQuoteLabel.font = [UIFont fontWithName:@"ArcherPro-Semibold" size:40];
    self.leftQuoteLabel.textColor = [UIColor greatistConnectColor];
    
    self.rightQuoteLabel.font = [UIFont fontWithName:@"ArcherPro-Semibold" size:40];
    self.rightQuoteLabel.textColor = [UIColor greatistConnectColor];

    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)setupPostContent
{
    self.postContentTextView.delegate = self;
    [self.postContentTextView setTextColor:[UIColor greatistLightGrayColor]];
    [[self.postContentTextView layer] setBorderColor:[[UIColor greatistLightGrayColor] CGColor]];
    [[self.postContentTextView layer] setBorderWidth:1];
    [[self.postContentTextView layer] setCornerRadius:15];
    self.postContentTextView.textContainerInset = UIEdgeInsetsMake(15.0, 10.0, 15.0, 10.0);
    
    self.leftQuoteLabel.font = [UIFont fontWithName:@"ArcherPro-Semibold" size:40];
    self.rightQuoteLabel.font = [UIFont fontWithName:@"ArcherPro-Semibold" size:40];
}

-(void)setupPostButton
{
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *resizedPostImage = [UIImage imageWithImage:[UIImage imageNamed:@"Greatist_Logo_Badge_Blue"] scaledToSize:CGSizeMake(50, 50)];
    [postButton setBackgroundImage:resizedPostImage forState:UIControlStateNormal];
    [postButton setFrame:CGRectMake(145, 215, 30, 30)];
    [postButton addTarget:self action:@selector(postButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:postButton];
}




@end

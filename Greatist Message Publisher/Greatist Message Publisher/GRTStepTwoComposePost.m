//
//  GRTStepTwoComposePost.m
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTStepTwoComposePost.h"

@implementation GRTStepTwoComposePost
// in this view the user writes thier post, info concerning coloring gets passed from previous view controllers
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

- (void)postButton:(id)sender
{
    // Fix this to use current user and not Anne
    User *anne = [User userWithName:@"Anne" uniqueID:@"anne" inContext:self.dataStore.managedObjectContext];
    
    NSMutableSet *responses = [NSMutableSet new];
    for (NSNumber *index in self.selectedCells) {
        NSInteger indexInteger = [index integerValue];
        Response *newResponse = [Response responseWithResponseOption:self.dataStore.validResponses[indexInteger] inContext:self.dataStore.managedObjectContext];
        [responses addObject:newResponse];
    }
    [self.dataStore saveContext];
    
    // Fix this to use current user and not Anne
    Post *newPost = [Post postWithContent:self.postContentTextView.text author:anne section:self.verticalSelected responses:responses inContext:self.dataStore.managedObjectContext];
    [self.dataStore saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end

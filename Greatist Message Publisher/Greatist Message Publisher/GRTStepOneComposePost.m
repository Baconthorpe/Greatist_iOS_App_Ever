//
//  GRTStepOneComposePost.m
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTStepOneComposePost.h"
#import "Section+Methods.h"
#import "GRTDataStore.h"
#import "GRTStepTwoComposePostViewController.h"
#import "GRTStepOneComposePostViewController.h"
@interface GRTStepOneComposePost ()
- (IBAction)backButtonTapped:(id)sender;
@property (strong, nonatomic) Section *verticalSelected;
@property (strong, nonatomic) NSArray *verticalButtons;
@property (strong, nonatomic) GRTDataStore *dataStore;
@property (weak, nonatomic) IBOutlet UINavigationItem *composePostNav;
@property (weak, nonatomic) IBOutlet UILabel *stepOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *fitnessLabel;
@property (weak, nonatomic) IBOutlet UILabel *healthLabel;
@property (weak, nonatomic) IBOutlet UILabel *happinessLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;

@property (weak, nonatomic) IBOutlet UIView *postView;

@end

@implementation GRTStepOneComposePost

// in this view the user must select a category to create a post on

-(void) awakeFromNib
{
    NSLog(@"I have awoken");
    
    self.fitnessLabel.font = [UIFont fontWithName:@"DINOT-Medium" size:16];
    self.fitnessLabel.textColor = [UIColor greatistMoveColor];
    
    self.healthLabel.font = [UIFont fontWithName:@"DINOT-Medium" size:16];
    self.healthLabel.textColor = [UIColor greatistEatColor];
    
    self.happinessLabel.font = [UIFont fontWithName:@"DINOT-Medium" size:16];
    self.happinessLabel.textColor = [UIColor greatistGrowColor];
    
    self.selectLabel.font = [UIFont fontWithName:@"DINOT-Medium" size:14];
    self.selectLabel.textColor = [UIColor greatistPlayColorSecondary];
    
    self.stepOneLabel.font = [UIFont fontWithName:@"DINOT-Bold" size:24];
    self.stepOneLabel.textColor = [UIColor greatistPlayColor];
    
    
    
   
    
    
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.fitnessLabel.font = [UIFont fontWithName:@"DINOT-Bold" size:14];
        
    }
    return self;
}

- (id) init
{
    self= [super init];
    
    if (self)
    
    {
    NSLog(@"hi");
    }
    return self;
    
}
- (void)setupCategoryButtons
{
    self.healthButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  
    [self.healthButton setBackgroundImage:[UIImage imageNamed:@"Eat_Colored60x60"] forState:UIControlStateNormal];
    self.healthButton.alpha = 0.3;
    [self.healthButton addTarget:self action:@selector(eatButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.healthButton];
    
    
    UILabel *healthLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 25, 30, 30)];
    [healthLabel setText:@"HEALTH"];
    [healthLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:14]];
    [healthLabel setTextColor:[UIColor greatistEatColor]];
    [self.healthButton addSubview:healthLabel];
    
    self.fitnessButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.fitnessButton setBackgroundImage:[UIImage imageNamed:@"Move_Colored60x60"] forState:UIControlStateNormal];
    self.fitnessButton.alpha = 0.3;
    [self.fitnessButton addTarget:self action:@selector(moveButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.fitnessButton];
    
    UILabel *fitnessLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 30, 30)];
    [fitnessLabel setText:@"FITNESS"];
    [fitnessLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:14]];
    [fitnessLabel setTextColor:[UIColor greatistMoveColor]];
    [self.fitnessButton addSubview:fitnessLabel];
    
    

    
    self.happinessButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   
    [self.happinessButton setBackgroundImage:[UIImage imageNamed:@"Grow_Colored60x60"] forState:UIControlStateNormal];
   self.happinessButton.alpha = 0.3;
    [self.happinessButton addTarget:self action:@selector(growButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    //[self.postView addSubview:self.happinessButton];

    
    UILabel *happinessLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 25, 30, 30)];
    [happinessLabel setText:@"HAPPINESS"];
    [happinessLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:14]];
    [happinessLabel setTextColor:[UIColor greatistGrowColor]];
    [self.happinessButton addSubview:happinessLabel];
    
//    UIButton *connectButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [connectButton setFrame:CGRectMake(140, 15, 30, 30)];
//    [connectButton setBackgroundImage:[UIImage imageNamed:@"Connect_Colored"] forState:UIControlStateNormal];
//    connectButton.alpha = 0.3;
//    [connectButton addTarget:self action:@selector(connectButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.postView addSubview:connectButton];
//    
//    UILabel *connectLabel = [[UILabel alloc] initWithFrame:CGRectMake(-5, 25, 50, 30)];
//    [connectLabel setText:@"CONNECT"];
//    [connectLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
//    [connectLabel setTextColor:[UIColor greatistConnectColor]];
//    [connectButton addSubview:connectLabel];
//    
//    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [playButton setFrame:CGRectMake(240, 15, 30, 30)];
//    [playButton setBackgroundImage:[UIImage imageNamed:@"Play_Colored60x60"] forState:UIControlStateNormal];
//    playButton.alpha = 0.3;
//    [playButton addTarget:self action:@selector(playButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.postView addSubview:playButton];
//    
//    UILabel *playLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 25, 30, 30)];
//    [playLabel setText:@"PLAY"];
//    [playLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
//    [playLabel setTextColor:[UIColor greatistPlayColor]];
//    [playButton addSubview:playLabel];
    
    self.verticalButtons = @[self.happinessButton, self.healthButton, self.fitnessButton];
    
}

-(void)eatButtonTapped: (UIButton *)sender
{
    NSString *nameSought = @"Eat";
    NSPredicate *eatSearch = [NSPredicate predicateWithFormat:@"name==%@",nameSought];
    NSArray *eatVerticals = [self.verticals filteredArrayUsingPredicate:eatSearch];
    self.verticalSelected= eatVerticals[0];
    
    [self dimVerticalButtons];
    UIButton *eatButton = self.verticalButtons[0];
    eatButton.alpha = 1.0;
    
    //self.leftQuoteLabel.textColor = [UIColor greatistEatColor];
    //self.rightQuoteLabel.textColor = [UIColor greatistEatColor];
    //self.postContentTextView.text = @"Find a new healthy recipe recently?";
}

-(void)moveButtonTapped: (UIButton *)sender
{
    NSString *nameSought = @"Move";
    NSPredicate *moveSearch = [NSPredicate predicateWithFormat:@"name==%@", nameSought];
    NSArray *moveVerticals = [self.verticals filteredArrayUsingPredicate:moveSearch];
    self.verticalSelected= moveVerticals[0];
    
    [self dimVerticalButtons];
    UIButton *moveButton = self.verticalButtons[1];
    moveButton.alpha = 1.0;
    
   // self.leftQuoteLabel.textColor = [UIColor greatistMoveColor];
   // self.rightQuoteLabel.textColor = [UIColor greatistMoveColor];
    //self.postContentTextView.text = @"Do something new at Yoga?";
}


-(void)playButtonTapped: (UIButton *)sender
{
    NSString *nameSought = @"Play";
    NSPredicate *playSearch = [NSPredicate predicateWithFormat:@"name==%@", nameSought];
    NSArray *playVerticals = [self.verticals filteredArrayUsingPredicate:playSearch];
    self.verticalSelected= playVerticals[0];
    
    [self dimVerticalButtons];
    UIButton *playButton = self.verticalButtons[2];
    playButton.alpha = 1.0;
    
    //self.leftQuoteLabel.textColor = [UIColor greatistPlayColor];
    //self.rightQuoteLabel.textColor = [UIColor greatistPlayColor];
   // self.postContentTextView.text = @"Discover a new drink last night?";
}


-(void) growButtonTapped: (UIButton *)sender
{
    NSString *nameSought = @"Grow";
    NSPredicate *growSearch = [NSPredicate predicateWithFormat:@"name==%@", nameSought];
    NSArray *growVerticals = [self.verticals filteredArrayUsingPredicate:growSearch];
    self.verticalSelected= growVerticals[0];
    
    [self dimVerticalButtons];
    UIButton *growButton = self.verticalButtons[3];
    growButton.alpha = 1.0;
    
//    self.leftQuoteLabel.textColor = [UIColor greatistGrowColor];
//    self.rightQuoteLabel.textColor = [UIColor greatistGrowColor];
//    self.postContentTextView.text = @"How do you feel today?";
}

-(void) connectButtonTapped: (UIButton *)sender
{
    NSString *nameSought = @"Connect";
    NSPredicate *connectSearch = [NSPredicate predicateWithFormat:@"name==%@", nameSought];
    NSArray *connectVerticals = [self.verticals filteredArrayUsingPredicate:connectSearch];
    self.verticalSelected= connectVerticals[0];
    
    [self dimVerticalButtons];
    UIButton *connectButton = self.verticalButtons[4];
    connectButton.alpha = 1.0;
    
//    self.leftQuoteLabel.textColor = [UIColor greatistConnectColor];
//    self.rightQuoteLabel.textColor = [UIColor greatistConnectColor];
//    self.postContentTextView.text = @"Talk to the World";
}

- (void)dimVerticalButtons
{
    for (UIButton *button in self.verticalButtons) {
        button.alpha = 0.3;
    }
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

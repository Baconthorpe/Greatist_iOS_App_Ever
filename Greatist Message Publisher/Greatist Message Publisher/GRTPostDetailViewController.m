//
//  GRTPostDetailViewController.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTPostDetailViewController.h"
#import "GRTDataStore.h"

@interface GRTPostDetailViewController ()

@property (strong, nonatomic) GRTDataStore *dataStore;


@end

@implementation GRTPostDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataStore = [GRTDataStore sharedDataStore];

    [self createPostDetail];
    [self createResponses];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createPostDetail
{
    UIView *postDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
    [self.view addSubview:postDetailView];
    
    UILabel *postDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
    [postDetailLabel setText:@"“ If you're not eating these foods, you should be, no matter who you are, what you do, and whether you have serious food sensitivites!! ”"];
    [postDetailLabel setNumberOfLines:0];
    [postDetailLabel setFont:[UIFont fontWithName:@"ArcherPro-SemiboldItalic" size:24]];
    [postDetailLabel setTextColor:[UIColor greatistEatColor]];
    [postDetailView addSubview:postDetailLabel];
    
    UIButton *flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flagButton setFrame:CGRectMake(20, 280, 140, 20)];
    [flagButton setTitleColor:[UIColor greatistBlueColor] forState:UIControlStateNormal];
    [flagButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:10]];
    flagButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    flagButton.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    [flagButton setTitle:@"FLAG INAPPROPRIATE" forState:UIControlStateNormal];
    FAKFontAwesome *flagIcon = [FAKFontAwesome flagIconWithSize:15];
    [flagIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistBlueColor]];
    UIImage *flagImage = [[flagIcon imageWithSize:CGSizeMake(20, 20)] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    flagIcon.iconFontSize = 15;
    [flagButton setBackgroundImage:flagImage forState:UIControlStateNormal];
    [postDetailView addSubview:flagButton];
}

- (void)createResponses
{
    UIView *responseView = [[UIView alloc]initWithFrame:CGRectMake(0, 320, 320, 100)];
    [responseView setBackgroundColor:[UIColor greatistLightGrayColor]];
    [self.view addSubview:responseView];
    
    UIButton *glassButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [glassButton setFrame:CGRectMake(40, 20, 100, 20)];
    [glassButton setTitleColor:[UIColor greatistPlayColor] forState:UIControlStateNormal];
    [glassButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:12]];
    glassButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    glassButton.contentEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    [glassButton setTitle:@"CHEERS" forState:UIControlStateNormal];
    FAKFontAwesome *glassIcon = [FAKFontAwesome glassIconWithSize:20];
    [glassIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistPlayColor]];
    UIImage *glassImage = [[glassIcon imageWithSize:CGSizeMake(20, 20)] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    glassIcon.iconFontSize = 20;
    [glassButton setBackgroundImage:glassImage forState:UIControlStateNormal];
    [responseView addSubview:glassButton];
    
    UIButton *rocketButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rocketButton setFrame:CGRectMake(40, 50, 100, 20)];
    [rocketButton setTitleColor:[UIColor greatistMoveColor] forState:UIControlStateNormal];
    [rocketButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:12]];
    rocketButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    rocketButton.contentEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    [rocketButton setTitle:@"YOU GO GIRL" forState:UIControlStateNormal];
    FAKFontAwesome *rocketIcon = [FAKFontAwesome rocketIconWithSize:20];
    [rocketIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistMoveColor]];
    UIImage *rocketImage = [[rocketIcon imageWithSize:CGSizeMake(20, 20)] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    rocketIcon.iconFontSize = 20;
    [rocketButton setBackgroundImage:rocketImage forState:UIControlStateNormal];
    [responseView addSubview:rocketButton];
    
    UIButton *smileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [smileButton setFrame:CGRectMake(150, 20, 100, 20)];
    [smileButton setTitleColor:[UIColor greatistGrowColor] forState:UIControlStateNormal];
    [smileButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:12]];
    smileButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    smileButton.contentEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    [smileButton setTitle:@"SMILES" forState:UIControlStateNormal];
    FAKFontAwesome *smileIcon = [FAKFontAwesome smileOIconWithSize:20];
    [smileIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistGrowColor]];
    UIImage *smileImage = [[smileIcon imageWithSize:CGSizeMake(20, 20)] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    smileIcon.iconFontSize = 20;
    [smileButton setBackgroundImage:smileImage forState:UIControlStateNormal];
    [responseView addSubview:smileButton];
    
    UIButton *frownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [frownButton setFrame:CGRectMake(150, 50, 100, 20)];
    [frownButton setTitleColor:[UIColor greatistEatColor] forState:UIControlStateNormal];
    [frownButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:12]];
    frownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    frownButton.contentEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    [frownButton setTitle:@"HUGS" forState:UIControlStateNormal];
    FAKFontAwesome *frownIcon = [FAKFontAwesome smileOIconWithSize:20];
    [frownIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistEatColor]];
    UIImage *frownImage = [[frownIcon imageWithSize:CGSizeMake(20, 20)] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    frownIcon.iconFontSize = 20;
    [frownButton setBackgroundImage:frownImage forState:UIControlStateNormal];
    [responseView addSubview:frownButton];

}

@end

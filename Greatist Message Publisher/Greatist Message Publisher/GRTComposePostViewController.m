//
//  GRTComposePostViewController.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTComposePostViewController.h"
#import "GRTDataStore.h"

@interface GRTComposePostViewController ()

@property (weak, nonatomic) IBOutlet UITextView *postContentTextView;
@property (weak, nonatomic) IBOutlet UIView *postView;
- (IBAction)backButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *leftQuoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightQuoteLabel;

@property (strong, nonatomic) GRTDataStore *dataStore;

@end

@implementation GRTComposePostViewController

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
    
    //self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:65/255.0 green:64/255.0 blue:66/255.0 alpha:1.0];
    
    UIImage *navBar = [UIImage imageNamed:@"navBar.png"];
    [self.navigationController.navigationBar setBackgroundImage:navBar forBarMetrics:UIBarMetricsDefault];
    
//    self.navigationController.toolbar.backgroundColor = [UIColor colorWithRed:65/255.0 green:64/255.0 blue:66/255.0 alpha:1.0];
    
    self.postContentTextView.delegate = self;
    [self.postContentTextView setTextColor:[UIColor colorWithRed:65/255 green:64/255.0 blue:66/255.0 alpha:1.0]];
    [[self.postContentTextView layer] setBorderColor:[[UIColor colorWithRed:65/255 green:64/255.0 blue:66/255.0 alpha:1.0] CGColor]];
    [[self.postContentTextView layer] setBorderWidth:1];
    [[self.postContentTextView layer] setCornerRadius:15];
    self.postContentTextView.textContainerInset = UIEdgeInsetsMake(15.0, 10.0, 15.0, 10.0);
    self.leftQuoteLabel.font = [UIFont fontWithName:@"ArcherPro-Semibold" size:40];
    self.rightQuoteLabel.font = [UIFont fontWithName:@"ArcherPro-Semibold" size:40];
    // Do any additional setup after loading the view.
    self.dataStore = [GRTDataStore sharedDataStore];
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];

    [self setupCategoryButtons];
    [self setupPostContent];
    [self setupPostButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"%@", textView.text);
    [textView setTextColor:[UIColor greatistLightGrayColor]];
    [textView setText:@""];
}

- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper Methods
- (void)setupCategoryButtons
{
    UIButton *eatButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [eatButton setFrame:CGRectMake(65, 20, 30, 30)];
    [eatButton setBackgroundImage:[UIImage imageNamed:@"Eat_Colored60x60"] forState:UIControlStateNormal];
    [self.postView addSubview:eatButton];
    
    UILabel *eatLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 25, 30, 30)];
    [eatLabel setText:@"EAT"];
    [eatLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [eatLabel setTextColor:[UIColor greatistEatColor]];
    [eatButton addSubview:eatLabel];
    
    UIButton *growButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [growButton setFrame:CGRectMake(115, 20, 30, 30)];
    [growButton setBackgroundImage:[UIImage imageNamed:@"Grow_Colored60x60"] forState:UIControlStateNormal];
    [self.postView addSubview:growButton];
    
    UILabel *growLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 25, 30, 30)];
    [growLabel setText:@"GROW"];
    [growLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [growLabel setTextColor:[UIColor greatistGrowColor]];
    [growButton addSubview:growLabel];
    
    UIButton *moveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [moveButton setFrame:CGRectMake(165, 20, 30, 30)];
    [moveButton setBackgroundImage:[UIImage imageNamed:@"Move_Colored60x60"] forState:UIControlStateNormal];
    [self.postView addSubview:moveButton];
    
    UILabel *moveLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 25, 30, 30)];
    [moveLabel setText:@"MOVE"];
    [moveLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [moveLabel setTextColor:[UIColor greatistMoveColor]];
    [moveButton addSubview:moveLabel];
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [playButton setFrame:CGRectMake(215, 20, 30, 30)];
    [playButton setBackgroundImage:[UIImage imageNamed:@"Play_Colored60x60"] forState:UIControlStateNormal];
    [self.postView addSubview:playButton];
    
    UILabel *playLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 25, 30, 30)];
    [playLabel setText:@"PLAY"];
    [playLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [playLabel setTextColor:[UIColor greatistPlayColor]];
    [playButton addSubview:playLabel];
}

- (void)setupPostContent
{
    self.postContentTextView.delegate = self;
    [self.postContentTextView setFrame:CGRectMake(0, 0, 320, 320)];
    [self.postContentTextView setTextColor:[UIColor greatistPrimaryColor]];
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
    [postButton setFrame:CGRectMake(145, 250, 30, 30)];
    [self.postView addSubview:postButton];
}
@end

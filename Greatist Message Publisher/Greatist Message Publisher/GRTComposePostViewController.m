//
//  GRTComposePostViewController.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTComposePostViewController.h"
#import "GRTDataStore.h"
#import "GRTSelectResponseViewController.h"

@interface GRTComposePostViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@property (weak, nonatomic) IBOutlet UITextView *postContentTextView;
@property (weak, nonatomic) IBOutlet UIView *postView;
- (IBAction)backButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *leftQuoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightQuoteLabel;
@property (strong, nonatomic) Section *verticalSelected;
@property (strong, nonatomic) NSArray *verticalButtons;;
@property (strong, nonatomic) NSMutableArray *selectedCells;

@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (nonatomic) BOOL isDisplayingPlaceholder;
@property (nonatomic) NSString *currentPlaceholder;

@property (strong, nonatomic) GRTDataStore *dataStore;

@end

@implementation GRTComposePostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
    self.dataStore = [GRTDataStore sharedDataStore];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textViewDidChange:(UITextView *)textView
{

    if ([self.postContentTextView.text length] < 10 || [self.postContentTextView.text length] >140) {
        self.nextButton.enabled = NO;
    }
    else {
        self.nextButton.enabled = YES;
    }
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GRTSelectResponseViewController *nextViewController = segue.destinationViewController;
    nextViewController.verticalPassed = self.verticalSelected;
    nextViewController.content = self.postContentTextView.text;
 
    
    
}

- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Helper Methods
- (void)initialize
{
    self.view.backgroundColor = [UIColor greatistLightGrayColor];
    [self setupCategoryButtons];
    [self setupPostContent];
    [self healthButtonTapped: nil];
    [self.postContentTextView becomeFirstResponder];
    self.verticals = [self.dataStore dictionaryOfSections];
    self.verticalSelected = self.verticals[@"health"];
    [self.cancelButton setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIFont fontWithName:@"DINOT-Medium" size:18],
                                                NSFontAttributeName,
                                                nil]
                                     forState:UIControlStateNormal];
    [self.nextButton setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                              [UIFont fontWithName:@"DINOT-Medium" size:18],
                                              NSFontAttributeName,
                                              nil]
                                   forState:UIControlStateNormal];
    self.nextButton.enabled = NO;
}

- (void)setupCategoryButtons
{
    UIButton *healthButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [healthButton setFrame:CGRectMake(130, 2, 35, 35)];
    [healthButton setBackgroundImage:[UIImage imageNamed:@"Health_Colored"] forState:UIControlStateNormal];
    healthButton.alpha = 0.3;
    [healthButton addTarget:self action:@selector(healthButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:healthButton];
    
    UILabel *healthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 45, 25)];
    [healthLabel setText:@"HEALTH"];
    [healthLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [healthLabel setTextColor:[UIColor greatistEatColor]];
    [healthButton addSubview:healthLabel];
    
    UIButton *fitnessButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [fitnessButton setFrame:CGRectMake(60, 2, 35, 35)];
    [fitnessButton setBackgroundImage:[UIImage imageNamed:@"Move_Colored60x60"] forState:UIControlStateNormal];
    fitnessButton.alpha = 0.3;
    [fitnessButton addTarget:self action:@selector(fitnessButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:fitnessButton];
    
    UILabel *fitnessLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 45, 25)];
    [fitnessLabel setText:@"FITNESS"];
    [fitnessLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [fitnessLabel setTextColor:[UIColor greatistMoveColor]];
    [fitnessButton addSubview:fitnessLabel];
    
    UIButton *happinessButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [happinessButton setFrame:CGRectMake(195, 2, 35, 35)];
    [happinessButton setBackgroundImage:[UIImage imageNamed:@"Grow_Colored60x60"] forState:UIControlStateNormal];
    happinessButton.alpha = 0.3;
    [happinessButton addTarget:self action:@selector(happinessButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:happinessButton];
    
    UILabel *happinessLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 60, 25)];
    [happinessLabel setText:@"HAPPINESS"];
    [happinessLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [happinessLabel setTextColor:[UIColor greatistGrowColor]];
    [happinessButton addSubview:happinessLabel];
 
    self.verticalButtons = @[healthButton, fitnessButton, happinessButton];
    
}

- (void)setupPostContent
{
    self.postContentTextView.delegate = self;
    [self.postContentTextView setTextColor:[UIColor greatistGrayColor]];
    [self.postContentTextView setFont:[UIFont fontWithName:@"ArcherPro-Semibold" size:20]];
    [[self.postContentTextView layer] setBorderColor:[[UIColor greatistLightGrayColor] CGColor]];
    [[self.postContentTextView layer] setBorderWidth:1];
    [[self.postContentTextView layer] setCornerRadius:2];
    self.postContentTextView.textContainerInset = UIEdgeInsetsMake(15.0, 10.0, 15.0, 10.0);
    
    self.leftQuoteLabel.font = [UIFont fontWithName:@"ArcherPro-Semibold" size:40];
    self.rightQuoteLabel.font = [UIFont fontWithName:@"ArcherPro-Semibold" size:40];
}


#pragma mark - IBAction Methods

-(void)healthButtonTapped: (UIButton *)sender
{
 self.verticalSelected = self.verticals[@"health"];
self.placeholderLabel.text = @"Share your latest yummy recipe!";

   
        [self dimVerticalButtons];
    UIButton *healthButton = self.verticalButtons[0];
    healthButton.alpha = 1.0;
    
    self.leftQuoteLabel.textColor = [UIColor greatistEatColor];
    self.rightQuoteLabel.textColor = [UIColor greatistEatColor];

}

-(void)fitnessButtonTapped: (UIButton *)sender
{
    
    self.verticalSelected = self.verticals[@"fitness"];
    self.placeholderLabel.text = @"Tell us about your morning run";
    
    
    [self dimVerticalButtons];
    UIButton *fitnessButton = self.verticalButtons[1];
    fitnessButton.alpha = 1.0;
    
    self.leftQuoteLabel.textColor = [UIColor greatistMoveColor];
    self.rightQuoteLabel.textColor = [UIColor greatistMoveColor];
    
}


-(void) happinessButtonTapped: (UIButton *)sender
{
    self.verticalSelected = self.verticals[@"happiness"];
    self.placeholderLabel.text = @"What are you excited about today?";
    
    
    
    [self dimVerticalButtons];
    UIButton *happinessButton = self.verticalButtons[2];
    happinessButton.alpha = 1.0;


    self.leftQuoteLabel.textColor = [UIColor greatistGrowColor];
    self.rightQuoteLabel.textColor = [UIColor greatistGrowColor];
    
    }


- (void)dimVerticalButtons
{
    for (UIButton *button in self.verticalButtons) {
        button.alpha = 0.3;
    }
}

@end

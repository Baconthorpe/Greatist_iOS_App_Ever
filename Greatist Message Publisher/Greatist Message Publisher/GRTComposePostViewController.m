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
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UITextView *postContentTextView;
@property (weak, nonatomic) IBOutlet UIView *postView;
- (IBAction)backButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *leftQuoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightQuoteLabel;
@property (strong, nonatomic) Section *verticalSelected;
@property (strong, nonatomic) NSArray *verticalButtons;;
@property (strong, nonatomic) NSMutableArray *selectedCells;
@property (weak, nonatomic) IBOutlet UIButton *selectResponses;
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
    
    self.dataStore = [GRTDataStore sharedDataStore];
    self.view.backgroundColor = [UIColor greatistLightGrayColor];

    
    [self setupCategoryButtons];
    [self setupPostContent];
    
 
    [self healthButtonTapped: nil];
  
    
    
    [self.postContentTextView becomeFirstResponder];
    
    //   self.postContentTextView.delegate = self;
    //   self.isDisplayingPlaceholder = YES;
    //   self.currentPlaceholder = @"This is my sample placeholder text";
    
    self.verticals = [self.dataStore dictionaryOfSections];
    self.verticalSelected = self.verticals[@"health"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void)setupCategoryButtons
{
    UIButton *healthButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [healthButton setFrame:CGRectMake(130, 10, 45, 45)];
    [healthButton setBackgroundImage:[UIImage imageNamed:@"Health_Colored"] forState:UIControlStateNormal];
    healthButton.alpha = 0.3;
    [healthButton addTarget:self action:@selector(healthButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:healthButton];
    
    UILabel *healthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 45, 25)];
    [healthLabel setText:@"HEALTH"];
    [healthLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [healthLabel setTextColor:[UIColor greatistEatColor]];
    [healthButton addSubview:healthLabel];
    
    UIButton *fitnessButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [fitnessButton setFrame:CGRectMake(60, 10, 45, 45)];
    [fitnessButton setBackgroundImage:[UIImage imageNamed:@"Move_Colored60x60"] forState:UIControlStateNormal];
    fitnessButton.alpha = 0.3;
    [fitnessButton addTarget:self action:@selector(fitnessButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:fitnessButton];
    
    UILabel *fitnessLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 45, 25)];
    [fitnessLabel setText:@"FITNESS"];
    [fitnessLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [fitnessLabel setTextColor:[UIColor greatistMoveColor]];
    [fitnessButton addSubview:fitnessLabel];
    
    UIButton *happinessButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [happinessButton setFrame:CGRectMake(195, 10, 45, 45)];
    [happinessButton setBackgroundImage:[UIImage imageNamed:@"Grow_Colored60x60"] forState:UIControlStateNormal];
    happinessButton.alpha = 0.3;
    [happinessButton addTarget:self action:@selector(happinessButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:happinessButton];
    
    UILabel *happinessLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 60, 25)];
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

- (void)postButton:(id)sender
{
    // Fix this to use current user and not Anne
    NSMutableSet *responses = [NSMutableSet new];
    for (NSNumber *index in self.selectedCells) {
        NSInteger indexInteger = [index integerValue];
    }
    [self.dataStore saveContext];
}


-(void)healthButtonTapped: (UIButton *)sender
{
 self.verticalSelected = self.verticals[@"health"];
self.placeholderLabel.text = @"Share your latest yummy recipe!";

   
        [self dimVerticalButtons];
    UIButton *healthButton = self.verticalButtons[0];
    healthButton.alpha = 1.0;
    
    self.leftQuoteLabel.textColor = [UIColor greatistEatColor];
    self.rightQuoteLabel.textColor = [UIColor greatistEatColor];
    
    //    self.postContentTextView.placeholder = @"yummmmm";
    //    self.postContentTextView.placeholderColor = [UIColor greatistLightGrayColor];
    

//    {
//        [self.postContentTextView resignFirstResponder];
//        
//        if (self.isDisplayingPlaceholder)
//        {
//            if ([self.postContentTextView.text isEqualToString:self.currentPlaceholder])
//            {
//                self.postContentTextView.text = @"connect button placeholder";
//                self.postContentTextView.textColor = [UIColor lightGrayColor];
//            }
//            self.currentPlaceholder = @"eat button placeholder";
//        }
//    }
    //self.postContentTextView.text = @"Find a new healthy recipe recently?";
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
    //    self.postContentTextView.placeholder = @"owwwwww";
    //    [self.postContentTextView resignFirstResponder];
    
    //self.postContentTextView.placeholderColor = [UIColor greatistLightGrayColor];

    
//    {
//        [self.postContentTextView resignFirstResponder];
//        
//        if (self.isDisplayingPlaceholder)
//        {
//            if ([self.postContentTextView.text isEqualToString:self.currentPlaceholder])
//            {
//                self.postContentTextView.text = @"connect button placeholder";
//                self.postContentTextView.textColor = [UIColor lightGrayColor];
//            }
//            self.currentPlaceholder = @"eat button placeholder";
//        }
//    }
    //self.postContentTextView.text = @"Do something new at Yoga?";
    
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
    
    //    self.postContentTextView.placeholder = @"yyayyy";
    //    [self.postContentTextView resignFirstResponder];
    
    //  self.postContentTextView.placeholderColor = [UIColor greatistLightGrayColor];
    
    
    //    {
    //        [self.postContentTextView resignFirstResponder];
    //
    //        if (self.isDisplayingPlaceholder)
    //        {
    //            if ([self.postContentTextView.text isEqualToString:self.currentPlaceholder])
    //            {
    //                self.postContentTextView.text = @"connect button placeholder";
    //                self.postContentTextView.textColor = [UIColor lightGrayColor];
    //            }
    //            self.currentPlaceholder = @"eat button placeholder";
    //        }
    //    }

    //self.postContentTextView.text = @"How do you feel today?";
}


- (void)dimVerticalButtons
{
    for (UIButton *button in self.verticalButtons) {
        button.alpha = 0.3;
    }
}



//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    NSLog(@"%@", textView.text);
//    [textView setTextColor:[UIColor greatistGrayColor]];
//    [textView setText:@""];
//}
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//    textView.textColor = [UIColor blackColor];
//    textView.text = @"";
//    
//    return YES;
//}
//
//- (void)textViewDidChange:(UITextView *)textView
//{
//    
//    if ([textView.text isEqualToString:@""])
//    {
//        textView.text = self.currentPlaceholder;
//        textView.textColor = [UIColor lightGrayColor];
//        [textView resignFirstResponder];
//    }
//}


//-(void) connectButtonTapped: (UIButton *)sender
//{
//    NSString *nameSought = @"Connect";
//    NSPredicate *connectSearch = [NSPredicate predicateWithFormat:@"name==%@", nameSought];
//    NSArray *connectVerticals = [self.verticals filteredArrayUsingPredicate:connectSearch];
//    self.verticalSelected= connectVerticals[0];
//
//    [self dimVerticalButtons];
//    UIButton *connectButton = self.verticalButtons[4];
//    connectButton.alpha = 1.0;
//
//    self.leftQuoteLabel.textColor = [UIColor greatistConnectColor];
//    self.rightQuoteLabel.textColor = [UIColor greatistConnectColor];
//    self.postContentTextView.text = @"Talk to the World";
//}





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



//-(void)playButtonTapped: (UIButton *)sender
//{
//    NSString *nameSought = @"Play";
//    NSPredicate *playSearch = [NSPredicate predicateWithFormat:@"name==%@", nameSought];
//    NSArray *playVerticals = [self.verticals filteredArrayUsingPredicate:playSearch];
//    self.verticalSelected= playVerticals[0];
//
//    [self dimVerticalButtons];
//    UIButton *playButton = self.verticalButtons[2];
//    playButton.alpha = 1.0;
//
//    self.leftQuoteLabel.textColor = [UIColor greatistPlayColor];
//    self.rightQuoteLabel.textColor = [UIColor greatistPlayColor];
//    self.postContentTextView.text = @"Discover a new drink last night?";
//}
//


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


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"responseCell"];
//    ResponseOption *responseOption = [self.dataStore.validResponses objectAtIndex:indexPath.row];
//    cell.textLabel.text = responseOption.content;
//    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:12];
//    if ([self.selectedCells containsObject:@(indexPath.row)]) {
//        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//    } else {
//        [cell setAccessoryType:UITableViewCellAccessoryNone];
//    }
//    return cell;
//}



@end

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

@property (weak, nonatomic) IBOutlet UITextView *postContentTextView;
@property (weak, nonatomic) IBOutlet UIView *postView;
- (IBAction)backButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *leftQuoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightQuoteLabel;
@property (strong, nonatomic) Section *verticalSelected;
@property (strong, nonatomic) NSArray *verticalButtons;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *selectedCells;
@property (weak, nonatomic) IBOutlet UIButton *selectResponses;

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self setupCategoryButtons];
    [self setupPostContent];
    //[self setupPostButton];
    [self setupResponseTable];
    [self healthButtonTapped:nil];
   [self.postContentTextView becomeFirstResponder];
    
    
//self.verticals = @[@"happiness", @"health", @"fitness", @"Happiness", @"Health", @"Fitness"];
    
    self.verticals = [self.dataStore dictionaryOfSections];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"%@", textView.text);
    [textView setTextColor:[UIColor greatistGrayColor]];
    [textView setText:@""];
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GRTSelectResponseViewController *nextViewController = segue.destinationViewController;
    nextViewController.verticalPassed = self.verticalSelected;
    nextViewController.content =    self.postContentTextView.text;
    
}
- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Helper Methods
- (void)setupCategoryButtons
{
    UIButton *healthButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [healthButton setFrame:CGRectMake(45, 15, 30, 30)];
    [healthButton setBackgroundImage:[UIImage imageNamed:@"Eat_Colored60x60"] forState:UIControlStateNormal];
    healthButton.alpha = 0.3;
    [healthButton addTarget:self action:@selector(healthButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:healthButton];
    
    UILabel *healthLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 25, 30, 30)];
    [healthLabel setText:@"HEALTH"];
    [healthLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [healthLabel setTextColor:[UIColor greatistEatColor]];
    [healthButton addSubview:healthLabel];
    
    UIButton *fitnessButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [fitnessButton setFrame:CGRectMake(90, 15, 30, 30)];
    [fitnessButton setBackgroundImage:[UIImage imageNamed:@"Move_Colored60x60"] forState:UIControlStateNormal];
    fitnessButton.alpha = 0.3;
    [fitnessButton addTarget:self action:@selector(fitnessButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:fitnessButton];
    
    UILabel *fitnessLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 30, 30)];
    [fitnessLabel setText:@"FITNESS"];
    [fitnessLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [fitnessLabel setTextColor:[UIColor greatistMoveColor]];
    [fitnessButton addSubview:fitnessLabel];
    
    
    UIButton *happinessButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [happinessButton setFrame:CGRectMake(195, 15, 30, 30)];
    [happinessButton setBackgroundImage:[UIImage imageNamed:@"Grow_Colored60x60"] forState:UIControlStateNormal];
    happinessButton.alpha = 0.3;
    [happinessButton addTarget:self action:@selector(happinessButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:happinessButton];
    
    UILabel *happinessLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 25, 30, 30)];
    [happinessLabel setText:@"HAPPINESS"];
    [happinessLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [happinessLabel setTextColor:[UIColor greatistGrowColor]];
    [happinessButton addSubview:happinessLabel];
 self.verticalButtons = @[healthButton, fitnessButton, happinessButton];
    
}

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

//-(void)setupPostButton
//{
//    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    UIImage *resizedPostImage = [UIImage imageWithImage:[UIImage imageNamed:@"Greatist_Logo_Badge_Blue"] scaledToSize:CGSizeMake(50, 50)];
//    [postButton setBackgroundImage:resizedPostImage forState:UIControlStateNormal];
//    [postButton setFrame:CGRectMake(145, 215, 30, 30)];
//    [postButton addTarget:self action:@selector(postButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.postView addSubview:postButton];
//}

- (void)setupResponseTable
{
    self.selectedCells = [[NSMutableArray alloc] init];
}


#pragma mark - Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataStore.validResponses count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"responseCell"];
    ResponseOption *responseOption = [self.dataStore.validResponses objectAtIndex:indexPath.row];
    cell.textLabel.text = responseOption.content;
    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:12];
    if ([self.selectedCells containsObject:@(indexPath.row)]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.selectedCells containsObject:@(indexPath.row)]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.selectedCells removeObject:@(indexPath.row)];
    } else {
        if ([self.selectedCells count] < 4) {
            [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            [self.selectedCells addObject:@(indexPath.row)];
        }
    }
    [tableView reloadData];
}

#pragma mark - IBAction Methods

- (void)postButton:(id)sender
{
    // Fix this to use current user and not Anne
    NSMutableSet *responses = [NSMutableSet new];
    for (NSNumber *index in self.selectedCells) {
        NSInteger indexInteger = [index integerValue];
        Response *newResponse = [Response responseWithResponseOption:self.dataStore.validResponses[indexInteger] inContext:self.dataStore.managedObjectContext];
        [responses addObject:newResponse];
    }
    [self.dataStore saveContext];
    
    // Fix this to use current user and not Anne
//    Post *newPost = [Post postWithContent:self.postContentTextView.text author:anne section:self.verticalSelected responses:responses inContext:self.dataStore.managedObjectContext];
  //  [self.dataStore saveContext];
    
    
}

- (void)verticalButtonTapped:(UIButton *)sender
{
    
}

-(void)healthButtonTapped: (UIButton *)sender
{
    self.verticalSelected = self.verticals[@"health"];
    
    [self dimVerticalButtons];
    UIButton *healthButton = self.verticalButtons[0];
    healthButton.alpha = 1.0;
    
    self.leftQuoteLabel.textColor = [UIColor greatistEatColor];
    self.rightQuoteLabel.textColor = [UIColor greatistEatColor];
    self.postContentTextView.text = @"Find a new healthy recipe recently?";
}

-(void)fitnessButtonTapped: (UIButton *)sender
{
    self.verticalSelected = self.verticals[@"fitness"];
    
    [self dimVerticalButtons];
    UIButton *fitnessButton = self.verticalButtons[1];
    fitnessButton.alpha = 1.0;
    
    self.leftQuoteLabel.textColor = [UIColor greatistMoveColor];
    self.rightQuoteLabel.textColor = [UIColor greatistMoveColor];
    self.postContentTextView.text = @"Do something new at Yoga?";
    
}


-(void) happinessButtonTapped: (UIButton *)sender
{
    self.verticalSelected = self.verticals[@"happiness"];
    
    [self dimVerticalButtons];
    UIButton *happinessButton = self.verticalButtons[2];
    happinessButton.alpha = 1.0;

    self.leftQuoteLabel.textColor = [UIColor greatistGrowColor];
    self.rightQuoteLabel.textColor = [UIColor greatistGrowColor];
    self.postContentTextView.text = @"How do you feel today?";
}


- (void)dimVerticalButtons
{
    for (UIButton *button in self.verticalButtons) {
        button.alpha = 0.3;
    }
}


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






@end

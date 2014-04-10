//
//  GRTComposePostViewController.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTComposePostViewController.h"
#import "GRTDataStore.h"
#import "Post+Methods.h"
#import "Section+Methods.h"
#import "UIColor+Helpers.h"
#import "Response+Methods.h"

@interface GRTComposePostViewController ()

@property (weak, nonatomic) IBOutlet UITextView *postContentTextView;
@property (weak, nonatomic) IBOutlet UIView *postView;
- (IBAction)backButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *leftQuoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightQuoteLabel;
@property (strong, nonatomic) Section *verticalSelected;
@property (strong, nonatomic) UIButton *eatButton;
@property (strong, nonatomic) NSArray *verticalButtons;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableIndexSet *selectedCells;

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

    self.dataStore = [GRTDataStore sharedDataStore];
    self.view.backgroundColor = [UIColor greatistLightGrayColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self setupCategoryButtons];
    [self setupPostContent];
    [self setupPostButton];
    [self setupResponseTable];
    [self growButtonTapped:nil];
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
    [textView setTextColor:[UIColor greatistGrayColor]];
    [textView setText:@""];
}

- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper Methods
- (void)setupCategoryButtons
{
    UIButton *eatButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [eatButton setFrame:CGRectMake(45, 15, 30, 30)];
    [eatButton setBackgroundImage:[UIImage imageNamed:@"Eat_Colored60x60"] forState:UIControlStateNormal];
    eatButton.alpha = 0.3;
    [eatButton addTarget:self action:@selector(eatButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:eatButton];
    
    UILabel *eatLabel = [[UILabel alloc] initWithFrame:CGRectMake(7, 25, 30, 30)];
    [eatLabel setText:@"EAT"];
    [eatLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [eatLabel setTextColor:[UIColor greatistEatColor]];
    [eatButton addSubview:eatLabel];
    
    UIButton *moveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [moveButton setFrame:CGRectMake(90, 15, 30, 30)];
    [moveButton setBackgroundImage:[UIImage imageNamed:@"Move_Colored60x60"] forState:UIControlStateNormal];
    moveButton.alpha = 0.3;
    [moveButton addTarget:self action:@selector(moveButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:moveButton];
    
    UILabel *moveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 30, 30)];
    [moveLabel setText:@"MOVE"];
    [moveLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [moveLabel setTextColor:[UIColor greatistMoveColor]];
    [moveButton addSubview:moveLabel];
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [playButton setFrame:CGRectMake(240, 15, 30, 30)];
    [playButton setBackgroundImage:[UIImage imageNamed:@"Play_Colored60x60"] forState:UIControlStateNormal];
    playButton.alpha = 0.3;
    [playButton addTarget:self action:@selector(playButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:playButton];
    
    UILabel *playLabel = [[UILabel alloc] initWithFrame:CGRectMake(3, 25, 30, 30)];
    [playLabel setText:@"PLAY"];
    [playLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [playLabel setTextColor:[UIColor greatistPlayColor]];
    [playButton addSubview:playLabel];
    
    UIButton *growButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [growButton setFrame:CGRectMake(195, 15, 30, 30)];
    [growButton setBackgroundImage:[UIImage imageNamed:@"Grow_Colored60x60"] forState:UIControlStateNormal];
    growButton.alpha = 0.3;
    [growButton addTarget:self action:@selector(growButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:growButton];
    
    UILabel *growLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 25, 30, 30)];
    [growLabel setText:@"GROW"];
    [growLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [growLabel setTextColor:[UIColor greatistGrowColor]];
    [growButton addSubview:growLabel];
    
    UIButton *connectButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [connectButton setFrame:CGRectMake(140, 15, 30, 30)];
    [connectButton setBackgroundImage:[UIImage imageNamed:@"Connect_Colored"] forState:UIControlStateNormal];
    connectButton.alpha = 0.3;
    [connectButton addTarget:self action:@selector(connectButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:connectButton];
    
    UILabel *connectLabel = [[UILabel alloc] initWithFrame:CGRectMake(-5, 25, 50, 30)];
    [connectLabel setText:@"CONNECT"];
    [connectLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [connectLabel setTextColor:[UIColor greatistConnectColor]];
    [connectButton addSubview:connectLabel];
    
    self.verticalButtons = @[eatButton, moveButton, playButton, growButton, connectButton];
    
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

-(void)setupPostButton
{
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *resizedPostImage = [UIImage imageWithImage:[UIImage imageNamed:@"Greatist_Logo_Badge_Blue"] scaledToSize:CGSizeMake(50, 50)];
    [postButton setBackgroundImage:resizedPostImage forState:UIControlStateNormal];
    [postButton setFrame:CGRectMake(145, 215, 30, 30)];
    [postButton addTarget:self action:@selector(postButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:postButton];
}

- (void)setupResponseTable
{
    self.selectedCells = [[NSMutableIndexSet alloc] init];
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
    NSString *response = [self.dataStore.validResponses objectAtIndex:indexPath.row];
    cell.textLabel.text = response;
    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Roman" size:14];
    if ([self.selectedCells containsIndex:indexPath.row]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.selectedCells containsIndex:indexPath.row]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.selectedCells removeIndex:indexPath.row];
    } else {
        if ([self.selectedCells count] < 4) {
            [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
            [self.selectedCells addIndex:indexPath.row];
        }
    }
    [tableView reloadData];
}

#pragma mark - IBAction Methods

- (void)postButton:(id)sender
{
    [Post postWithContent:self.postContentTextView.text author:nil section:self.verticalSelected responses:nil inContext:self.dataStore.managedObjectContext];
    [self.dataStore saveContext];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
- (void)verticalButtonTapped:(UIButton *)sender
{

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
    
    self.leftQuoteLabel.textColor = [UIColor greatistEatColor];
    self.rightQuoteLabel.textColor = [UIColor greatistEatColor];
    self.postContentTextView.text = @"Find a new healthy recipe recently?";
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
    
    self.leftQuoteLabel.textColor = [UIColor greatistMoveColor];
    self.rightQuoteLabel.textColor = [UIColor greatistMoveColor];
    self.postContentTextView.text = @"Do something new at Yoga?";
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
    
    self.leftQuoteLabel.textColor = [UIColor greatistPlayColor];
    self.rightQuoteLabel.textColor = [UIColor greatistPlayColor];
    self.postContentTextView.text = @"Discover a new drink last night?";
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
-(void) connectButtonTapped: (UIButton *)sender
{
    NSString *nameSought = @"Connect";
    NSPredicate *connectSearch = [NSPredicate predicateWithFormat:@"name==%@", nameSought];
    NSArray *connectVerticals = [self.verticals filteredArrayUsingPredicate:connectSearch];
    self.verticalSelected= connectVerticals[0];
    
    [self dimVerticalButtons];
    UIButton *connectButton = self.verticalButtons[4];
    connectButton.alpha = 1.0;
    
    self.leftQuoteLabel.textColor = [UIColor greatistConnectColor];
    self.rightQuoteLabel.textColor = [UIColor greatistConnectColor];
    self.postContentTextView.text = @"Talk to the World";
}













@end

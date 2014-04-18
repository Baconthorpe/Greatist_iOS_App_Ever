//
//  GRTSelectResponseViewController.m
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/16/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTSelectResponseViewController.h"
#import "GRTDataStore.h"
#import "GRTComposePostViewController.h"
#import "Post+Methods.h"
#import "GRTMainTableViewController.h"
#import "GRTDataManager.h"

@interface GRTSelectResponseViewController ()
@property (strong, nonatomic) NSMutableArray *selectedCells;
@property (weak, nonatomic) IBOutlet UILabel *responseLabel;
@property (strong, nonatomic) GRTDataStore *dataStore;
@property (strong, nonatomic) GRTDataManager *dataManager;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navPostButton;

@end

@implementation GRTSelectResponseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
}
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataStore = [GRTDataStore sharedDataStore];
    self.dataManager = [GRTDataManager sharedManager];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setupResponseTable];
    self.responseLabel.font = [UIFont fontWithName:@"DINOT-Bold" size:14];
    self.responseLabel.textColor = [UIColor greatistLightGrayColor];
    self.responseLabel.backgroundColor = [UIColor whiteColor];
    
     NSIndexPath *zero = [NSIndexPath indexPathForRow:0 inSection:0];
     NSIndexPath *one = [NSIndexPath indexPathForRow:1 inSection:0];
     NSIndexPath *two = [NSIndexPath indexPathForRow:2 inSection:0];
     NSIndexPath *three = [NSIndexPath indexPathForRow:3 inSection:0];
    
    
    if ([self.tableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:zero];
        [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:one];
        [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:two];
        [self.tableView.delegate tableView:self.tableView didSelectRowAtIndexPath:three];


    }
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)navPostButton:(id)sender
{
    [self postPostThroughParse];
    NSMutableSet *responses = [NSMutableSet new];
    for (NSNumber *index in self.selectedCells) {
        NSInteger indexInteger = [index integerValue];
        Response *newResponse = [Response responseWithResponseOption:self.dataStore.validResponses[indexInteger] inContext:self.dataStore.managedObjectContext];
        [responses addObject:newResponse];
    }
    
    
    [self.dataStore saveContext];
    
    
    // Fix this to use current user and not Anne
Post *newPost = [Post postWithContent:self.content
                               author:nil
                              section:self.verticalPassed
                            responses:responses
                            inContext:self.dataStore.managedObjectContext];
    [self.dataStore saveContext];

//    // Fix this to use current user and not Anne
//    User *anne = [User userWithName:@"Anne" uniqueID:@"anne" inContext:self.dataStore.managedObjectContext];
//    
//    NSMutableSet *responses = [NSMutableSet new];
//    for (NSNumber *index in self.selectedCells) {
//        NSInteger indexInteger = [index integerValue];
//        Response *newResponse = [Response responseWithResponseOption:self.dataStore.validResponses[indexInteger] inContext:self.dataStore.managedObjectContext];
//        [responses addObject:newResponse];
//    }
//    
//    
//    [self.dataStore saveContext];
//    
//    
//    // Fix this to use current user and not Anne
//    Post *newPost = [Post postWithContent:self.content author:anne section:self.verticalPassed responses:responses inContext:self.dataStore.managedObjectContext];
//    [self.dataStore saveContext];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) postPostThroughParse
{
    [self.dataManager postPostAndSaveIfSuccessfulForContent:self.content inSection:self.verticalPassed];
}

//-(void)setupPostButton
//{
//    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    UIImage *resizedPostImage = [UIImage imageWithImage:[UIImage imageNamed:@"Greatist_Logo_Badge_Blue"] scaledToSize:CGSizeMake(50, 50)];
//    [postButton setBackgroundImage:resizedPostImage forState:UIControlStateNormal];
//    [postButton setFrame:CGRectMake(145, 215, 30, 30)];
//    [postButton addTarget:self action:@selector(postButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.tableView addSubview:postButton];
//}

- (void)setupResponseTable
{
    self.selectedCells = [[NSMutableArray alloc] init];
}


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
            [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            [self.selectedCells addObject:@(indexPath.row)];
        }
    }
    [tableView reloadData];
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

//- (void)postButton:(id)sender
//{
//    // Fix this to use current user and not Anne
//    User *anne = [User userWithName:@"Anne" uniqueID:@"anne" inContext:self.dataStore.managedObjectContext];
//
//    NSMutableSet *responses = [NSMutableSet new];
//    for (NSNumber *index in self.selectedCells) {
//        NSInteger indexInteger = [index integerValue];
//        Response *newResponse = [Response responseWithResponseOption:self.dataStore.validResponses[indexInteger] inContext:self.dataStore.managedObjectContext];
//        [responses addObject:newResponse];
//    }
//    [self.dataStore saveContext];
//
//    // Fix this to use current user and not Anne
//    //Post *newPost = [Post postWithContent:self.postContentTextView.text author:anne section:self.verticalSelected responses:responses inContext:self.dataStore.managedObjectContext];
//    [self.dataStore saveContext];
//    [self dismissViewControllerAnimated:YES completion:nil];
//
//}

@end

//
//  GRTSelectResponseViewController.m
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/16/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTSelectResponseViewController.h"
#import "GRTMainTableViewController.h"
#import "GRTDataStore.h"
#import "GRTDataManager.h"
#import "UIFont+Helpers.h"

@interface GRTSelectResponseViewController ()
@property (strong, nonatomic) GRTDataStore *dataStore;
@property (strong, nonatomic) GRTDataManager *dataManager;
@property (strong, nonatomic) NSMutableArray *selectedCells;
@property (weak, nonatomic) IBOutlet UILabel *responseLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navPostButton;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;


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
    [self setupResponseTable];
    self.responseLabel.font = [UIFont fontWithName:@"DINOT-Medium" size:16];
    self.responseLabel.textColor = [UIColor greatistGrayColor];
    
//    self.responseLabel.backgroundColor = [UIColor greatistLightGrayColor];
//    [self.navPostButton setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
//                                              [UIFont fontWithName:@"DINOT-Medium" size:18],
//                                              NSFontAttributeName,
//                                              nil]
//                                   forState:UIControlStateNormal];
    
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction Methods

- (IBAction)navPostButton:(id)sender
{
    [self createDictionaryOfSelectedResponses];
    
    [self postPostThroughParseWithCompletion:^(BOOL isSuccessful) {
        if (isSuccessful) {
            [Post postWithContent:self.content
                           author:nil
                          section:self.verticalPassed
                        responses:[self.dataStore getSelectedResponsesAsJSONString]
                        inContext:self.dataStore.managedObjectContext];
            [self.dataStore saveContext];
        } else {
            // Add Alertview
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - TableView DataStore Methods

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
    ResponseOption *currentResponseOption = [self.dataStore.validResponses objectAtIndex:indexPath.row];
    cell.textLabel.text = currentResponseOption.content;
    cell.textLabel.font = [UIFont fontWithName:@"DINOT-Medium" size:14];
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


#pragma mark - Helper Methods

- (void)setupResponseTable
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.responseLabel.font = [UIFont fontWithName:@"DINOT-Bold" size:14];
    self.responseLabel.textColor = [UIColor greatistLightGrayColor];
    self.responseLabel.backgroundColor = [UIColor whiteColor];
    
    self.selectedCells = [[NSMutableArray alloc] init];
    
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
}

- (void) postPostThroughParseWithCompletion: (void (^)(BOOL isSuccessful))completion
{
    [self.dataManager postPostAndSaveIfUnique:self.content
                                    inSection:self.verticalPassed
                                withResponses:[self.dataStore getSelectedResponsesAsJSONString]
                               withCompletion:^(NSDictionary *postResponse) {
    }];
}

- (void) createDictionaryOfSelectedResponses
{
    self.dataStore.selectedResponses = [NSMutableDictionary new];
    for (NSNumber *index in self.selectedCells) {
        NSInteger indexInteger = [index integerValue];
        ResponseOption *currentResponseOption = [self.dataStore.validResponses objectAtIndex:indexInteger];
        NSString *responseKey = currentResponseOption.content;
        [self.dataStore.selectedResponses setValue:@0 forKey:responseKey];
    }
}



@end

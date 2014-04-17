//
//  GRTStepThreeComposePost.m
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTStepThreeComposePost.h"
#import "Section+Methods.h"
#import "GRTDataStore.h"


@interface GRTStepThreeComposePost ()
@property (weak, nonatomic) IBOutlet UITextView *postContentTextView;
@property (weak, nonatomic) IBOutlet UIView *postView;
- (IBAction)backButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *leftQuoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightQuoteLabel;
@property (strong, nonatomic) Section *verticalSelected;
@property (strong, nonatomic) UIButton *eatButton;
@property (strong, nonatomic) NSArray *verticalButtons;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *selectedCells;
@property (strong, nonatomic) GRTDataStore *dataStore;
@end

@implementation GRTStepThreeComposePost
//in this view the user selects up to four responses that they're like to recieve and selects post to finalize

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
- (void)postButton:(id)sender
{
    // Fix this to use current user and not Anne
    User *anne = [User getUserWithFacebookID:@"1084710028" inContext:self.dataStore.managedObjectContext];
    
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
    //[self dismissViewControllerAnimated:YES completion:nil];
    
}




@end

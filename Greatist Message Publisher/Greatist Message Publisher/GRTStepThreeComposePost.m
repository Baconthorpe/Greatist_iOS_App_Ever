//
//  GRTStepThreeComposePost.m
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTStepThreeComposePost.h"

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



@end

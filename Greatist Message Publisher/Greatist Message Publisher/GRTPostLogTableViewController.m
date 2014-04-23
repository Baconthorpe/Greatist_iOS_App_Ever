//
//  GRTPostLogTableViewController.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/20/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTPostLogTableViewController.h"
#import "GRTMainViewController.h"
#import "GRTPostTableViewCell.h"
#import "GRTDataStore.h"
#import "Post+Methods.h"
#import "Section+Methods.h"
#import "GRTCornerTriangles.h"
#import "GRTDataManager.h"
#import "GRTPostDetailViewController.h"

@interface GRTPostLogTableViewController ()
@property (strong, nonatomic) Section *section;
@property (strong, nonatomic) GRTCornerTriangles *cornerTriangle;
@property (strong, nonatomic) GRTDataStore *dataStore;
@property (strong, nonatomic) GRTDataManager *dataManager;

@end

@implementation GRTPostLogTableViewController

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
    [self initialize];
    [self.dataManager getPostsBasedOnFacebookFriends];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialize
{
    [self.tableView registerNib:[UINib nibWithNibName:@"GRTTableViewCell" bundle:nil] forCellReuseIdentifier:@"postCell"];
    self.dataStore = [GRTDataStore sharedDataStore];
    self.dataManager = [GRTDataManager sharedManager];
    self.dataStore.userPostFRController.delegate = self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (GRTPostTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GRTPostTableViewCell *cell = (GRTPostTableViewCell *)[self configureCellForMainTableViewWithIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataStore.userPostFRController.sections[0] numberOfObjects];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"logToDetail" sender:self];
}


- (GRTPostTableViewCell *) configureCellForMainTableViewWithIndexPath: (NSIndexPath *)indexPath
{
    GRTPostTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"postCell"];
    Post *post = [self.dataStore.userPostFRController objectAtIndexPath:indexPath];
    [cell configureWithPost:post];
    
    GRTCornerTriangles *leftCornerTriangle = [[GRTCornerTriangles alloc] initWithFrame:cell.bounds IsLeftTriangle:YES withFillColor:[UIColor greatistFitnessColor]];
    
    //GRTCornerTriangles *rightCornerTriangle = [[GRTCornerTriangles alloc] initWithFrame:cell.bounds IsLeftTriangle:NO withFillColor:[UIColor greatistFitnessColor]];
    
    
    cell.backgroundColor = [UIColor greatistColorForCategory:post.section.name];
    cell.buttonBar.backgroundColor=[UIColor whiteColor];
    
    for (UIView *view in cell.contentView.subviews) {
        if (![view isEqual:cell.postLabel] && ![view isEqual:cell.buttonBar]) {
            [view removeFromSuperview];
        }
    }
    
    UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
    separatorLineView.backgroundColor = [UIColor greatistLightGrayColor];
    [cell.contentView addSubview:separatorLineView];
    
    if (([post.section.name isEqualToString:(@"fitness")]) && (indexPath.row % 2 == 0))
    {
        cell.backgroundColor = [UIColor greatistFitnessColor];
        cell.buttonBar.backgroundColor=[UIColor whiteColor];
        [cell.contentView addSubview:leftCornerTriangle];
        [leftCornerTriangle setFillColor:[UIColor greatistFitnessColorSecondary]];
        
        UIImage *fitnessIconImage = [UIImage imageNamed:@"Move_White"];
        UIImage *scaledFitnessIconImage = [UIImage imageWithImage:fitnessIconImage scaledToSize:CGSizeMake(25, 20)];
        UIImageView *fitnessIconView = [[UIImageView alloc] initWithImage:scaledFitnessIconImage];
        [cell.contentView addSubview:fitnessIconView];
        [fitnessIconView setFrame:CGRectMake(10, 15, 25, 20)];
        
    }
        else if ([post.section.name isEqualToString:(@"health")])
    {
        cell.backgroundColor = [UIColor greatistHealthColor];
        cell.buttonBar.backgroundColor=[UIColor whiteColor];
        [cell.contentView addSubview:leftCornerTriangle];
        [leftCornerTriangle setFillColor:[UIColor greatistHealthColorSecondary]];
        
        UIImage *healthIconImage = [UIImage imageNamed:@"Health_White"];
        UIImage *scaledHealthIconImage = [UIImage imageWithImage:healthIconImage scaledToSize:CGSizeMake(25, 25)];
        UIImageView *healthIconView = [[UIImageView alloc] initWithImage:scaledHealthIconImage];
        [cell.contentView addSubview:healthIconView];
        [healthIconView setFrame:CGRectMake(8, 12, 25, 25)];
    }
    else if ([post.section.name isEqualToString:(@"happiness")])
    {
        cell.backgroundColor = [UIColor greatistHappinessColor];
        cell.buttonBar.backgroundColor=[UIColor whiteColor];
        [cell.contentView addSubview:leftCornerTriangle];
        [leftCornerTriangle setFillColor:[UIColor greatistHappinessColorSecondary]];
        
        UIImage *happinessIconImage = [UIImage imageNamed:@"Grow_White"];
        UIImage *scaledHappinessIconImage = [UIImage imageWithImage:happinessIconImage scaledToSize:CGSizeMake(18, 25)];
        UIImageView *happinessIconView = [[UIImageView alloc] initWithImage:scaledHappinessIconImage];
        [cell.contentView addSubview:happinessIconView];
        [happinessIconView setFrame:CGRectMake(8, 15, 18, 25)];
    }
    [leftCornerTriangle setNeedsDisplay];
    
    
    return cell;
}

- (IBAction)backButtonTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:TRUE];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"logToDetail"])
    {
        GRTPostDetailViewController *nextVC = segue.destinationViewController;
        GRTPostTableViewCell *cell = (GRTPostTableViewCell *)[self.tableView cellForRowAtIndexPath:[self.tableView indexPathForSelectedRow]];
        
        nextVC.post = cell.post;
        [self.dataStore setSelectedResponsesFromJSONString:cell.post.responses];
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }
}

#pragma mark - FetchedResultsController Methods


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    if ([controller isEqual:self.dataStore.userPostFRController])
    {
        newIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row inSection:0];
        
    }
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCellForMainTableViewWithIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}


@end

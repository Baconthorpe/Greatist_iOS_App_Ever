//
//  GRTMainViewController.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTMainViewController.h"
#import "GRTFacebookLoginViewController.h"
#import "GRTPostDetailViewController.h"
#import "GRTComposePostViewController.h"
#import "GRTPostTableViewCell.h"
#import "GRTDataStore.h"
#import "Post+Methods.h"
#import "Section+Methods.h"
#import "GRTFacebookAPIClient.h"
#import "GRTCornerTriangles.h"
#import "GRTDataManager.h"
#import <FacebookSDK/FacebookSDK.h>

@interface GRTMainViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *composePostButton;
- (IBAction)composePostButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *postsTableView;
@property (weak, nonatomic) IBOutlet UIToolbar *logoutBarButtonItem;
@property (strong, nonatomic) Section *section;
@property (strong, nonatomic) GRTDataStore *dataStore;
@property (strong, nonatomic) GRTDataManager *dataManager;

@end

@implementation GRTMainViewController


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
    [self setupNavBar];
    [self setupFooterToolbar];
    [self setupRefreshControl];
    [self.dataManager getPostsBasedOnFacebookFriends];

//    [[GRTFacebookAPIClient sharedClient] verifyUserFacebookCachedInViewController:self];
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Methods


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
    return [self.dataStore.postFRController.sections[0] numberOfObjects];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"mainToDetail" sender:self];
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

#pragma mark - FetchedResultsController Methods


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.postsTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.postsTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.postsTableView;

    if ([controller isEqual:self.dataStore.postFRController])
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
    [self.postsTableView endUpdates];
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.postsTableView beginUpdates];
}

#pragma mark - Button Methods

- (IBAction)composePostButtonTapped:(id)sender
{

}

- (IBAction)logoutButtonTapped:(UIBarButtonItem *)sender
{
    [FBSession.activeSession closeAndClearTokenInformation];
    
    UIViewController *startVC = [self.navigationController presentingViewController];
    [startVC dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Cell Methods

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(GRTPostTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (UIView *view in cell.contentView.subviews) {
        if (![view isEqual:cell.postLabel] && ![view isEqual:cell.buttonBar]) {
            [view removeFromSuperview];
        }
    }
}


- (GRTPostTableViewCell *) configureCellForMainTableViewWithIndexPath: (NSIndexPath *)indexPath
{
    GRTPostTableViewCell *cell = [self.postsTableView dequeueReusableCellWithIdentifier:@"postCell"];
    Post *post = [self.dataStore.postFRController objectAtIndexPath:indexPath];
    [cell configureWithPost:post];
    
    GRTCornerTriangles *leftCornerTriangle = [[GRTCornerTriangles alloc] initWithFrame:cell.bounds IsLeftTriangle:YES withFillColor:[UIColor greatistFitnessColor]];
    GRTCornerTriangles *rightCornerTriangle = [[GRTCornerTriangles alloc] initWithFrame:cell.bounds IsLeftTriangle:NO withFillColor:[UIColor greatistFitnessColor]];
    
    cell.backgroundColor = [UIColor greatistColorForCategory:post.section.name];
    cell.buttonBar.backgroundColor=[UIColor whiteColor];
    
    UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
    separatorLineView.backgroundColor = [UIColor greatistLightGrayColor];
    [cell.contentView addSubview:separatorLineView];
    
    UIImage *iconImage;
    UIImage *scaledIconImage;
    CGRect iconRect;
    
    if (indexPath.row % 2 == 0) {
        [cell.contentView addSubview:leftCornerTriangle];
        [leftCornerTriangle setFillColor:[UIColor greatistSecondaryColorForCategory:post.section.name]];
    } else {
        [cell.contentView addSubview:rightCornerTriangle];
        [rightCornerTriangle setFillColor:[UIColor greatistSecondaryColorForCategory:post.section.name]];
    }
    
    if ([post.section.name isEqualToString:(@"fitness")]) {
        iconImage = [UIImage imageNamed:@"Move_White"];
        scaledIconImage = [UIImage imageWithImage:iconImage scaledToSize:CGSizeMake(25, 20)];
        iconRect = (indexPath.row % 2 == 0) ?  CGRectMake(10,15,25,20) : CGRectMake(290,15,25,20);
    } else if ([post.section.name isEqualToString:(@"health")]) {
        iconImage = [UIImage imageNamed:@"Health_White"];
        scaledIconImage = [UIImage imageWithImage:iconImage scaledToSize:CGSizeMake(25, 25)];
        iconRect = (indexPath.row % 2 == 0) ?  CGRectMake(8,12,25,25) : CGRectMake(287,12,25,25);
    } else if ([post.section.name isEqualToString:(@"happiness")]) {
        iconImage = [UIImage imageNamed:@"Grow_White"];
        scaledIconImage = [UIImage imageWithImage:iconImage scaledToSize:CGSizeMake(18, 25)];
        iconRect = (indexPath.row % 2 == 0) ?  CGRectMake(8,15,18,25) : CGRectMake(290,10,18,25);
    }
    UIImageView *iconView = [[UIImageView alloc] initWithImage:scaledIconImage];
    
    [iconView setFrame:iconRect];
    [cell.contentView addSubview:iconView];
    
    [leftCornerTriangle setNeedsDisplay];
    [rightCornerTriangle setNeedsDisplay];
    
    return cell;
}



#pragma mark - Segue Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"mainToDetail"])
    {
        GRTPostDetailViewController *nextVC = segue.destinationViewController;
        GRTPostTableViewCell *cell = (GRTPostTableViewCell *)[self.postsTableView cellForRowAtIndexPath:[self.postsTableView indexPathForSelectedRow]];
        
        nextVC.post = cell.post;
        [self.dataStore setSelectedResponsesFromJSONString:cell.post.responses];
        [self.postsTableView deselectRowAtIndexPath:[self.postsTableView indexPathForSelectedRow] animated:YES];

    }

}

#pragma mark - Helper Methods
- (void)initialize
{
   [self.postsTableView registerNib:[UINib nibWithNibName:@"GRTTableViewCell" bundle:nil] forCellReuseIdentifier:@"postCell"];
    self.dataStore = [GRTDataStore sharedDataStore];
    self.dataManager = [GRTDataManager sharedManager];
    self.postsTableView.delegate = self;
    self.postsTableView.dataSource = self;
    self.dataStore.postFRController.delegate = self;
}


- (void)setupNavBar
{

    [self.navigationController.navigationBar setBarTintColor:[UIColor greatistLightGrayColor]];
    UIImage *greatistLogoImage = [UIImage imageNamed:@"Greatist_Logo86x50"];
    UIImage *scaledGreatistLogoImage = [UIImage imageWithImage:greatistLogoImage scaledToSize:CGSizeMake(65, 38)];
    UIImageView *greatistLogoView = [[UIImageView alloc] initWithImage:scaledGreatistLogoImage];
    [self.navigationController.navigationBar.topItem setTitleView:greatistLogoView];
}

- (void)setupFooterToolbar
{
    [[UIToolbar appearance] setBackgroundColor:[UIColor greatistLightGrayColor]];
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *resizedPostImage = [UIImage imageWithImage:[UIImage imageNamed:@"Greatist_Logo_Badge_Blue"] scaledToSize:CGSizeMake(40, 40)];
    [postButton setBackgroundImage:resizedPostImage forState:UIControlStateNormal];
    [postButton setFrame:CGRectMake(145, 250, 40, 40)];
    [self.composePostButton setImage:resizedPostImage];
}

- (void)setupRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.postsTableView addSubview:refreshControl];
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    [self.dataManager getPostsBasedOnFacebookFriends];
    [refreshControl endRefreshing];
}

    
@end

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
    
    self.dataManager = [GRTDataManager sharedManager];
    
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (GRTPostTableViewCell *)[self configureCellForMainTableViewWithIndexPath:indexPath];
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


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
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
    [startVC dismissViewControllerAnimated:YES completion:^{
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        GRTFacebookLoginViewController *facebookLoginVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"facebookLoginVC"];
        [startVC presentViewController:facebookLoginVC animated:NO completion:nil];
    }];
}

#pragma mark - Cell Methods


- (GRTPostTableViewCell *) configureCellForMainTableViewWithIndexPath: (NSIndexPath *)indexPath
{
    GRTPostTableViewCell *cell = [self.postsTableView dequeueReusableCellWithIdentifier:@"postCell"];
    Post *post = [self.dataStore.postFRController objectAtIndexPath:indexPath];
    [cell configureWithPost:post];
    
    if ([post.section.name isEqualToString:(@"happiness")])
    {
        cell.backgroundColor = [UIColor greatistHappinessColorSecondary];
        cell.squareLabelLeft.backgroundColor = [UIColor greatistHappinessColor];
        cell.buttonBar.backgroundColor=[UIColor whiteColor];
    }
//    else if ([post.section.name isEqualToString:(@"Play")])
//    {
//        cell.backgroundColor = [UIColor greatistFitnessColorSecondary];
//        cell.buttonBar.backgroundColor=[UIColor whiteColor];
   // }
    else if ([post.section.name isEqualToString:(@"fitness")])
    {
        cell.backgroundColor = [UIColor greatistFitnessColorSecondary];
        cell.squareLabelLeft.backgroundColor = [UIColor greatistFitnessColor];
        cell.buttonBar.backgroundColor=[UIColor whiteColor];
    }
    else if ([post.section.name isEqualToString:(@"health")])
    {
        cell.backgroundColor = [UIColor greatistHealthColorSecondary];
        cell.squareLabelRight.backgroundColor = [UIColor greatistHealthColor];
        cell.buttonBar.backgroundColor=[UIColor whiteColor];
    }

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
        
        [self.postsTableView deselectRowAtIndexPath:[self.postsTableView indexPathForSelectedRow] animated:YES];

    }

}

#pragma mark - Helper Methods
- (void)initialize
{
    [self.postsTableView registerNib:[UINib nibWithNibName:@"GRTTableViewCell" bundle:nil] forCellReuseIdentifier:@"postCell"];
    self.dataStore = [GRTDataStore sharedDataStore];
    self.postsTableView.delegate = self;
    self.postsTableView.dataSource = self;
    self.dataStore.postFRController.delegate = self;
}


- (void)setupNavBar
{
    UIImage *navBar = [UIImage imageNamed:@"navBar.png"];
    //    UIImage *scaledNavBar = [UIImage imageWithImage:navBar scaledToSize:CGSizeMake(320, 54)];
    [self.navigationController.navigationBar setBackgroundImage:navBar forBarMetrics:UIBarMetricsDefault];
    
    UIImage *greatistLogoImage = [UIImage imageNamed:@"Greatist_Logo86x50"];
    UIImage *scaledGreatistLogoImage = [UIImage imageWithImage:greatistLogoImage scaledToSize:CGSizeMake(65, 38)];
    UIImageView *greatistLogoView = [[UIImageView alloc] initWithImage:scaledGreatistLogoImage];
    [self.navigationController.navigationBar.topItem setTitleView:greatistLogoView];
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:-4.0 forBarMetrics:UIBarMetricsDefault];
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

    
@end

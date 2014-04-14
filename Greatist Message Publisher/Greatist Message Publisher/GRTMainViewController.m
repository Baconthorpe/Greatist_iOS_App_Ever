//
//  GRTMainViewController.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTMainViewController.h"
#import "GRTDataStore.h"
#import "Post+Methods.h"
#import "GRTPostTableViewCell.h"
#import "GRTPostDetailViewController.h"
#import "GRTComposePostViewController.h"
#import "Section+Methods.h"
#import "Section.h"
#import "Article+Methods.h"
#import "GRTArticleViewCell.h"
#import "GRTArticlesViewController.h"

@interface GRTMainViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *composePostButton;
- (IBAction)composePostButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *postsTableView;
@property (weak, nonatomic) IBOutlet UITableView *articleTableView;
@property (strong, nonatomic) Section *section;
@property (strong,nonatomic) Article *article;

@property (strong, nonatomic) GRTDataStore *dataStore;

@end

@implementation GRTMainViewController

const NSInteger POSTSPERARTICLE = 2;

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
    [self.postsTableView registerNib:[UINib nibWithNibName:@"GRTTableViewCell" bundle:nil] forCellReuseIdentifier:@"postCell"];
    [self.postsTableView registerNib:[UINib nibWithNibName:@"GRTArticleCell" bundle:nil] forCellReuseIdentifier:@"articleCell"];
    
    self.dataStore = [GRTDataStore sharedDataStore];
    
    self.postsTableView.delegate = self;
    self.postsTableView.dataSource = self;
    self.dataStore.postFRController.delegate = self;
    self.dataStore.articleFRController.delegate = self;

    UIImage *navBar = [UIImage imageNamed:@"navBar.png"];
//    UIImage *scaledNavBar = [UIImage imageWithImage:navBar scaledToSize:CGSizeMake(320, 54)];
    [self.navigationController.navigationBar setBackgroundImage:navBar forBarMetrics:UIBarMetricsDefault];
    
    UIImage *greatistLogoImage = [UIImage imageNamed:@"Greatist_Logo86x50"];
    UIImage *scaledGreatistLogoImage = [UIImage imageWithImage:greatistLogoImage scaledToSize:CGSizeMake(65, 38)];
    UIImageView *greatistLogoView = [[UIImageView alloc] initWithImage:scaledGreatistLogoImage];
    [self.navigationController.navigationBar.topItem setTitleView:greatistLogoView];
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:-4.0 forBarMetrics:UIBarMetricsDefault];
    
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *resizedPostImage = [UIImage imageWithImage:[UIImage imageNamed:@"Greatist_Logo_Badge_Blue"] scaledToSize:CGSizeMake(40, 40)];
    [postButton setBackgroundImage:resizedPostImage forState:UIControlStateNormal];
    [postButton setFrame:CGRectMake(145, 250, 40, 40)];
    
    [self.composePostButton setImage:resizedPostImage];
    
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
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row % POSTSPERARTICLE != 0)
//    {
//        [self configurePostCellAccomodatingArticleSlotsWithIndexPath:indexPath];
//    } else
//    {
//        [self configureArticleCellAccomodatingPostSlotsWithIndexPath:indexPath];
//    }
//    
//    GRTPostTableViewCell *cell = [self configureCellForMainTableViewWithIndexPath:indexPath];
//    Post *post = [self.dataStore.postFRController objectAtIndexPath:indexPath];
//    [cell configureWithPost:post];
//    UIFont *archerProMedium = [UIFont fontWithName:@"ArcherPro-Medium" size:50];
//    cell.textLabel.font = archerProMedium;
//    return cell;
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell  = (GRTPostTableViewCell *)[self configureCellForMainTableViewWithIndexPath:indexPath];
    
    }
    else
    {
       cell = (GRTArticleViewCell *)[tableView dequeueReusableCellWithIdentifier:@"articleCell"];
        if ([cell isKindOfClass:[GRTArticleViewCell class]])
        {
        ((GRTArticleViewCell *) cell).postLabel.text = @"testing article";
        }
            
        
    }
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.dataStore.postFRController.sections[0] numberOfObjects];
    }
    
    else
    {
    return [self.dataStore.articleFRController.sections[0] numberOfObjects];
    }
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"mainToDetail" sender:self];
    
    }
    
    else if (indexPath.section == 1)
    {
        [self performSegueWithIdentifier:@"mainToArticle" sender:self];
    }
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

#pragma mark - Cell Methods


- (GRTPostTableViewCell *) configureCellForMainTableViewWithIndexPath: (NSIndexPath *)indexPath
{
    GRTPostTableViewCell *cell = [self.postsTableView dequeueReusableCellWithIdentifier:@"postCell"];
    Post *post = [self.dataStore.postFRController objectAtIndexPath:indexPath];
    [cell configureWithPost:post];
    
    if ([post.section.name isEqualToString:(@"Grow")])
    {
        cell.backgroundColor = [UIColor greatistGrowColorLight];
    }
    else if ([post.section.name isEqualToString:(@"Play")])
    {
        cell.backgroundColor = [UIColor greatistPlayColorLight];
    }
    else if ([post.section.name isEqualToString:(@"Move")])
    {
        cell.backgroundColor = [UIColor greatistMoveColorLight];
    }
    else if ([post.section.name isEqualToString:(@"Eat")])
    {
        cell.backgroundColor = [UIColor greatistEatColorLight];
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
    
    else if ([segue.identifier isEqualToString:@"mainToCompose"])
    {
        GRTComposePostViewController *nextVC = segue.destinationViewController;
        
        NSFetchRequest *getVerticals = [NSFetchRequest fetchRequestWithEntityName:@"Section"];
        NSSortDescriptor *sortingVerticals = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        getVerticals.sortDescriptors = @[sortingVerticals];
        
        nextVC.verticals = [self.dataStore.managedObjectContext executeFetchRequest:getVerticals error:nil];
    }
    else if ([segue.identifier isEqualToString:@"mainToArticle"])
    {
        GRTArticlesViewController *nextVC = segue.destinationViewController;
        GRTArticleViewCell *cell = (GRTArticleViewCell *)[self.articleTableView cellForRowAtIndexPath:[self.articleTableView indexPathForSelectedRow]];
        
        nextVC.article = cell.article;
        
        [self.articleTableView deselectRowAtIndexPath:[self.postsTableView indexPathForSelectedRow] animated:YES];
    }
    
}

#pragma mark - Configure Cell Methods

- (GRTPostTableViewCell *) configurePostCellAccomodatingArticleSlotsWithIndexPath: (NSIndexPath *)indexPath
{
    NSIndexPath *accomodatingIndexPath = [NSIndexPath indexPathForRow:(indexPath.row - (indexPath.row / POSTSPERARTICLE)) inSection:indexPath.section];
    
    GRTPostTableViewCell *cell = [self.postsTableView dequeueReusableCellWithIdentifier:@"postCell"];
    Post *post = [self.dataStore.postFRController objectAtIndexPath:accomodatingIndexPath];
    [cell configureWithPost:post];
    
    UIFont *archerProMedium = [UIFont fontWithName:@"ArcherPro-Medium" size:50];
    cell.textLabel.font = archerProMedium;
    
    if ([post.section.name isEqualToString:(@"Grow")])
    {
        cell.backgroundColor = [UIColor greatistGrowColorLight];
    }
    else if ([post.section.name isEqualToString:(@"Play")])
    {
        cell.backgroundColor = [UIColor greatistPlayColorLight];
    }
    else if ([post.section.name isEqualToString:(@"Move")])
    {
        cell.backgroundColor = [UIColor greatistMoveColorLight];
    }
    else if ([post.section.name isEqualToString:(@"Eat")])
    {
        cell.backgroundColor = [UIColor greatistEatColorLight];
    }
    
    return cell;
}

- (GRTArticleViewCell *) configureArticleCellAccomodatingPostSlotsWithIndexPath: (NSIndexPath *)indexPath
{
    NSLog(@"row = %ld section = %ld", (long)indexPath.row,(long)indexPath.section);
    
    NSIndexPath *accomodatingIndexPath = [NSIndexPath indexPathForRow:(indexPath.row / POSTSPERARTICLE) inSection:indexPath.section];
    
    GRTArticleViewCell *cell = (GRTArticleViewCell *)[self.postsTableView dequeueReusableCellWithIdentifier:@"articleCell"];
    cell.article = [self.dataStore.articleFRController objectAtIndexPath:accomodatingIndexPath];
    
    return cell;
}



    
@end

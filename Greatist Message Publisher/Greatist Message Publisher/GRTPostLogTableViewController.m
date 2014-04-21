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

@property (weak, nonatomic) IBOutlet UITableView *postsTableView;

@property (strong, nonatomic) Section *section;
@property (strong, nonatomic) GRTCornerTriangles *cornerTriangle;
@property (strong, nonatomic) GRTDataStore *dataStore;
@property (strong, nonatomic) GRTDataManager *dataManager;

- (IBAction)backButtonTapped:(id)sender;


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
//    [self setupNavBar];
    
    self.dataManager = [GRTDataManager sharedManager];
    [self.dataManager getPostsBasedOnFacebookID];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialize
{
    [self.postsTableView registerNib:[UINib nibWithNibName:@"GRTTableViewCell" bundle:nil] forCellReuseIdentifier:@"postCell"];
    self.dataStore = [GRTDataStore sharedDataStore];
    self.postsTableView.delegate = self;
    self.postsTableView.dataSource = self;
    self.dataStore.postFRController.delegate = self;
}

//- (void)setupNavBar
//{
//    [self.navigationController.navigationBar setBarTintColor:[UIColor greatistLightGrayColor]];
//    
//    UIImage *greatistLogoImage = [UIImage imageNamed:@"Greatist_Logo86x50"];
//    UIImage *scaledGreatistLogoImage = [UIImage imageWithImage:greatistLogoImage scaledToSize:CGSizeMake(65, 38)];
//    UIImageView *greatistLogoView = [[UIImageView alloc] initWithImage:scaledGreatistLogoImage];
//    [self.navigationController.navigationBar.topItem setTitleView:greatistLogoView];
//    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:-4.0 forBarMetrics:UIBarMetricsDefault];
//}

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

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.postsTableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.postsTableView endUpdates];
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
    else if (([post.section.name isEqualToString:(@"fitness")]) && (!indexPath.row % 2 == 0))
    {
        cell.backgroundColor = [UIColor greatistFitnessColor];
        cell.buttonBar.backgroundColor=[UIColor whiteColor];
        [cell.contentView addSubview:rightCornerTriangle];
        [rightCornerTriangle setFillColor:[UIColor greatistFitnessColorSecondary]];
        
        UIImage *fitnessIconImage = [UIImage imageNamed:@"Move_White"];
        UIImage *scaledFitnessIconImage = [UIImage imageWithImage:fitnessIconImage scaledToSize:CGSizeMake(25, 20)];
        UIImageView *fitnessIconView = [[UIImageView alloc] initWithImage:scaledFitnessIconImage];
        [cell.contentView addSubview:fitnessIconView];
        [fitnessIconView setFrame:CGRectMake(290, 15, 25, 20)];
    }
    else if (([post.section.name isEqualToString:(@"health")]) && (indexPath.row % 2 == 0))
    {
        cell.backgroundColor = [UIColor greatistHappinessColor];
        cell.buttonBar.backgroundColor=[UIColor whiteColor];
        [cell.contentView addSubview:leftCornerTriangle];
        [leftCornerTriangle setFillColor:[UIColor greatistHappinessColorSecondary]];
        
        UIImage *healthIconImage = [UIImage imageNamed:@"Health_White"];
        UIImage *scaledHealthIconImage = [UIImage imageWithImage:healthIconImage scaledToSize:CGSizeMake(25, 25)];
        UIImageView *healthIconView = [[UIImageView alloc] initWithImage:scaledHealthIconImage];
        [cell.contentView addSubview:healthIconView];
        [healthIconView setFrame:CGRectMake(8, 12, 25, 25)];
    }
    else if (([post.section.name isEqualToString:(@"health")]) && (!indexPath.row % 2 == 0))
    {
        cell.backgroundColor = [UIColor greatistHealthColor];
        cell.buttonBar.backgroundColor=[UIColor whiteColor];
        [cell.contentView addSubview:rightCornerTriangle];
        [rightCornerTriangle setFillColor:[UIColor greatistHealthColorSecondary]];
        
        UIImage *healthIconImage = [UIImage imageNamed:@"Health_White"];
        UIImage *scaledHealthIconImage = [UIImage imageWithImage:healthIconImage scaledToSize:CGSizeMake(25, 25)];
        UIImageView *healthIconView = [[UIImageView alloc] initWithImage:scaledHealthIconImage];
        [cell.contentView addSubview:healthIconView];
        [healthIconView setFrame:CGRectMake(287, 12, 25, 25)];
    }
    else if (([post.section.name isEqualToString:(@"happiness")]) && (indexPath.row % 2 == 0))
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
    else if (([post.section.name isEqualToString:(@"happiness")]) && (!indexPath.row % 2 == 0))
    {
        cell.backgroundColor = [UIColor greatistHappinessColor];
        cell.buttonBar.backgroundColor=[UIColor whiteColor];
        [cell.contentView addSubview:rightCornerTriangle];
        [rightCornerTriangle setFillColor:[UIColor greatistHappinessColorSecondary]];
        
        UIImage *happinessIconImage = [UIImage imageNamed:@"Grow_White"];
        UIImage *scaledHappinessIconImage = [UIImage imageWithImage:happinessIconImage scaledToSize:CGSizeMake(18, 25)];
        UIImageView *happinessIconView = [[UIImageView alloc] initWithImage:scaledHappinessIconImage];
        [cell.contentView addSubview:happinessIconView];
        [happinessIconView setFrame:CGRectMake(290, 10, 18, 25)];
    }
    [leftCornerTriangle setNeedsDisplay];
    [rightCornerTriangle setNeedsDisplay];
    
    return cell;
}

- (IBAction)backButtonTapped:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"logToDetail"])
    {
        GRTPostDetailViewController *nextVC = segue.destinationViewController;
        GRTPostTableViewCell *cell = (GRTPostTableViewCell *)[self.postsTableView cellForRowAtIndexPath:[self.postsTableView indexPathForSelectedRow]];
        
        nextVC.post = cell.post;
        [self.dataStore setSelectedResponsesFromJSONString:cell.post.responses];
        [self.postsTableView deselectRowAtIndexPath:[self.postsTableView indexPathForSelectedRow] animated:YES];
        
    }
    
}


@end

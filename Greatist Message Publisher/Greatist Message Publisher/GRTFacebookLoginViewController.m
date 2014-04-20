//
//  GRTFacebookLoginViewController.m
//  Greatist Message Publisher
//
//  Created by Leonard Li on 4/15/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTFacebookLoginViewController.h"
#import "GRTMainTableViewController.h"
#import "GRTDataManager.h"
#import <FacebookSDK/FacebookSDK.h>

@interface GRTFacebookLoginViewController () <FBLoginViewDelegate>

@property (strong, nonatomic) UILabel *appName;
@property (strong, nonatomic) FBProfilePictureView *profilePictureView;
@property (strong, nonatomic) UILabel *nameLabel;

@property (strong, nonatomic) NSString *facebookName;
@property (strong, nonatomic) NSString *facebookID;

@end

@implementation GRTFacebookLoginViewController

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
    [self initialize];

    
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
    NSString *alertMessage, *alertTitle;
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures since that happen outside of the app.
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    self.profilePictureView.profileID = user.id;
    self.nameLabel.text = [NSString stringWithFormat:@"Hi, %@",user.name];
    self.facebookID = user.id;
    self.facebookName = user.name;
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    //self.statusLabel.text = @"You're logged in as";
    //example of getting friend IDs from facebook
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[GRTFacebookAPIClient sharedClient] getFriendIDsWithCompletion:^(NSArray *friendIDs)
     {
         [self getPostsForFriends:friendIDs];
         [self createUserIfNew];
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         [self performSegueWithIdentifier:@"loginToMain" sender:nil];
     }];
    
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @" ";
}

#pragma mark - Helper Methods

- (void) initialize
{
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"basic_info", @"email", @"user_likes"]];
    loginView.delegate = self;
    [self.view addSubview:loginView];
    
    self.appName = [[UILabel alloc] init];
    self.appName.text = @"BodyTalk";
    self.appName.textAlignment = NSTextAlignmentCenter;
    self.appName.font = [UIFont fontWithName:@"ArcherPro-Medium" size:36];
    [self.view addSubview:self.appName];
    
    self.profilePictureView = [[FBProfilePictureView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [[self.profilePictureView layer] setCornerRadius:15];
    [self.view addSubview:self.profilePictureView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.text = @" ";
    self.appName.font = [UIFont fontWithName:@"Avenir-Roman" size:36];
    [self.view addSubview:self.nameLabel];
    
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.profilePictureView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.appName setTranslatesAutoresizingMaskIntoConstraints:NO];
    [loginView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view removeConstraints:self.view.constraints];
    NSDictionary *views = @{@"superview": self.view,
                            @"appName" : self.appName,
                            @"profilePicture": self.profilePictureView,
                            @"nameLabel": self.nameLabel,
                            @"loginView": loginView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10)-[appName]-(10)-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[appName]-(10)-[profilePicture]-(10)-[nameLabel]-(10)-[loginView]-(10)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
     
}

- (void)getPostsForFriends:(NSArray *)friendIDs
{
    [[GRTDataManager sharedManager] getPostsBasedOnFacebookFriends];
}

- (void)createUserIfNew
{
    [[GRTDataManager sharedManager] fetchUsersWithCompletion:^(NSArray *users) {
        BOOL userFound = NO;
        for (User *user in users) {
            if ([user.facebookID isEqualToString:self.facebookID]) {
                [[GRTDataManager sharedManager] setCurrentUser:user];
                userFound = YES;
            }
        }
        if (!userFound) {
            [[GRTDataManager sharedManager] createNewUserWithFacebookID:self.facebookID];
        }
    }];
}
@end

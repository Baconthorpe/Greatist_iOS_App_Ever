//
//  GRTAppDelegate.m
//  Greatist Message Publisher
//
//  Created by Ezekiel Abuhoff on 4/1/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTAppDelegate.h"
#import "GRTFacebookLoginViewController.h"
#import "GRTMainTableViewController.h"
#import "GRTDataStore.h"
#import "GRTDataManager.h"
#import "GRTFacebookAPIClient.h"
#import <FacebookSDK/FacebookSDK.h>

@interface GRTAppDelegate ()
@property (strong, nonatomic) GRTDataStore *dataStore;

@end

@implementation GRTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FBProfilePictureView class];
    self.dataStore = [GRTDataStore sharedDataStore];
    [self.dataStore starterData];
    [[GRTDataManager sharedManager] getValidResponses];
    
    [self beginFacebookLogin];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self.dataStore saveContext];

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self.dataStore saveContext];
    
    // Saves changes in the application's managed object context before the application terminates.
}

#pragma mark - Facebook Login Helper Methods

- (void)beginFacebookLogin
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GRTFacebookLoginViewController *facebookLoginVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"facebookLoginVC"];
    self.window.rootViewController = facebookLoginVC;
    [self.window makeKeyAndVisible];
    
    if ([[GRTFacebookAPIClient sharedClient] isUserFacebookCached]) {
        GRTMainTableViewController *mainVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"mainNavBarController"];
        [facebookLoginVC presentViewController:mainVC animated:NO completion:nil];
    }
}

// Needed for Facebook Login in AppDelegate.  Do not move.
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    // You can add your app-specific url handling code here if needed
    return wasHandled;
}


@end

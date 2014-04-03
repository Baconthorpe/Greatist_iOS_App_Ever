//
//  GRTMainViewController.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTMainViewController.h"
#import "GRTDataStore.h"

@interface GRTMainViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *composePostButton;
- (IBAction)composePostButtonTapped:(id)sender;

@property (strong, nonatomic) GRTDataStore *dataStore;

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
    
    self.dataStore = [GRTDataStore sharedDataStore];
    
    FAKFontAwesome *composePostIcon = [FAKFontAwesome pencilSquareOIconWithSize:25];
    [composePostIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    UIImage *composePostImage = [composePostIcon imageWithSize:CGSizeMake(30, 30)];
    composePostIcon.iconFontSize = 25;
   
    [self.composePostButton setImage:composePostImage];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (IBAction)composePostButtonTapped:(id)sender {

}
@end

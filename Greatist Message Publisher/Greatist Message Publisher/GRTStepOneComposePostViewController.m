//
//  GRTStepOneComposePostViewController.m
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTStepOneComposePostViewController.h"
#import "GRTStepOneComposePost.h"

@interface GRTStepOneComposePostViewController ()
@property (strong, nonatomic) IBOutlet UIView *GRTStepOneComposePostVC;
@property (strong, nonatomic) IBOutlet UIView *GRTStepOneView;


@end

@implementation GRTStepOneComposePostViewController 

- (void)awakeFromNib {
    NSString* nibName = @"GRTStepOneComposePost";
    if ([[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil]) {
        [self.GRTStepOneView setFrame:[self.view bounds]];
        [self.view addSubview:self.GRTStepOneView];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"GRTStepOneComposePost" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    
    
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


@end

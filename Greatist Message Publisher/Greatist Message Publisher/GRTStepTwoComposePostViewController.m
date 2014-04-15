//
//  GRTStepTwoComposePostViewController.m
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTStepTwoComposePostViewController.h"

@interface GRTStepTwoComposePostViewController ()
@property (strong, nonatomic) IBOutlet UIView *GRTStepTwoView;

@end

@implementation GRTStepTwoComposePostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)awakeFromNib {
    NSString* nibName = @"GRTStepTwoComposePost";
    if ([[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil]) {
        [self.GRTStepTwoView setFrame:[self.view bounds]];
        [self.view addSubview:self.GRTStepTwoView];
    }
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

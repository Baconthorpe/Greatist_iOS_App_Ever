//
//  GRTPostDetailViewController.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTPostDetailViewController.h"
#import "GRTDataStore.h"
#import "Response+Methods.h"

@interface GRTPostDetailViewController ()

@property (strong, nonatomic) GRTDataStore *dataStore;
@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIView *postDetailView;

@property (strong, nonatomic) NSDictionary *responsesDictionary;

@end

@implementation GRTPostDetailViewController

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
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 66, 320, 320)];
    self.mainScrollView.backgroundColor = [UIColor redColor];

    [self createPostDetail];
    [self createResponses];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createPostDetail
{
    UIView *postDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:postDetailView];
    
    UILabel *postDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
    NSString *postDetailText = [NSString stringWithFormat:@"“ %@ ”", self.post.content];
    [postDetailLabel setText:postDetailText];
    [postDetailLabel setNumberOfLines:0];
    [postDetailLabel setFont:[UIFont fontWithName:@"ArcherPro-SemiboldItalic" size:24]];
    [postDetailLabel setTextColor:[UIColor greatistColorForCategory:self.post.section.name]];
    [postDetailView addSubview:postDetailLabel];
    
    UIButton *flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flagButton setFrame:CGRectMake(170, 280, 140, 20)];
    [flagButton setTitleColor:[UIColor greatistColorForCategory:self.post.section.name] forState:UIControlStateNormal];
    [flagButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:10]];
    flagButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    flagButton.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    [flagButton setTitle:@"FLAG INAPPROPRIATE" forState:UIControlStateNormal];
    FAKFontAwesome *flagIcon = [FAKFontAwesome flagIconWithSize:15];
    [flagIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistColorForCategory:self.post.section.name]];
    UIImage *flagImage = [[flagIcon imageWithSize:CGSizeMake(20, 20)] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    flagIcon.iconFontSize = 15;
    [flagButton setBackgroundImage:flagImage forState:UIControlStateNormal];
    [postDetailView addSubview:flagButton];
}

- (void)createResponses
{
    UIView *responseView = [[UIView alloc]initWithFrame:CGRectMake(0, 320, 320, 90)];
    [responseView setBackgroundColor:[UIColor greatistColorForCategory:self.post.section.name]];
    [self.view addSubview:responseView];
    
    NSArray *labelXCoordinates = @[@(30),@(180)];
    NSArray *labelYCoordinates = @[@(20),@(50)];
    
    NSMutableArray *responseLabelFramesArray = [NSMutableArray new];
    NSMutableArray *responseButtonFramesArray = [NSMutableArray new];
    
    for (NSNumber *xCoordinate in labelXCoordinates) {
        for (NSNumber *yCoordinate in labelYCoordinates) {
            NSInteger x = [xCoordinate integerValue];
            NSInteger y = [yCoordinate integerValue];
            CGRect responseLabelFrame = CGRectMake(x, y, 20, 20);
            [responseLabelFramesArray addObject:[NSValue valueWithCGRect:responseLabelFrame]];
            
            CGRect responseButtonFrame = CGRectMake(x+30, y, 100, 20);
            [responseButtonFramesArray addObject:[NSValue valueWithCGRect:responseButtonFrame]];

        }
    }
    
    NSArray *responseArray = [self.post.responses allObjects];
    for (NSInteger i = 0; i < [responseArray count]; i++) {
        
        Response *response = responseArray[i];
        UILabel *newResponseCountLabel = [[UILabel alloc] initWithFrame:[[responseLabelFramesArray objectAtIndex:i] CGRectValue]];
        [newResponseCountLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:12]];
        newResponseCountLabel.textColor = [UIColor whiteColor];
        newResponseCountLabel.text = [NSString stringWithFormat:@"0"];
        [newResponseCountLabel setTextAlignment:NSTextAlignmentCenter];
        [[newResponseCountLabel layer] setBorderColor:[[UIColor whiteColor] CGColor]];
        [[newResponseCountLabel layer] setBorderWidth:1];
        [[newResponseCountLabel layer] setCornerRadius:1];
        [newResponseCountLabel drawTextInRect:CGRectMake(5, 5, 10, 10)];
        [responseView addSubview:newResponseCountLabel];
        
        UIButton *newResponseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [newResponseButton setFrame:[[responseButtonFramesArray objectAtIndex:i] CGRectValue]];
        [newResponseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [newResponseButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:12]];
        newResponseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [newResponseButton setTitle:[response.responseOption.content uppercaseString] forState:UIControlStateNormal];
        [responseView addSubview:newResponseButton];

    }
    
}

- (IBAction)backBarButtonItemTapped:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

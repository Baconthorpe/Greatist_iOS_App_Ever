//
//  GRTPostDetailViewController.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTPostDetailViewController.h"
#import "GRTDataStore.h"
#import "GRTDataManager.h"

@interface GRTPostDetailViewController ()

@property (strong, nonatomic) GRTDataStore *dataStore;
@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIView *postDetailView;
@property (strong, nonatomic) UIView *responseView;

@property (strong, nonatomic) NSMutableArray *responseArray;
@property (strong, nonatomic) NSMutableArray *responseLabelsArray;
@property (strong, nonatomic) NSMutableArray *responseLabelFramesArray;
@property (strong, nonatomic) NSMutableArray *responseButtonFramesArray;
@property (strong, nonatomic) NSArray *responseOptionsArray;

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

    [self createPostDetail];
    [self setupResponses];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createPostDetail
{
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 66, 320, 320)];
    self.mainScrollView.backgroundColor = [UIColor purpleColor];
    
    UIView *postDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:postDetailView];
    
    UILabel *postDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
    NSString *postDetailText = [NSString stringWithFormat:@"“\u00a0%@\u00a0”", self.post.content];
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
    [flagButton addTarget:self action:@selector(flagButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [postDetailView addSubview:flagButton];
}

- (void)setupResponses
{
    self.responseLabelsArray = [NSMutableArray new];
    
    self.responseView = [[UIView alloc]initWithFrame:CGRectMake(0, 320, 320, 90)];
    [self.responseView setBackgroundColor:[UIColor greatistColorForCategory:self.post.section.name]];
    [self.view addSubview:self.responseView];
    
    NSArray *labelXCoordinates = @[@(30),@(170)];
    NSArray *labelYCoordinates = @[@(20),@(50)];
    
    self.responseLabelFramesArray = [NSMutableArray new];
    self.responseButtonFramesArray = [NSMutableArray new];
    
    for (NSNumber *xCoordinate in labelXCoordinates) {
        for (NSNumber *yCoordinate in labelYCoordinates) {
            NSInteger x = [xCoordinate integerValue];
            NSInteger y = [yCoordinate integerValue];
            CGRect responseLabelFrame = CGRectMake(x, y, 30, 20);
            [self.responseLabelFramesArray addObject:[NSValue valueWithCGRect:responseLabelFrame]];
            
            CGRect responseButtonFrame = CGRectMake(x+40, y, 100, 20);
            [self.responseButtonFramesArray addObject:[NSValue valueWithCGRect:responseButtonFrame]];
        }
    }
    
    self.responseOptionsArray = [[self.dataStore.selectedResponses allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [[GRTDataManager sharedManager] getUpdatedResponsesForPostID:self.post.objectId withCompletion:^(NSDictionary *postDictionary) {
        [self updateResponseButtons];
    }];
     
}

- (void)updateResponseButtons
{
    [[self.responseView subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    for (NSInteger i = 0; i < [self.responseOptionsArray count]; i++) {
        NSString *responseContent = self.responseOptionsArray[i];
        NSNumber *responseCount = [self.dataStore.selectedResponses valueForKey:responseContent];
        
        UILabel *newResponseCountLabel = [[UILabel alloc] initWithFrame:[[self.responseLabelFramesArray objectAtIndex:i] CGRectValue]];
        [newResponseCountLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:12]];
        newResponseCountLabel.textColor = [UIColor whiteColor];
        newResponseCountLabel.text = [NSString stringWithFormat:@"%@", responseCount ];
        [newResponseCountLabel setTextAlignment:NSTextAlignmentCenter];
        [[newResponseCountLabel layer] setBorderColor:[[UIColor whiteColor] CGColor]];
        [[newResponseCountLabel layer] setBorderWidth:1];
        [[newResponseCountLabel layer] setCornerRadius:1];
        [newResponseCountLabel drawTextInRect:CGRectMake(5, 5, 10, 10)];
        [self.responseLabelsArray addObject:newResponseCountLabel];
        [self.responseView addSubview:newResponseCountLabel];
        
        UIButton *newResponseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [newResponseButton setFrame:[[self.responseButtonFramesArray objectAtIndex:i] CGRectValue]];
        [newResponseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [newResponseButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:12]];
        newResponseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [newResponseButton setTitle:[responseContent uppercaseString] forState:UIControlStateNormal];
        [newResponseButton setTag:i];
        [newResponseButton addTarget:self action:@selector(responseButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.responseView addSubview:newResponseButton];
    }
    
}

- (IBAction)backBarButtonItemTapped:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)responseButtonTapped:(UIButton *)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger responseIndex = [button tag];
    [[GRTDataManager sharedManager] incrementResponse:self.responseOptionsArray[responseIndex]
                                            forPostID:self.post.objectId
                                       withCompletion:^(NSString *updatedAt) {
       [self updateResponseButtons];
    }];
}

- (void)flagButtonTapped:(UIButton *)sender
{
//    [[GRTDataManager sharedManager] flagPost:self.post.objectId];
}

@end

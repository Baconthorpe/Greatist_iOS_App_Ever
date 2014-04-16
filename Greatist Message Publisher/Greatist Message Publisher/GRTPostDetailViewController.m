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

@property (strong, nonatomic) NSArray *responseOptionsArray;
@property (strong, nonatomic) NSMutableArray *responseArray;
@property (strong, nonatomic) NSMutableArray *responseLabelsArray;

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
    self.mainScrollView.backgroundColor = [UIColor purpleColor];
    
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

- (void)setupResponses
{
    self.responseLabelsArray = [NSMutableArray new];
    [self updateCountsForResponses];
    
    UIView *responseView = [[UIView alloc]initWithFrame:CGRectMake(0, 320, 320, 90)];
    [responseView setBackgroundColor:[UIColor greatistColorForCategory:self.post.section.name]];
    [self.view addSubview:responseView];
    
    NSArray *labelXCoordinates = @[@(30),@(170)];
    NSArray *labelYCoordinates = @[@(20),@(50)];
    
    NSMutableArray *responseLabelFramesArray = [NSMutableArray new];
    NSMutableArray *responseButtonFramesArray = [NSMutableArray new];
    
    for (NSNumber *xCoordinate in labelXCoordinates) {
        for (NSNumber *yCoordinate in labelYCoordinates) {
            NSInteger x = [xCoordinate integerValue];
            NSInteger y = [yCoordinate integerValue];
            CGRect responseLabelFrame = CGRectMake(x, y, 30, 20);
            [responseLabelFramesArray addObject:[NSValue valueWithCGRect:responseLabelFrame]];
            
            CGRect responseButtonFrame = CGRectMake(x+40, y, 100, 20);
            [responseButtonFramesArray addObject:[NSValue valueWithCGRect:responseButtonFrame]];
            
        }
    }
    
    NSMutableSet *responseOptionSet = [NSMutableSet new];
    for (Response *response in [self.post.responses allObjects]) {
        [responseOptionSet addObject:response.responseOption];
    }
    NSArray *responseOptionsArray = [responseOptionSet allObjects];
    
    NSMutableArray *responseArray = [NSMutableArray new];
    for (Response *response in [self.post.responses allObjects]) {
        [responseArray addObject:response];
    }
    
    for (NSInteger i = 0; i < [responseOptionsArray count]; i++) {
        
        ResponseOption *responseOption = responseOptionsArray[i];
        
        NSPredicate *searchForResponse = [NSPredicate predicateWithFormat:@"responseOption == %@", responseOption];
        NSArray *filteredResponseArray = [responseArray filteredArrayUsingPredicate:searchForResponse];
        NSNumber *responseCount = @([filteredResponseArray count] -1);
        
        UILabel *newResponseCountLabel = [[UILabel alloc] initWithFrame:[[responseLabelFramesArray objectAtIndex:i] CGRectValue]];
        [newResponseCountLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:12]];
        newResponseCountLabel.textColor = [UIColor whiteColor];
        newResponseCountLabel.text = [NSString stringWithFormat:@"%@", responseCount ];
        [newResponseCountLabel setTextAlignment:NSTextAlignmentCenter];
        [[newResponseCountLabel layer] setBorderColor:[[UIColor whiteColor] CGColor]];
        [[newResponseCountLabel layer] setBorderWidth:1];
        [[newResponseCountLabel layer] setCornerRadius:1];
        [newResponseCountLabel drawTextInRect:CGRectMake(5, 5, 10, 10)];
        [self.responseLabelsArray addObject:newResponseCountLabel];
        [responseView addSubview:newResponseCountLabel];
        
        UIButton *newResponseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [newResponseButton setFrame:[[responseButtonFramesArray objectAtIndex:i] CGRectValue]];
        [newResponseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [newResponseButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:12]];
        newResponseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [newResponseButton setTitle:[responseOption.content uppercaseString] forState:UIControlStateNormal];
        [newResponseButton setTag:i];
        [newResponseButton addTarget:self action:@selector(responseButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [responseView addSubview:newResponseButton];
        
    }
    
}

- (IBAction)backBarButtonItemTapped:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateCountsForResponses
{
    NSMutableSet *responseOptionSet = [NSMutableSet new];
    for (Response *response in [self.post.responses allObjects]) {
        [responseOptionSet addObject:response.responseOption];
    }
    self.responseOptionsArray = [responseOptionSet allObjects];
    
    self.responseArray = [NSMutableArray new];
    for (Response *response in [self.post.responses allObjects]) {
        [self.responseArray addObject:response];
    }
}

- (NSNumber *)getCountForResponseOption:(ResponseOption *)responseOption
{
    NSPredicate *searchForResponse = [NSPredicate predicateWithFormat:@"responseOption == %@", responseOption];
    NSArray *filteredResponseArray = [self.responseArray filteredArrayUsingPredicate:searchForResponse];
    return @([filteredResponseArray count] -1);
}

- (void)responseButtonTapped:(UIButton *)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger responseIndex = [button tag];
    
    
    Response *newResponse = [Response responseWithResponseOption:self.responseOptionsArray[responseIndex]
                                                            post:self.post
                                                          author:self.dataStore.currentUser
                                                       inContext:self.dataStore.managedObjectContext];
    NSLog(@"%@", newResponse);
    [self.dataStore saveContext];
    
    [self.post addResponsesObject:newResponse];
    NSLog(@"%@", self.post);
    [self updateCountsForResponses];
    
    NSNumber *responseOptionCount = [self getCountForResponseOption:newResponse.responseOption];
    NSString *labelText = [NSString stringWithFormat:@"%@", responseOptionCount];
    [self.responseLabelsArray[responseIndex] setText:labelText];
    
}

@end

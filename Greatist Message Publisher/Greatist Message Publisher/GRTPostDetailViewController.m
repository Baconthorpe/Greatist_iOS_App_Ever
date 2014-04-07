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
    [self setUpResponsesDictionary];
    [self starterConfig];
    
    [self createPostDetail];
    [self createResponses];
    [self createResponsesVariantNoIcons];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createPostDetail
{
    UIView *postDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
    [self.view setBackgroundColor:[UIColor greatistLightGrayColor]];
    [self.view addSubview:postDetailView];
    
    UILabel *postDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
    NSString *postDetailText = [NSString stringWithFormat:@"“ %@ ”", self.post.content];
    [postDetailLabel setText:postDetailText];
    [postDetailLabel setNumberOfLines:0];
    [postDetailLabel setFont:[UIFont fontWithName:@"ArcherPro-SemiboldItalic" size:24]];
    [postDetailLabel setTextColor:[UIColor greatistEatColor]];
    [postDetailView addSubview:postDetailLabel];
    
    UIButton *flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [flagButton setFrame:CGRectMake(170, 280, 140, 20)];
    [flagButton setTitleColor:[UIColor greatistBlueColor] forState:UIControlStateNormal];
    [flagButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:10]];
    flagButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    flagButton.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    [flagButton setTitle:@"FLAG INAPPROPRIATE" forState:UIControlStateNormal];
    FAKFontAwesome *flagIcon = [FAKFontAwesome flagIconWithSize:15];
    [flagIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistBlueColor]];
    UIImage *flagImage = [[flagIcon imageWithSize:CGSizeMake(20, 20)] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    flagIcon.iconFontSize = 15;
    [flagButton setBackgroundImage:flagImage forState:UIControlStateNormal];
    [postDetailView addSubview:flagButton];
}

- (void)createResponses
{
    UIView *responseView = [[UIView alloc]initWithFrame:CGRectMake(0, 320, 320, 90)];
    [responseView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:responseView];
    
    UILabel *glassResponseCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 20, 20)];
    [glassResponseCountLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:12]];
    glassResponseCountLabel.textColor = [UIColor greatistPlayColor];
    glassResponseCountLabel.text = [NSString stringWithFormat:@"%@",self.responsesDictionary[@"cheers"]];
    [glassResponseCountLabel setTextAlignment:NSTextAlignmentCenter];
    [[glassResponseCountLabel layer] setBorderColor:[[UIColor greatistPlayColor] CGColor]];
    [[glassResponseCountLabel layer] setBorderWidth:1];
    [[glassResponseCountLabel layer] setCornerRadius:1];
    [glassResponseCountLabel drawTextInRect:CGRectMake(5, 5, 10, 10)];
    [responseView addSubview:glassResponseCountLabel];
    
    NSLog(@"%@",self.responsesDictionary[@"cheers"]);
    
    
    UIButton *glassButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [glassButton setFrame:CGRectMake(60, 20, 100, 20)];
    [glassButton setTitleColor:[UIColor greatistPlayColor] forState:UIControlStateNormal];
    [glassButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:12]];
    glassButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    glassButton.contentEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    [glassButton setTitle:@"CHEERS" forState:UIControlStateNormal];
    FAKFontAwesome *glassIcon = [FAKFontAwesome glassIconWithSize:20];
    [glassIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistPlayColor]];
    UIImage *glassImage = [[glassIcon imageWithSize:CGSizeMake(20, 20)] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    glassIcon.iconFontSize = 20;
    [glassButton setBackgroundImage:glassImage forState:UIControlStateNormal];
    [responseView addSubview:glassButton];
    
    
    UILabel *rocketResponseCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 20, 20)];
    [rocketResponseCountLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:12]];
    rocketResponseCountLabel.textColor = [UIColor greatistMoveColor];
    rocketResponseCountLabel.text = [NSString stringWithFormat:@"%@",self.responsesDictionary[@"you go, girl"]];
    [rocketResponseCountLabel setTextAlignment:NSTextAlignmentCenter];
    [[rocketResponseCountLabel layer] setBorderColor:[[UIColor greatistMoveColor] CGColor]];
    [[rocketResponseCountLabel layer] setBorderWidth:1];
    [[rocketResponseCountLabel layer] setCornerRadius:1];
    [rocketResponseCountLabel drawTextInRect:CGRectMake(5, 5, 10, 10)];
    [responseView addSubview:rocketResponseCountLabel];

    
    UIButton *rocketButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rocketButton setFrame:CGRectMake(60, 50, 100, 20)];
    [rocketButton setTitleColor:[UIColor greatistMoveColor] forState:UIControlStateNormal];
    [rocketButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:12]];
    rocketButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    rocketButton.contentEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    [rocketButton setTitle:@"YOU GO GIRL" forState:UIControlStateNormal];
    FAKFontAwesome *rocketIcon = [FAKFontAwesome rocketIconWithSize:20];
    [rocketIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistMoveColor]];
    UIImage *rocketImage = [[rocketIcon imageWithSize:CGSizeMake(20, 20)] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    rocketIcon.iconFontSize = 20;
    [rocketButton setBackgroundImage:rocketImage forState:UIControlStateNormal];
    [responseView addSubview:rocketButton];
    
    UILabel *smileResponseCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 20, 20, 20)];
    [smileResponseCountLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:12]];
    smileResponseCountLabel.textColor = [UIColor greatistGrowColor];
    smileResponseCountLabel.text = [NSString stringWithFormat:@"%@",self.responsesDictionary[@"smiles"]];
    [smileResponseCountLabel setTextAlignment:NSTextAlignmentCenter];
    [[smileResponseCountLabel layer] setBorderColor:[[UIColor greatistGrowColor] CGColor]];
    [[smileResponseCountLabel layer] setBorderWidth:1];
    [[smileResponseCountLabel layer] setCornerRadius:1];
    [smileResponseCountLabel drawTextInRect:CGRectMake(5, 5, 10, 10)];
    [responseView addSubview:smileResponseCountLabel];
    
    UIButton *smileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [smileButton setFrame:CGRectMake(180, 20, 100, 20)];
    [smileButton setTitleColor:[UIColor greatistGrowColor] forState:UIControlStateNormal];
    [smileButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:12]];
    smileButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    smileButton.contentEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    [smileButton setTitle:@"SMILES" forState:UIControlStateNormal];
    FAKFontAwesome *smileIcon = [FAKFontAwesome smileOIconWithSize:20];
    [smileIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistGrowColor]];
    UIImage *smileImage = [[smileIcon imageWithSize:CGSizeMake(20, 20)] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    smileIcon.iconFontSize = 20;
    [smileButton setBackgroundImage:smileImage forState:UIControlStateNormal];
    [responseView addSubview:smileButton];
    
    UILabel *frownResponseCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(270, 50, 20, 20)];
    [frownResponseCountLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:12]];
    frownResponseCountLabel.textColor = [UIColor greatistEatColor];
    frownResponseCountLabel.text = [NSString stringWithFormat:@"%@",self.responsesDictionary[@"hugs"]];
    [frownResponseCountLabel setTextAlignment:NSTextAlignmentCenter];
    [[frownResponseCountLabel layer] setBorderColor:[[UIColor greatistEatColor] CGColor]];
    [[frownResponseCountLabel layer] setBorderWidth:1];
    [[frownResponseCountLabel layer] setCornerRadius:1];
    [frownResponseCountLabel drawTextInRect:CGRectMake(5, 5, 10, 10)];
    [responseView addSubview:frownResponseCountLabel];
    
    UIButton *frownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [frownButton setFrame:CGRectMake(180, 50, 100, 20)];
    [frownButton setTitleColor:[UIColor greatistEatColor] forState:UIControlStateNormal];
    [frownButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:12]];
    frownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    frownButton.contentEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
    [frownButton setTitle:@"HUGS" forState:UIControlStateNormal];
    FAKFontAwesome *frownIcon = [FAKFontAwesome smileOIconWithSize:20];
    [frownIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistEatColor]];
    UIImage *frownImage = [[frownIcon imageWithSize:CGSizeMake(20, 20)] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    frownIcon.iconFontSize = 20;
    [frownButton setBackgroundImage:frownImage forState:UIControlStateNormal];
    [responseView addSubview:frownButton];

}
- (void)createResponsesVariantNoIcons
{
    UIView *responseView = [[UIView alloc]initWithFrame:CGRectMake(0, 430, 320, 90)];
    [responseView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:responseView];
    
    UILabel *glassResponseCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 20, 20)];
    [glassResponseCountLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:12]];
    glassResponseCountLabel.textColor = [UIColor greatistPlayColor];
    glassResponseCountLabel.text = [NSString stringWithFormat:@"%@",self.responsesDictionary[@"cheers"]];
    [glassResponseCountLabel setTextAlignment:NSTextAlignmentCenter];
    [[glassResponseCountLabel layer] setBorderColor:[[UIColor greatistPlayColor] CGColor]];
    [[glassResponseCountLabel layer] setBorderWidth:1];
    [[glassResponseCountLabel layer] setCornerRadius:1];
    [glassResponseCountLabel drawTextInRect:CGRectMake(5, 5, 10, 10)];
    [responseView addSubview:glassResponseCountLabel];
    
    UIButton *glassButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [glassButton setFrame:CGRectMake(60, 20, 80, 20)];
    [glassButton setTitleColor:[UIColor greatistPlayColor] forState:UIControlStateNormal];
    [glassButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:12]];
    glassButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [glassButton setTitle:@"CHEERS" forState:UIControlStateNormal];
    [responseView addSubview:glassButton];
    
    UILabel *rocketResponseCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 20, 20)];
    [rocketResponseCountLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:12]];
    rocketResponseCountLabel.textColor = [UIColor greatistMoveColor];
    rocketResponseCountLabel.text = [NSString stringWithFormat:@"%@",self.responsesDictionary[@"you go, girl"]];
    [rocketResponseCountLabel setTextAlignment:NSTextAlignmentCenter];
    [[rocketResponseCountLabel layer] setBorderColor:[[UIColor greatistMoveColor] CGColor]];
    [[rocketResponseCountLabel layer] setBorderWidth:1];
    [[rocketResponseCountLabel layer] setCornerRadius:1];
    [rocketResponseCountLabel drawTextInRect:CGRectMake(5, 5, 10, 10)];
    [responseView addSubview:rocketResponseCountLabel];
    
    UIButton *rocketButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rocketButton setFrame:CGRectMake(60, 50, 100, 20)];
    [rocketButton setTitleColor:[UIColor greatistMoveColor] forState:UIControlStateNormal];
    [rocketButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:12]];
    rocketButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [rocketButton setTitle:@"YOU GO GIRL" forState:UIControlStateNormal];
    [responseView addSubview:rocketButton];
    
    UILabel *smileResponseCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 20, 20, 20)];
    [smileResponseCountLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:12]];
    smileResponseCountLabel.textColor = [UIColor greatistGrowColor];
    smileResponseCountLabel.text = [NSString stringWithFormat:@"%@",self.responsesDictionary[@"smiles"]];
    [smileResponseCountLabel setTextAlignment:NSTextAlignmentCenter];
    [[smileResponseCountLabel layer] setBorderColor:[[UIColor greatistGrowColor] CGColor]];
    [[smileResponseCountLabel layer] setBorderWidth:1];
    [[smileResponseCountLabel layer] setCornerRadius:1];
    [smileResponseCountLabel drawTextInRect:CGRectMake(5, 5, 10, 10)];
    [responseView addSubview:smileResponseCountLabel];
    
    UIButton *smileButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [smileButton setFrame:CGRectMake(210, 20, 100, 20)];
    [smileButton setTitleColor:[UIColor greatistGrowColor] forState:UIControlStateNormal];
    [smileButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:12]];
    smileButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [smileButton setTitle:@"SMILES" forState:UIControlStateNormal];
    [responseView addSubview:smileButton];
    
    UILabel *frownResponseCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 50, 20, 20)];
    [frownResponseCountLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:12]];
    frownResponseCountLabel.textColor = [UIColor greatistEatColor];
    frownResponseCountLabel.text = [NSString stringWithFormat:@"%@",self.responsesDictionary[@"hugs"]];
    [frownResponseCountLabel setTextAlignment:NSTextAlignmentCenter];
    [[frownResponseCountLabel layer] setBorderColor:[[UIColor greatistEatColor] CGColor]];
    [[frownResponseCountLabel layer] setBorderWidth:1];
    [[frownResponseCountLabel layer] setCornerRadius:1];
    [frownResponseCountLabel drawTextInRect:CGRectMake(5, 5, 10, 10)];
    [responseView addSubview:frownResponseCountLabel];
    
    UIButton *frownButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [frownButton setFrame:CGRectMake(210, 50, 100, 20)];
    [frownButton setTitleColor:[UIColor greatistEatColor] forState:UIControlStateNormal];
    [frownButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:12]];
    frownButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [frownButton setTitle:@"HUGS" forState:UIControlStateNormal];
    [responseView addSubview:frownButton];
}

- (IBAction)backBarButtonItemTapped:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void) setUpResponsesDictionary
//{
//    NSArray *arrayOfResponses = [self.post.responses allObjects];
//    NSMutableDictionary *dictionaryToReturn = [NSMutableDictionary new];
//    
//    NSMutableSet *responseContents = [NSMutableSet new];
//    
//    for (Response *response in self.post.responses) {
//        [responseContents addObject:response.content];
//    }
//    
//    for (NSString *responseContent in responseContents) {
//        NSPredicate *contentSearch = [NSPredicate predicateWithFormat:@"content==%@",responseContent];
//        NSDictionary *entryForThisContent = @{responseContent: @([[arrayOfResponses filteredArrayUsingPredicate:contentSearch] count])};
//        [dictionaryToReturn addEntriesFromDictionary:entryForThisContent];
//    }
//    
//    self.responsesDictionary = dictionaryToReturn;
//}

- (void) setUpResponsesDictionary
{
//    self.responsesDictionary = [NSDictionary new];
    self.responsesDictionary = [self.post dictionaryOfResponses];
}

- (void) starterConfig
{
    NSMutableDictionary *responsesWithZeros = [NSMutableDictionary new];
    
    if (!self.responsesDictionary[@"cheers"])
    {
        NSDictionary *cheersEntry = @{@"cheers":@0};
        [responsesWithZeros addEntriesFromDictionary:cheersEntry];
    }
    
    if (!self.responsesDictionary[@"you go, girl"])
    {
        NSDictionary *cheersEntry = @{@"you go, girl":@0};
        [responsesWithZeros addEntriesFromDictionary:cheersEntry];
    }
    
    if (!self.responsesDictionary[@"smiles"])
    {
        NSDictionary *cheersEntry = @{@"smiles":@0};
        [responsesWithZeros addEntriesFromDictionary:cheersEntry];
    }
    
    if (!self.responsesDictionary[@"hugs"])
    {
        NSDictionary *cheersEntry = @{@"hugs":@0};
        [responsesWithZeros addEntriesFromDictionary:cheersEntry];
    }
    
    [responsesWithZeros addEntriesFromDictionary:self.responsesDictionary];
    
    self.responsesDictionary = responsesWithZeros;
}

@end

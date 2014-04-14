//
//  GRTArticlesViewController.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTArticlesViewController.h"
#import "GRTGreatistAPIClient.h"

@interface GRTArticlesViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *articleWebView;
@property (strong,nonatomic) GRTGreatistAPIClient *grtGreatistAPIClient;

@end

@implementation GRTArticlesViewController

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
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://greatist.com/fitness/scientifically-backed-cardio-tips-hacks"]];
    [self.articleWebView loadRequest:request];

    
    self.grtGreatistAPIClient = [GRTGreatistAPIClient new];
    [self.grtGreatistAPIClient retrieveArticlesWithCompletion:^(NSDictionary *articleDictionary) {
        NSLog(@"%@",articleDictionary);
        NSString *articleString = articleDictionary [@"articles"][0][@"body"];

# warning need to implement URL from greatist
        
        
      //  [self.articleWebView loadHTMLString:articleString baseURL:nil];
    
    }];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

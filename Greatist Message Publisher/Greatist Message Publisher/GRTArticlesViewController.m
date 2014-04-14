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
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://greatist.com/node/%@", self.article.nid]]];
    [self.articleWebView loadRequest:request];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  GRTPostDetailViewController.h
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post+Methods.h"

@interface GRTPostDetailViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) Post *post;

@end

//
//  GRTStepOneComposePost.h
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/14/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRTStepOneComposePost.h"

@interface GRTStepOneComposePost : UIView

@property (strong, nonatomic) IBOutlet UIView* selectVerticalView;
@property NSArray *verticals;
@property (weak, nonatomic) IBOutlet UIButton *healthButton;
@property (weak, nonatomic) IBOutlet UIButton *happinessButton;
@property (weak, nonatomic) IBOutlet UIButton *fitnessButton;
- (void)setupCategoryButtons;
@end

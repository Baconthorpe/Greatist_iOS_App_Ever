//
//  GRTSelectResponseViewController.h
//  Greatist Message Publisher
//
//  Created by Anne Lindsley on 4/16/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Section+Methods.h"

@interface GRTSelectResponseViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property NSString *content;

@property Section *verticalPassed;

@end

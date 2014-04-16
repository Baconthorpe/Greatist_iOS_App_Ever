//
//  GRTCornerTriangles.h
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/16/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GRTPostTableViewCell.h"

@interface GRTCornerTriangles : UIView


@property (nonatomic) GRTPostTableViewCell *cell;
@property (nonatomic) BOOL isLeftTriangle;
@property (strong, nonatomic)UIColor *fillColor;


-(void)drawLeftHRect;
-(void)drawRightHRect;



- (instancetype)initWithFrame:(CGRect)frame IsLeftTriangle: (BOOL)isLeftTriangle withFillColor:(UIColor *)fillColor;

@end

//
//  GRTCornerTriangles.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/16/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTCornerTriangles.h"
#import "GRTPostTableViewCell.h"

@implementation GRTCornerTriangles

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame IsLeftTriangle:NO withFillColor:self.fillColor];
}

- (instancetype)initWithFrame:(CGRect)frame IsLeftTriangle:(BOOL)isLeftTriangle withFillColor:(UIColor *)fillColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        _isLeftTriangle = isLeftTriangle;
        _fillColor = fillColor;
    
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawLeftHRect
{
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint: CGPointMake(0, 5.5)];
    [trianglePath addLineToPoint:CGPointMake(0,77)];
    [trianglePath addLineToPoint:CGPointMake(77, 5.5)];
    [trianglePath closePath];
    
    //[[UIColor greatistLightGrayColor] setStroke];
    [self.fillColor setFill];
    
    [trianglePath fill];
    //[trianglePath stroke];
}


//-(void)drawRightHRect
//{
//    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
//    [trianglePath moveToPoint: CGPointMake(320, 5)];
//    [trianglePath addLineToPoint:CGPointMake(320,70)];
//    [trianglePath addLineToPoint:CGPointMake(250, 5)];
//    [trianglePath closePath];
//    
//    [[UIColor greatistLightGrayColor] setStroke];
//    [self.fillColor setFill];
//    
//    [trianglePath fill];
//    [trianglePath stroke];
//}


- (void)drawRect:(CGRect)rect
{
    if (self.isLeftTriangle) {
        [self drawLeftHRect];
    }
//    else if (!self.isLeftTriangle)
//    {
//        [self drawRightHRect];
//    }
}




@end

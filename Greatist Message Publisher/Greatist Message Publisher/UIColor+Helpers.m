//
//  UIColor+Helpers.m
//  Greatist Message Publisher
//
//  Created by Leonard Li on 4/3/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "UIColor+Helpers.h"

@implementation UIColor (Helpers)

+ (UIColor *)greatistColorForCategory:(NSString *)categoryString
{
    if ([categoryString isEqualToString:@"Eat"]) {
        return [UIColor greatistEatColor];
    } else if ([categoryString isEqualToString:@"Move"]) {
        return [UIColor greatistMoveColor];
    } else if ([categoryString isEqualToString:@"Connect"]) {
        return [UIColor greatistConnectColor];
    } else if ([categoryString isEqualToString:@"Grow"]) {
        return [UIColor greatistGrowColor];
    } else if ([categoryString isEqualToString:@"Play"]) {
        return [UIColor greatistPlayColor];
    } else {
        return [UIColor greatistPrimaryColor];
    }
}

+ (UIColor *)greatistPrimaryColor
{
    return [UIColor colorWithRed:65/255.0 green:64/255.0 blue:66/255.0 alpha:1];
}

+ (UIColor *)greatistBlueColor
{
    return [UIColor colorWithRed:28/255.0 green:161/255.0 blue:200/255.0 alpha:1];
}

+ (UIColor *)greatistGrayColor
{
    return [UIColor colorWithRed:65/255.0 green:64/255.0 blue:66/255.0 alpha:1];
}

+ (UIColor *)greatistLightGrayColor
{
    return [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
}

+ (UIColor *)greatistEatColor
{
    return [UIColor colorWithRed:1/255.0 green:178/255.0 blue:148/255.0 alpha:1];
}

+ (UIColor *)greatistGrowColor
{
    return [UIColor colorWithRed:244/255.0 green:201/255.0 blue:21/255.0 alpha:1];
}

+ (UIColor *)greatistMoveColor
{
    return [UIColor colorWithRed:242/255.0 green:102/255.0 blue:48/255.0 alpha:1];
}

+ (UIColor *)greatistPlayColor
{
    return [UIColor colorWithRed:119/255.0 green:86/255.0 blue:164/255.0 alpha:1];
}
+ (UIColor *)greatistConnectColor
{
    return [UIColor colorWithRed:177/255.0 green:49/255.0 blue:131/255.0 alpha:1];
}

+ (UIColor *)greatistEatColorLight
{
    return [UIColor colorWithRed:1/255.0 green:178/255.0 blue:148/255.0 alpha:.1];
}

+ (UIColor *)greatistGrowColorLight
{
    return [UIColor colorWithRed:244/255.0 green:201/255.0 blue:21/255.0 alpha:.1];
}

+ (UIColor *)greatistMoveColorLight
{
    return [UIColor colorWithRed:242/255.0 green:102/255.0 blue:48/255.0 alpha:.1];
}

+ (UIColor *)greatistPlayColorLight
{
    return [UIColor colorWithRed:119/255.0 green:86/255.0 blue:164/255.0 alpha:.1];
}
+ (UIColor *)greatistConnectColorLight
{
    return [UIColor colorWithRed:177/255.0 green:49/255.0 blue:131/255.0 alpha:.1];
}

@end

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
    if ([categoryString isEqualToString:@"health"]) {
        return [UIColor greatistHealthColor];
    } else if ([categoryString isEqualToString:@"fitness"]) {
        return [UIColor greatistFitnessColor];
    }
    else if ([categoryString isEqualToString:@"happiness"]) {
        return [UIColor greatistHappinessColor];
    } else {
        return [UIColor greatistPrimaryColor];
    }
}

#pragma mark- greatist primary colors

+ (UIColor *)greatistPrimaryColor
{
    // dark grey
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


#pragma mark- greatist tri-category


+ (UIColor *)greatistHealthColor
{
    return [UIColor colorWithRed:1/255.0 green:178/255.0 blue:148/255.0 alpha:1];
}

+ (UIColor *)greatistHealthColorSecondary
{
    return [UIColor colorWithRed:0/255.0 green:124/255.0 blue:87/255.0 alpha:1];
}

+ (UIColor *)greatistHappinessColor
{
    return [UIColor colorWithRed:244/255.0 green:201/255.0 blue:21/255.0 alpha:1];
}

+ (UIColor *)greatistHappinessColorSecondary
{
    return [UIColor colorWithRed:233/255.0 green:158/255.0 blue:2/255.0 alpha:1];
}
+ (UIColor *)greatistFitnessColor
{
    return [UIColor colorWithRed:242/255.0 green:102/255.0 blue:48/255.0 alpha:1];
}

+ (UIColor *)greatistFitnessColorSecondary
{
     return [UIColor colorWithRed:215/255.0 green:38/255.0 blue:9/255.0 alpha:1];
}



#pragma mark- greatist six categories
+ (UIColor *)greatistEatColor
{
    return [UIColor colorWithRed:1/255.0 green:178/255.0 blue:148/255.0 alpha:1];
}

+ (UIColor *)greatistEatColorSecondary
{
    return [UIColor colorWithRed:0/255.0 green:124/255.0 blue:87/255.0 alpha:1];
}

+ (UIColor *)greatistGrowColor
{
    return [UIColor colorWithRed:244/255.0 green:201/255.0 blue:21/255.0 alpha:1];
}
+ (UIColor *)greatistGrowColorSecondary
{
     return [UIColor colorWithRed:233/255.0 green:158/255.0 blue:2/255.0 alpha:1];
}
+ (UIColor *)greatistMoveColor
{
    return [UIColor colorWithRed:242/255.0 green:102/255.0 blue:48/255.0 alpha:1];
}
+ (UIColor *)greatistMoveColorSecondary
{
    return [UIColor colorWithRed:215/255.0 green:38/255.0 blue:9/255.0 alpha:1];
}
+ (UIColor *)greatistPlayColor
{
    return [UIColor colorWithRed:119/255.0 green:86/255.0 blue:164/255.0 alpha:1];
}
+ (UIColor *)greatistPlayColorSecondary
{
    return [UIColor colorWithRed:56/255.0 green:29/255.0 blue:105/255.0 alpha:1];
}
+ (UIColor *)greatistConnectColor
{
    return [UIColor colorWithRed:177/255.0 green:49/255.0 blue:131/255.0 alpha:1];
}
+ (UIColor *)greatistConnectColorSecondary
{
    return [UIColor colorWithRed:123/255.0 green:9/255.0 blue:67/255.0 alpha:1];
}
+ (UIColor *)greatistDiscoverColor
{
    return [UIColor colorWithRed:108/255.0 green:202/255.0 blue:205/255.0 alpha:1];
}
+ (UIColor *)greatistDiscoverColorSecondary
{
    return [UIColor colorWithRed:46/255.0 green:160/255.0 blue:165/255.0 alpha:1];
}

@end


//+ (UIColor *)greatistEatColorLight
//{
//    return [UIColor colorWithRed:1/255.0 green:178/255.0 blue:148/255.0 alpha:.1];
//}
//
//+ (UIColor *)greatistGrowColorLight
//{
//    return [UIColor colorWithRed:244/255.0 green:201/255.0 blue:21/255.0 alpha:.1];
//}
//
//+ (UIColor *)greatistMoveColorLight
//{
//    return [UIColor colorWithRed:242/255.0 green:102/255.0 blue:48/255.0 alpha:.1];
//}
//
//+ (UIColor *)greatistPlayColorLight
//{
//    return [UIColor colorWithRed:119/255.0 green:86/255.0 blue:164/255.0 alpha:.1];
//}
//+ (UIColor *)greatistConnectColorLight
//{
//    return [UIColor colorWithRed:177/255.0 green:49/255.0 blue:131/255.0 alpha:.1];
//}


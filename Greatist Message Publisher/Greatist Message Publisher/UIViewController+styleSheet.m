//
//  UIViewController+styleSheet.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/3/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "UIViewController+styleSheet.h"

@implementation UIViewController (styleSheet)



+ (void)setupNavigationBar:(UINavigationBar *)navBar WithbackgroundImage:(UIImage *)navBarImage ForView:(UIView *)view
{
    UIImage *navBackgroundImage = [UIImage imageNamed:@"navBar.png"];
    [navBar setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];
    
}

//+ (void)setNavigationBar:(UINavigationBar *)navBar WithLogoImage:(UIImage *)logoImage
//{
//    UIImage *greatistLogo = [UIImage imageNamed:@"Greatist_Logo86x50.png"];
//    UIImageView *myImageView = [UIImageView ]
//    [navBar.topItem setTitleView:greatistLogo];
//}

@end

//
//  UIImage+Helpers.m
//  Greatist Message Publisher
//
//  Created by Leonard Li on 4/3/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "UIImage+Helpers.h"

@implementation UIImage (Helpers)

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    
    // Usage: UIImage *myIcon = [UIImage imageWithImage:myUIImageInstance scaledToSize:CGSizeMake(20, 20)];
    
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end

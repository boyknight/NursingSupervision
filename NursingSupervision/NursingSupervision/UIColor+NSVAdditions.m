//
//  UIColor+Addition.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/5/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "UIColor+NSVAdditions.h"

@implementation UIColor(NSVAdditions)

+(UIColor*) colorWithRGBHex:(NSInteger)rgbHex{
    return [UIColor colorWithRed:((CGFloat)((rgbHex & 0xFF0000) >> 16)) / 255.0
                           green:((CGFloat)((rgbHex & 0xFF00) >> 8)) / 255.0
                            blue:((CGFloat)(rgbHex & 0xFF)) / 255.0
                           alpha:1.0f];
}

@end

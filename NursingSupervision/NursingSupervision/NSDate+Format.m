//
//  NSDate+Format.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/7/12.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSDate+Format.h"

@implementation NSDate (Format)

-(NSString*) toStringWithFormatYYYY_MM_DD_HH_MM_Chinese{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH时mm分"];
    
    return [dateFormatter stringFromDate:self];
}

-(NSString*) toStringWithFormatYYYY_MM_DD_HH_MM{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    return [dateFormatter stringFromDate:self];
}

@end

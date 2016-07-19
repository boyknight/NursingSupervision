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

-(NSString*) toStringWithFormatYYYYDotMMDotDD{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    
    return [dateFormatter stringFromDate:self];
}

-(NSString*) toStringWithFormatYYYYMMDDHHMM{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmm"];
    
    return [dateFormatter stringFromDate:self];
}

-(NSDate*) dateOfDayLastSecond{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString* dateString = [NSString stringWithFormat:@"%04d-%02d-%02d 23:59:59", [self year], [self month], [self dayOfMonth]];
    
    return [dateFormatter dateFromString:dateString];
}



-(NSDate*) dateOfDayFirstSecond{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString* dateString = [NSString stringWithFormat:@"%04d-%02d-%02d 00:00:00", [self year], [self month], [self dayOfMonth]];
    
    return [dateFormatter dateFromString:dateString];
}



-(NSInteger) year{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents* comps  = [calendar components:unitFlags fromDate:self];
    
    return [comps year];
}

-(NSInteger) month{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents* comps  = [calendar components:unitFlags fromDate:self];
    
    return [comps month];
}

-(NSInteger) dayOfMonth{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents* comps  = [calendar components:unitFlags fromDate:self];
    
    return [comps day];
}

-(NSInteger) hour{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents* comps  = [calendar components:unitFlags fromDate:self];
    
    return [comps hour];
}

-(NSInteger) minute{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents* comps  = [calendar components:unitFlags fromDate:self];
    
    return [comps minute];
}

-(NSInteger) second{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents* comps  = [calendar components:unitFlags fromDate:self];
    
    return [comps second];
}

@end

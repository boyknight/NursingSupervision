//
//  NSDate+Format.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/7/12.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)

-(NSString*) toStringWithFormatYYYY_MM_DD_HH_MM_Chinese;
-(NSString*) toStringWithFormatYYYY_MM_DD_HH_MM;
-(NSString*) toStringWithFormatYYYYDotMMDotDD;
-(NSString*) toStringWithFormatYYYYMMDDHHMM;

-(NSDate*) dateOfDayLastSecond;
-(NSDate*) dateOfDayFirstSecond;

-(NSInteger) year;
-(NSInteger) month;
-(NSInteger) dayOfMonth;
-(NSInteger) hour;
-(NSInteger) minute;
-(NSInteger) second;

@end

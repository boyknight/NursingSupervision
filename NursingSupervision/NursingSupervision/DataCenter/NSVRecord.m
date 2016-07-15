//
//  NSVRecord.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVRecord.h"
#import "NSString+SHA.h"

@implementation NSVRecord

-(instancetype) init{
    self = [super init];
    
    if (self != nil) {
        self.uid = [NSString sha256Uid];
        self.recordDate = [NSDate date];
    }
    
    return self;
}

@end

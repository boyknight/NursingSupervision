//
//  NSVRecord.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVRecord.h"

@implementation NSVRecord

+ (NSString *) primaryKey
{
    return @"recordId";
}

-(nonnull instancetype) initWithNuser:(nonnull NSVNurse*) nurse issue:(nonnull NSVIssue*)issue{
    self = [super init];
    if (self != nil) {
        self.nurse = nurse;
        self.issue = issue;
        self.recordDate = [NSDate date];
    }
    return self;
}

@end

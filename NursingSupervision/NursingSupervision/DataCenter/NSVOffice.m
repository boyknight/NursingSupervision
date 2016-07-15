//
//  NSVOffice.m
//  NursingSupervision
//
//  Created by 杨志勇 on 16/6/27.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import "NSVOffice.h"
#import "NSString+SHA.h"

@implementation NSVOffice

-(instancetype) init{
    self = [super init];
    
    if (self != nil) {
        self.uid = [NSString sha256Uid];
    }
    
    return self;
}

@end

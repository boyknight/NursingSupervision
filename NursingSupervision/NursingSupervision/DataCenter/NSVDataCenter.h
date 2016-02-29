//
//  NSVDataCenter.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSVAssessment.h"

@interface NSVDataCenter : NSObject

@property (nonatomic, strong, readonly) NSVAssessment* assessment;

+(instancetype) defaultCenter;

@end

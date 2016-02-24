//
//  NSVPosition.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <OLCOrm/OLCOrm.h>
#include "OCLModel.h"

@interface NSVPosition : OCLModel

@property (nonatomic, assign) NSInteger classId;
@property (nonatomic, assign) NSInteger projectId;

@property (nonatomic, assign) NSInteger positionId;

@property (nonatomic, strong) NSString* requirement;
@property (nonatomic, strong) NSString* position;



@end

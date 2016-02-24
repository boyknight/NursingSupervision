//
//  NSVClass.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCLModel.h"


@interface NSVClass : OCLModel

@property (nonatomic, assign) NSInteger classId;
@property (nonatomic, strong) NSString* name;

@end

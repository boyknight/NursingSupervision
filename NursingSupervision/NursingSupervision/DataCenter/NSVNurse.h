//
//  NSVNurse.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/2/24.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModelLib.h"

@interface NSVNurse : JSONModel

@property (nonatomic, assign) NSInteger nurseId;
@property (nonatomic, strong) NSString* name;

@end

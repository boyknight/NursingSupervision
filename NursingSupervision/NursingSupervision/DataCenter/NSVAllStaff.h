//
//  NSVAllStaff.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/6/27.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "NSVOffice.h"

@protocol NSVAllStaff <NSObject>

@end

@interface NSVAllStaff : JSONModel

@property (nonatomic, strong) NSMutableArray<NSVOffice>* offices;

@end

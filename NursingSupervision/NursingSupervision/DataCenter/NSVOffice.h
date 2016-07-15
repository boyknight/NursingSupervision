//
//  NSVOffice.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/6/27.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "NSVNurse.h"

@protocol NSVOffice <NSObject>

@end

@interface NSVOffice : JSONModel

@property (nonatomic, strong) NSString* uid;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSMutableArray<NSVNurse>* nurses;

@end

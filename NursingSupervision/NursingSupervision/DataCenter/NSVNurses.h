//
//  NSVNurses.h
//  NursingSupervision
//
//  Created by 杨志勇 on 16/6/14.
//  Copyright © 2016年 yx Studio. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "NSVNurse.h"

@interface NSVNurses : JSONModel

@property (nonatomic, strong) NSMutableArray<NSVNurse>* nurses;

@end
